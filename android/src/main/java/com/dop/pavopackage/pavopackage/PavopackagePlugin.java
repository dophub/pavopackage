package com.dop.pavopackage.pavopackage;

import androidx.annotation.NonNull;

import com.nexgo.oaf.apiv3.APIProxy;
import com.nexgo.oaf.apiv3.DeviceEngine;
import com.nexgo.oaf.apiv3.DeviceInfo;

import android.util.Log;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import android.content.Context;
import android.content.pm.PackageManager;

/**
 * PavopackagePlugin
 */
public class PavopackagePlugin implements FlutterPlugin, MethodCallHandler {
    Context applicationContext;
    private MethodChannel channel;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "pavopackage");
        channel.setMethodCallHandler(this);
        applicationContext = flutterPluginBinding.getApplicationContext();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getSerialNumber")) {
            DeviceEngine deviceEngine = APIProxy.getDeviceEngine(applicationContext);
            DeviceInfo deviceInfo = deviceEngine.getDeviceInfo();
            String sn = deviceInfo.getSn();
            log("PAVO SN:", sn);
            result.success(sn);
        } else if (call.method.equals("isAppInstalled")) {
            String packageName = call.argument("packageName");
            boolean isInstalled = isAppInstalled(packageName);
            result.success(isInstalled);
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    private boolean isAppInstalled(String packageName) {
        try {
            PackageManager pm = applicationContext.getPackageManager();
            pm.getPackageInfo(packageName, PackageManager.GET_ACTIVITIES);
            return true;
        } catch (PackageManager.NameNotFoundException e) {
            return false;
        }
    }

    void log(String tag, String msg) {
        try {
            Log.i(tag, msg);
        } finally {
        }
    }
}