import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'device_auto_rotate_checker_platform_interface.dart';

/// An implementation of [DeviceAutoRotateCheckerPlatform] that uses method channels.
class MethodChannelDeviceAutoRotateChecker
    extends DeviceAutoRotateCheckerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('device_auto_rotate_checker');

  final EventChannel eventChannel = const EventChannel('device_auto_rotate_event');

  Stream<bool>? _autoRotateStream;

  /// Check device auto rotate
  @override
    Future<bool> checkAutoRotate() async {
    final autoRotate =
        await methodChannel.invokeMethod<bool>('checkAutoRotate');
    return autoRotate ?? false;
  }

  /// Listen to the device's auto rotate settings change
  @override
  Stream<bool> get autoRotateStream {
    _autoRotateStream ??= eventChannel.receiveBroadcastStream().cast();
    return _autoRotateStream!;
  }
}
