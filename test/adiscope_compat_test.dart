import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revup_flutter_plugin/adiscope_compat.dart';

/// Adiscope 호환 레이어가 Revup 네이티브 채널로 올바르게 위임되는지 검증한다.
/// (예전 이름으로 호출 → revup_flutter_plugin 채널에 올바른 method/arguments 도달)
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('revup_flutter_plugin');
  final List<MethodCall> log = <MethodCall>[];

  setUp(() {
    log.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      log.add(methodCall);
      // getSDKVersion/getNetworkVersions는 String, 나머지는 bool을 기대한다.
      if (methodCall.method.startsWith('get') &&
          !methodCall.method.startsWith('getUnitStatus')) {
        return '1.0.0';
      }
      if (methodCall.method.startsWith('getUnitStatus')) {
        return <String, dynamic>{'live': true, 'active': true};
      }
      return true;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('setUserId가 revup 채널로 위임된다', () async {
    final plugin = AdiscopeFlutterPlugin();

    final result = await plugin.setUserId('sktair_user');

    expect(result, isTrue);
    expect(log, hasLength(1));
    expect(log.single.method, 'setUserId');
    expect(log.single.arguments, <String, dynamic>{'userId': 'sktair_user'});
  });

  test('initialize가 인자와 함께 위임된다', () async {
    final plugin = AdiscopeFlutterPlugin();

    await plugin.initialize('23', 'secret', 'tag', 'N');

    expect(log.single.method, 'initialize');
    expect(log.single.arguments, <String, dynamic>{
      'mediaId': '23',
      'mediaSecret': 'secret',
      'callbackTag': 'tag',
      'childYN': 'N',
    });
  });

  test('RewardedVideo 흐름이 위임된다', () async {
    final plugin = AdiscopeFlutterPlugin();

    await plugin.rewardedVideoLoad('ADMOB');
    await plugin.rewardedVideoIsLoad('ADMOB');
    await plugin.rewardedVideoShow();

    expect(log.map((c) => c.method), <String>[
      'rewardedVideoLoad',
      'rewardedVideoIsLoad',
      'rewardedVideoShow',
    ]);
    expect(log.first.arguments, <String, dynamic>{'unitId': 'ADMOB'});
  });

  test('RewardedInterstitial 흐름이 위임된다', () async {
    final plugin = AdiscopeFlutterPlugin();

    await plugin.loadRewardedInterstitial('RI_TEST');
    await plugin.showWithPopupRewardedInterstitial('RI_TEST');

    expect(log.map((c) => c.method), <String>[
      'loadRewardedInterstitial',
      'showWithPopupRewardedInterstitial',
    ]);
  });

  test('getUnitStatus가 Map을 반환한다', () async {
    final plugin = AdiscopeFlutterPlugin();

    final status = await plugin.getUnitStatus('ADMOB');

    expect(status, <String, dynamic>{'live': true, 'active': true});
  });

  test('LuckyEvent가 위임된다', () async {
    final plugin = AdiscopeFlutterPlugin();

    await plugin.setLuckyEventAppId('844663', 'pub-id');
    await plugin.showLuckyEvent();

    expect(log.map((c) => c.method),
        <String>['setLuckyEventAppId', 'showLuckyEvent']);
  });

  test('AdiscopeListener 채널이 revup 채널을 가리킨다', () {
    expect(AdiscopeListener.listenerRewardedVideoChannel.name,
        'revupRewardedVideoListener');
    expect(AdiscopeListener.listenerInterstitialChannel.name,
        'revupInterstitialListener');
    expect(AdiscopeListener.listenerRewardedInterstitialChannel.name,
        'revupRewardedInterstitialListener');
    expect(AdiscopeListener.listenerLuckyEventChannel.name,
        'revupLuckyEventListener');
  });

  test('AdiscopeListener 콜백이 네이티브 이벤트를 수신한다', () async {
    String? loadedUnitId;
    await AdiscopeListener.setupRewardedVideoListener(
      onRewardedVideoAdLoaded: (unitId) => loadedUnitId = unitId,
    );

    // 네이티브가 revup 리스너 채널로 이벤트를 보냈다고 가정한다.
    await TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .handlePlatformMessage(
      'revupRewardedVideoListener',
      const StandardMethodCodec().encodeMethodCall(
        const MethodCall('onRewardedVideoAdLoaded', 'ADMOB'),
      ),
      (_) {},
    );

    expect(loadedUnitId, 'ADMOB');
  });
}
