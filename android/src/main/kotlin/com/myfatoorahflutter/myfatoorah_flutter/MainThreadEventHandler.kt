package com.myfatoorahflutter.myfatoorah_flutter

import android.os.Handler
import android.os.Looper
import io.flutter.plugin.common.EventChannel

internal class MainThreadEventHandler(eventSink: EventChannel.EventSink) : EventChannel.EventSink {
    private val eventSink: EventChannel.EventSink
    private val handler: Handler

    init {
        this.eventSink = eventSink
        handler = Handler(Looper.getMainLooper())
    }

    override fun success(event: Any?) {
        handler.post { eventSink.success(event) }
    }

    override fun error(errorCode: String?, errorMessage: String?, errorDetails: Any?) {
        handler.post { eventSink.error(errorCode, errorMessage, errorDetails) }
    }

    override fun endOfStream() {}
}