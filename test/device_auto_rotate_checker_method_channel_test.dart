import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:device_auto_rotate_checker/device_auto_rotate_checker_method_channel.dart';

void main() {
  MethodChannelDeviceAutoRotateChecker platform =
      MethodChannelDeviceAutoRotateChecker();
  const MethodChannel channel = MethodChannel('device_auto_rotate_checker');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return true;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('checkAutoRotate', () async {
    expect(await platform.checkAutoRotate(), true);
  });
}
