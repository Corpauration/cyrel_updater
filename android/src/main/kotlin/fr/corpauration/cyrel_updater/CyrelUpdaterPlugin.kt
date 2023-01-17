package fr.corpauration.cyrel_updater

import android.annotation.TargetApi
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import androidx.annotation.NonNull
import androidx.core.content.FileProvider
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File


/** CyrelUpdaterPlugin */
class CyrelUpdaterPlugin: FlutterPlugin, ActivityAware, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  private var mCtx: Context? = null
  private var mActivity: Activity? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "cyrel_updater")
    channel.setMethodCallHandler(this)
    mCtx = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "installApk") {
      val path: String = call.argument("path")!!
      result.success(installApk(File(path)))
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    mCtx = null
  }

  @TargetApi(Build.VERSION_CODES.O)
  private fun startInstallPermissionSettingActivity() {
    val packageURI = Uri.parse("package:" + mCtx!!.packageName)
    val intent = Intent(Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES, packageURI)
    mActivity!!.startActivityForResult(intent, 10086)
  }

  private fun installApk(@NonNull apk: File): Boolean {
    if (mCtx != null && apk.exists() && apk.length() > 0) {
      val intent = Intent(Intent.ACTION_VIEW)
      intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
      intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        val contentUri: Uri = FileProvider.getUriForFile(mCtx!!,
                mCtx!!.applicationContext.packageName + ".provider", apk)
        intent.setDataAndType(contentUri, "application/vnd.android.package-archive")
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
          val hasInstallPermission = mCtx!!.packageManager.canRequestPackageInstalls()
          if (!hasInstallPermission) {
            startInstallPermissionSettingActivity()
            }
          }
      } else {
        intent.setDataAndType(Uri.fromFile(apk), "application/vnd.android.package-archive")
      }
      mCtx!!.startActivity(intent)
      return true
    } else {
      return false
    }
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    mActivity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {

  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    mActivity = binding.activity
  }

  override fun onDetachedFromActivity() {
    mActivity = null
  }
}
