package com.myfatoorahflutter.myfatoorah_flutter

import android.content.Intent
import com.myfatoorahflutter.myfatoorah_flutter.crossplatform.IMFListener
import com.myfatoorahflutter.myfatoorah_flutter.crossplatform.MyfatoorahModule
import com.myfatoorahflutter.myfatoorah_flutter.crossplatform.utils.MFConstants
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.PluginRegistry

/** MyfatoorahFlutterPlugin */
class MyfatoorahFlutterPlugin : FlutterPlugin, ActivityAware,
    PluginRegistry.ActivityResultListener {

    val myfatoorahModule = MyfatoorahModule()
    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        MfSDKHelper.MFSDKHelper.setup(flutterPluginBinding.binaryMessenger, myfatoorahModule)

        val cardViewFactory = CardViewFactory()
        myfatoorahModule.cardViewFactory = cardViewFactory
        flutterPluginBinding.platformViewRegistry.registerViewFactory(
            MFConstants.MFCardViewModuleNAME,
            cardViewFactory
        )

        val googlePayButtonFactory = GooglePayButtonFactory()
        myfatoorahModule.googlePayButtonFactory = googlePayButtonFactory
        flutterPluginBinding.platformViewRegistry.registerViewFactory(
            MFConstants.MFGooglePayButtonModuleNAME,
            googlePayButtonFactory
        )

        val eventChannel =
            EventChannel(flutterPluginBinding.binaryMessenger, MFConstants.MFEventChannelName)
        val streamHandler: StreamHandler = object : StreamHandler {
            override fun onListen(arguments: Any?, events: EventSink?) {
                events?.let {
                    val eventHandler = MainThreadEventHandler(it)
                    myfatoorahModule.mfListener = object : IMFListener {
                        override fun OnInvoiceCreated(invoiceId: String) {
                            eventHandler.success(invoiceId)
                        }

                        override fun OnCardBinChanged(bin: String) {
                            eventHandler.success(bin)
                        }

                        override fun OnCardHeightChanged(height: Float) {
                            eventHandler.success(height)
                        }
                    }
                }
            }

            override fun onCancel(arguments: Any?) {}
        }
        eventChannel.setStreamHandler(streamHandler)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        myfatoorahModule.activity = binding.activity
        myfatoorahModule.cardViewFactory?.EnableNFC(binding.activity)
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        myfatoorahModule.activity = null
        myfatoorahModule.cardViewFactory?.DisableNFC()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        myfatoorahModule.activity = binding.activity
        myfatoorahModule.cardViewFactory?.EnableNFC(binding.activity)
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivity() {
        myfatoorahModule.activity = null
        myfatoorahModule.cardViewFactory?.DisableNFC()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (myfatoorahModule.mfGooglePayHelper != null)
            if (requestCode == MFConstants.GooglePayRequestCODE)
                myfatoorahModule.mfGooglePayHelper.onActivityResult(requestCode, resultCode, data)
        return false
    }
}