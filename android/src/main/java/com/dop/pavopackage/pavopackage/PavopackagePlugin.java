package com.dop.pavopackage.pavopackage;

import androidx.annotation.NonNull;

import com.nexgo.oaf.apiv3.APIProxy;
import com.nexgo.oaf.apiv3.DeviceEngine;
import com.nexgo.oaf.apiv3.DeviceInfo;

import android.graphics.BitmapFactory;
import android.graphics.Typeface;
import android.util.Log;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import android.content.Context;
import android.content.pm.PackageManager;
import android.widget.Toast;

import android.os.Handler;
import android.os.Looper;
import android.widget.Toast;

import com.nexgo.oaf.apiv3.DeviceEngine;
import com.nexgo.oaf.apiv3.device.printer.AlignEnum;
import com.nexgo.oaf.apiv3.device.printer.BarcodeFormatEnum;
import com.nexgo.oaf.apiv3.device.printer.DotMatrixFontEnum;
import com.nexgo.oaf.apiv3.device.printer.FontEntity;
import com.nexgo.oaf.apiv3.device.printer.GrayLevelEnum;
import com.nexgo.oaf.apiv3.device.printer.OnPrintListener;
import com.nexgo.oaf.apiv3.device.printer.Printer;

import java.lang.reflect.Array;

/**
 * PavopackagePlugin
 */
public class PavopackagePlugin implements FlutterPlugin, MethodCallHandler {
    Context applicationContext;
    private MethodChannel channel;
    private DeviceEngine deviceEngine;
    private Printer printer;


    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "pavopackage");
        channel.setMethodCallHandler(this);
        applicationContext = flutterPluginBinding.getApplicationContext();
        deviceEngine = APIProxy.getDeviceEngine(applicationContext);
        printer = deviceEngine.getPrinter();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        int res;
        int align;
        AlignEnum alignEnum;
        switch (call.method) {
            case "getSerialNumber":
                DeviceInfo deviceInfo = deviceEngine.getDeviceInfo();
                String sn = deviceInfo.getSn();
                log("PAVO SN:", sn);
                result.success(sn);
                break;
            case "isAppInstalled":
                String packageName = call.argument("packageName");
                boolean isInstalled = isAppInstalled(packageName);
                result.success(isInstalled);
                break;
            case "print":
                printer.initPrinter();
                printer.setTypeface(Typeface.DEFAULT);
                printer.setLetterSpacing(5);


                final int FONT_SIZE_SMALL = 20;
                final int FONT_SIZE_NORMAL = 24;
                final int FONT_SIZE_BIG = 24;


                printer.appendPrnStr("MERCHANT NAME", "MERCHANT NAME", FONT_SIZE_NORMAL, false);
                printer.appendPrnStr("MERCHANT NO", FONT_SIZE_NORMAL, AlignEnum.LEFT, false);

                printer.startPrint(false, new OnPrintListener() {       //roll paper or not
                    @Override
                    public void onPrintResult(final int retCode) {
                        String msg = PrinterError.fromCode(retCode);
                        showToast(msg);
                    }
                });

                break;

            case "initPrinter":
                res = printer.initPrinter();
                printer.setTypeface(Typeface.DEFAULT);
                result.success(res);
                break;
            case "appendText":
                String col1 = call.argument("col1");
                String col2 = call.argument("col2");
                int fontSize = call.argument("fontSize");
                align = call.argument("align");
                boolean bold = call.argument("bold");

                alignEnum = AlignEnum.LEFT;
                if (align == 1) alignEnum = AlignEnum.CENTER;
                else if (align == 2) alignEnum = AlignEnum.RIGHT;

                if (col2.isEmpty()) {
                    res = printer.appendPrnStr(
                            col1,
                            fontSize,
                            alignEnum,
                            bold
                    );
                } else {
                    res = printer.appendPrnStr(
                            col1,
                            col2,
                            fontSize,
                            bold
                    );
                }
                result.success(res);
                break;

            case "appendQR":
                String qr = call.argument("qr");
                int size = call.argument("size");
                align = call.argument("align");

                alignEnum = AlignEnum.LEFT;
                if (align == 1) alignEnum = AlignEnum.CENTER;
                else if (align == 2) alignEnum = AlignEnum.RIGHT;

                res = printer.appendQRcode(qr, size, alignEnum);
                result.success(res);
                break;


            case "startPrint":
                printer.startPrint(true, new OnPrintListener() {
                    @Override
                    public void onPrintResult(int code) {
                        String msg = PrinterError.fromCode(code);
                        showToast(msg);
                    }
                });
                result.success(null);
                break;

            case "feedPaper":
                int lines = call.argument("lines");
                printer.feedPaper(lines);
                result.success(null);
                break;

            case "cutPaper":
                printer.cutPaper();
                result.success(null);
                break;

            default:
                result.notImplemented();
                break;
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


    private void showToast(final String message) {
        if (message == null || applicationContext == null) return;

        new Handler(Looper.getMainLooper()).post(() -> {
            Toast.makeText(applicationContext, message, Toast.LENGTH_SHORT).show();
        });
    }
}


