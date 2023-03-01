
import 'device_auto_rotate_checker_platform_interface.dart';

class DeviceAutoRotateChecker {
  static Future<bool> checkAutoRotate() {
    return DeviceAutoRotateCheckerPlatform.instance.checkAutoRotate();
  }

  static Stream<bool> autoRotateStream() {
    return DeviceAutoRotateCheckerPlatform.instance.autoRotateStream();
  }
}
