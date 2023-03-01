import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'device_auto_rotate_checker_method_channel.dart';

abstract class DeviceAutoRotateCheckerPlatform extends PlatformInterface {
  /// Constructs a DeviceAutoRotateCheckerPlatform.
  DeviceAutoRotateCheckerPlatform() : super(token: _token);

  static final Object _token = Object();

  static DeviceAutoRotateCheckerPlatform _instance = MethodChannelDeviceAutoRotateChecker();

  /// The default instance of [DeviceAutoRotateCheckerPlatform] to use.
  ///
  /// Defaults to [MethodChannelDeviceAutoRotateChecker].
  static DeviceAutoRotateCheckerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DeviceAutoRotateCheckerPlatform] when
  /// they register themselves.
  static set instance(DeviceAutoRotateCheckerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> checkAutoRotate() {
    throw UnimplementedError('checkAutoRotate() has not been implemented.');
  }

  Stream<bool> autoRotateStream() {
    throw UnimplementedError('autoRotateStream() has not been implemented.');
  }
}
