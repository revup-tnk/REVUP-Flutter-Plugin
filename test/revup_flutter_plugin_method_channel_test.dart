import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revup_flutter_plugin/revup_flutter_plugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final MethodChannelRevupFlutterPlugin platform =
      MethodChannelRevupFlutterPlugin();
  const MethodChannel channel = MethodChannel('revup_flutter_plugin');

  final List<MethodCall> calls = <MethodCall>[];

  setUp(() {
    calls.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      calls.add(methodCall);
      return true;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('채널 이름은 revup_flutter_plugin 이다', () {
    // Android(RevupFlutterPlugin.kt)·iOS(RevupFlutterPlugin.swift)가 같은
    // 문자열로 채널을 등록한다. 한쪽만 바뀌면 그 플랫폼의 모든 호출이 조용히
    // MissingPluginException 으로 떨어지므로 이름 자체를 고정한다.
    expect(platform.methodChannel.name, 'revup_flutter_plugin');
  });

  test('initialize 는 채널로 인자를 그대로 전달한다', () async {
    final result = await platform.initialize('mid', 'msec', 'tag', 'N');

    expect(result, isTrue);
    expect(calls, hasLength(1));
    expect(calls.single.method, 'initialize');
    expect(calls.single.arguments, <String, dynamic>{
      'mediaId': 'mid',
      'mediaSecret': 'msec',
      'callbackTag': 'tag',
      'childYN': 'N',
    });
  });
}
