package com.example.accessibility_detect

import android.accessibilityservice.AccessibilityServiceInfo
import android.content.Context
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.os.Build
import android.util.Log
import android.view.accessibility.AccessibilityManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONArray
import org.json.JSONObject


/** AccessibilityDetectPlugin */
class AccessibilityDetectPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "accessibility_detect")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPackageNameAccessibility") {
       val pm = context.packageManager
      val am = context.getSystemService(Context.ACCESSIBILITY_SERVICE) as AccessibilityManager
      val services = am.getEnabledAccessibilityServiceList(AccessibilityServiceInfo.FEEDBACK_ALL_MASK)

      val accessibilityArray = JSONArray()

      for (asi in services) {
        val accessibilityObject = JSONObject()
        val packageInfo = pm.getPackageInfo(asi.id.split("/")[0], 0)
        val packageName = packageInfo.packageName

        val info: ApplicationInfo = pm.getApplicationInfo(packageName, PackageManager.GET_META_DATA)
        val appName = pm.getApplicationLabel(info) as String

        val installerPackageName = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
          pm.getInstallSourceInfo(packageName).installingPackageName.toString()
        } else {
          pm.getInstallerPackageName(packageName).toString()
        }

        accessibilityObject.put("applicationName", appName)
        accessibilityObject.put("packageName", packageName)
        accessibilityObject.put("source", installerPackageName)
        accessibilityArray.put(accessibilityObject)
      }

      return   result.success(accessibilityArray.toString());

    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
