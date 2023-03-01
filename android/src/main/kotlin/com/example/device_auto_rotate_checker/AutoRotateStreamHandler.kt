package com.example.device_auto_rotate_checker

import android.content.ContentResolver
import android.database.ContentObserver
import android.os.Handler
import android.os.Looper
import android.provider.Settings
import io.flutter.plugin.common.EventChannel

class AutoRotateStreamHandler(private val contentResolver: ContentResolver) :
    EventChannel.StreamHandler {
    private var sink: EventChannel.EventSink? = null

    init {
        val contentObserver: ContentObserver =
            object : ContentObserver(Handler(Looper.getMainLooper())) {
                override fun onChange(selfChange: Boolean) {
                    sendAutoRotate();
                }
            }
        contentResolver.registerContentObserver(
            Settings.System.getUriFor(Settings.System.ACCELEROMETER_ROTATION),
            false, contentObserver
        )
    }

    private fun checkAutoRotate(): Boolean {
        return Settings.System.getInt(
            contentResolver,
            Settings.System.ACCELEROMETER_ROTATION,
            0
        ) == 1
    }

    private fun sendAutoRotate() {
        sink?.success(checkAutoRotate())
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        sink = events
    }

    override fun onCancel(arguments: Any?) {
        sink = null
    }
}