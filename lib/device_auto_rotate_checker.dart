
import 'device_auto_rotate_checker_platform_interface.dart';

class DeviceAutoRotateChecker {

  /// Check device auto rotate
  static Future<bool> checkAutoRotate() {
    return DeviceAutoRotateCheckerPlatform.instance.checkAutoRotate();
  }

  /// Listen to the device's auto rotate settings change
  static Stream<bool> get autoRotateStream {
    return DeviceAutoRotateCheckerPlatform.instance.autoRotateStream;
  }
}
