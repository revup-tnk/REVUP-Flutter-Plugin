import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:revup_flutter_plugin/revup_flutter_plugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelRevupFlutterPlugin platform = MethodChannelRevupFlutterPlugin();
  const MethodChannel channel = MethodChannel('revup_flutter_plugin');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });
}
