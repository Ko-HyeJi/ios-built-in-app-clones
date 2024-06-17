package com.example.stopwatch

import androidx.annotation.NonNull
import android.util.DisplayMetrics

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val channel = "com.hicardi"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler {call, result ->
            if (call.method == "getDisplayMetrics") {
                val dm = getDisplayMetrics()
                val metrics = HashMap<String, Any>()
                metrics["density"] = dm.density
                metrics["densityDpi"] = dm.densityDpi
                metrics["width"] = dm.widthPixels
                metrics["height"] = dm.heightPixels
                metrics["scaledDensity"] = dm.scaledDensity
                metrics["xdpi"] = dm.xdpi
                metrics["ydpi"] = dm.ydpi
                result.success(metrics)
            }
        }
    }

    // Request the DisplayMetrics
    private fun getDisplayMetrics(): DisplayMetrics {
        val dm = DisplayMetrics()
        windowManager.defaultDisplay.getMetrics(dm)
        return dm
    }
}
