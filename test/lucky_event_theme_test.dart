import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revup_flutter_plugin/revup_flutter_plugin.dart';
import 'package:revup_flutter_plugin/revup_flutter_plugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('revup_flutter_plugin');
  final MethodChannelRevupFlutterPlugin platform =
      MethodChannelRevupFlutterPlugin();

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

  test('네이티브로 넘기는 문자열은 light/dark/system 이다', () {
    // 네이티브(Android LuckyEventTheme, iOS UIUserInterfaceStyle 매핑)와
    // 문자열이 어긋나면 설정이 조용히 무시되므로 값 자체를 고정한다.
    expect(RevupLuckyEventTheme.light.value, 'light');
    expect(RevupLuckyEventTheme.dark.value, 'dark');
    expect(RevupLuckyEventTheme.system.value, 'system');
  });

  test('setLuckyEventTheme 는 theme 인자로 값을 전달한다', () async {
    for (final theme in RevupLuckyEventTheme.values) {
      calls.clear();

      final result = await platform.setLuckyEventTheme(theme);

      expect(result, isTrue);
      expect(calls, hasLength(1));
      expect(calls.single.method, 'setLuckyEventTheme');
      expect(calls.single.arguments, <String, dynamic>{'theme': theme.value});
    }
  });
}
