package com.mufeng.base_framework

import android.app.Application
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.util.Log
import androidx.annotation.NonNull
import androidx.core.content.FileProvider
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import java.io.File

/** BaseFrameworkPlugin */
class BaseFrameworkPlugin : FlutterPlugin, ActivityAware, MethodCallHandler {

    companion object {
        const val PLUGIN_NAME = "com.mufeng.base_framework"

        lateinit var mContext: Context

        @JvmStatic
        fun registerWith(registrar: PluginRegistry.Registrar) {
            this.mContext = registrar.activity()
            val channel = MethodChannel(registrar.messenger(), PLUGIN_NAME)
            channel.setMethodCallHandler(BaseFrameworkPlugin())
        }

    }

    private var mMethodChannel: MethodChannel? = null
    private var mApplication: Application? = null

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        val channel = MethodChannel(binding.binaryMessenger, PLUGIN_NAME)
        channel.setMethodCallHandler(BaseFrameworkPlugin())
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "install_apk" -> call.argument<String>("path")?.also { invokeInstall(mContext, it) }
            else -> {
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {

    }

    //安装
    private fun invokeInstall(context: Context, apkPath: String) {
        val file = File(apkPath)
        if (!file.exists()) {
            return
        }

        val intent = Intent(Intent.ACTION_VIEW)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            //7.0及以上
            val contentUri = FileProvider.getUriForFile(context, "${context.packageName}.fileprovider", file)
            intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            intent.setDataAndType(contentUri, "application/vnd.android.package-archive")
            context.startActivity(intent)
        } else {
            //7.0以下
            intent.setDataAndType(Uri.fromFile(file), "application/vnd.android.package-archive")
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            context.startActivity(intent)
        }
    }

    private fun log(msg: String) {
        Log.i("native method", msg)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        mContext = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onDetachedFromActivity() {
    }
}
