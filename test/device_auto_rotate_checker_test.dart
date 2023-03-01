import 'package:flutter_test/flutter_test.dart';
import 'package:device_auto_rotate_checker/device_auto_rotate_checker.dart';
import 'package:device_auto_rotate_checker/device_auto_rotate_checker_platform_interface.dart';
import 'package:device_auto_rotate_checker/device_auto_rotate_checker_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDeviceAutoRotateCheckerPlatform
    with MockPlatformInterfaceMixin
    implements DeviceAutoRotateCheckerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DeviceAutoRotateCheckerPlatform initialPlatform = DeviceAutoRotateCheckerPlatform.instance;

  test('$MethodChannelDeviceAutoRotateChecker is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDeviceAutoRotateChecker>());
  });

  test('getPlatformVersion', () async {
    DeviceAutoRotateChecker deviceAutoRotateCheckerPlugin = DeviceAutoRotateChecker();
    MockDeviceAutoRotateCheckerPlatform fakePlatform = MockDeviceAutoRotateCheckerPlatform();
    DeviceAutoRotateCheckerPlatform.instance = fakePlatform;

    expect(await deviceAutoRotateCheckerPlugin.getPlatformVersion(), '42');
  });
}
