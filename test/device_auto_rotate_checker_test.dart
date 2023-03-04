import 'package:flutter_test/flutter_test.dart';
import 'package:device_auto_rotate_checker/device_auto_rotate_checker.dart';
import 'package:device_auto_rotate_checker/device_auto_rotate_checker_platform_interface.dart';
import 'package:device_auto_rotate_checker/device_auto_rotate_checker_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDeviceAutoRotateCheckerPlatform
    with MockPlatformInterfaceMixin
    implements DeviceAutoRotateCheckerPlatform {
  @override
  Future<bool> checkAutoRotate() => Future.value(true);

  @override
  Stream<bool> get autoRotateStream => Stream.value(true);
}

void main() {
  final DeviceAutoRotateCheckerPlatform initialPlatform =
      DeviceAutoRotateCheckerPlatform.instance;

  test('$MethodChannelDeviceAutoRotateChecker is the default instance', () {
    expect(
        initialPlatform, isInstanceOf<MethodChannelDeviceAutoRotateChecker>());
  });

  test('checkAutoRotate', () async {
    MockDeviceAutoRotateCheckerPlatform fakePlatform =
        MockDeviceAutoRotateCheckerPlatform();
    DeviceAutoRotateCheckerPlatform.instance = fakePlatform;

    expect(await DeviceAutoRotateChecker.checkAutoRotate(), true);
  });
}
