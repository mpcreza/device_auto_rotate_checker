package com.example.device_auto_rotate_checker

import android.content.ContentResolver
import android.provider.Settings
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** DeviceAutoRotateCheckerPlugin */
class DeviceAutoRotateCheckerPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var autoRotateEventChannel: EventChannel

    private lateinit var contentResolver: ContentResolver

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "device_auto_rotate_checker")
        channel.setMethodCallHandler(this)

        contentResolver = flutterPluginBinding.applicationContext.contentResolver

        flutterPluginBinding.applicationContext.contentResolver
        autoRotateEventChannel =
            EventChannel(flutterPluginBinding.binaryMessenger, "device_auto_rotate_event")
        autoRotateEventChannel.setStreamHandler(AutoRotateStreamHandler(contentResolver))
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "checkAutoRotate") {
            result.success(checkAutoRotate())
        } else {
            result.notImplemented()
        }
    }

    private fun checkAutoRotate(): Boolean {
        return Settings.System.getInt(
            contentResolver,
            Settings.System.ACCELEROMETER_ROTATION,
            0
        ) == 1
    }


    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        autoRotateEventChannel.setStreamHandler(null)
    }
}
