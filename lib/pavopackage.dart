library pavopackage;

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pavopackage/constant/enum.dart';
import 'package:receive_intent/receive_intent.dart';

import 'model/pv_sales_request_model.dart';
import 'model/pv_sales_response_model.dart';

/// A Calculator.
///
typedef _ResFun = void Function(PvSalesResponseModel res);

class PavoPosPackage {
  // final String _package = 'tr.com.overtech.overpay_nkolay';

  @visibleForTesting
  static MethodChannel methodChannel = const MethodChannel('pavopackage');
  static PavoPosPackage? instance;
  final PavoAppType appType;
  late StreamSubscription<Intent?> _intentSubscription;
  final HashMap<String, _ResFun> _listener = HashMap();

  static Future<PavoPosPackage?> init() async {
    PavoAppType? appType;
    for (var e in PavoAppType.values) {
      if (await isAppInstalled(e.packageName) == true) {
        appType = e;
        break;
      }
    }

    if (appType == null) {
      throw PlatformException(code: '0001', message: 'Kurulu Uygulama bulunamadı');
    }

    instance ??= PavoPosPackage._(appType);
    return instance;
  }

  PavoPosPackage._(this.appType) {
    _intentSubscription = ReceiveIntent.receivedIntentStream.listen(
      (Intent? intent) {
        if (intent == null) return;
        log(intent.extra.toString(), name: '<--------- PAVO');
        try {
          final _ResFun? fun = _listener[intent.action!];
          if (fun == null) return;
          _listener.remove(intent.action!);
          final PvSalesResponseModel response = PvSalesResponseModel().jsonParserByMap(intent.extra);
          fun.call(response);
        } catch (e) {
          final fun = _listener[intent.action!]!;
          _listener.remove(intent.action!);
          fun.call(PvSalesResponseModel(dataDynamic: intent.extra, hasError: true));
          debugPrintStack(label: e.toString());
        }
      },
      onError: (e) {
        debugPrintStack(label: e.toString());
      },
    );
  }

  Future<void> dispose() async {
    await _intentSubscription.cancel();
  }

  Future<PvSalesResponseModel> sale({PVSalesRequestModel? modelReq, Map<String, dynamic>? mapReq}) async {
    assert(modelReq != null || mapReq != null);
    const action = 'pavopay.intent.action.complete.sale';
    const actionResult = '$action.result';
    final appInfo = await PackageInfo.fromPlatform();
    final completer = Completer<PvSalesResponseModel>();

    _listener[actionResult] = (PvSalesResponseModel res) {
      res.ourOperationIsSuccess = _isSuccess(res, paymentStatusId: PavoPaymentStatusId.Completed);
      res.message = _getMessageFromPaymentStatus(res);
      completer.complete(res);
    };

    final requestMap = modelReq?.toJson() ?? mapReq!;
    final String appName = appInfo.appName;
    final String version = '(${appInfo.version})+${appInfo.buildNumber}';

    requestMap['RefererApp'] = appName;
    requestMap['RefererAppVersion'] = version;

    AndroidIntent(
      type: 'application/json',
      package: appType.packageName,
      action: action,
      flags: [0x10000000],
      arguments: <String, dynamic>{
        'Sale': jsonEncode(requestMap),
        'packageName': appInfo.packageName,
      },
    ).launch();

    log(jsonEncode(requestMap), name: '---------> PAVO');
    return completer.future;
  }

  Future<PvSalesResponseModel> getSaleDetail(
    String orderNo, {
    PavoPaymentStatusId? paymentStatusId,
  }) async {
    const action = 'pavopay.intent.action.completed.sale';
    const actionResult = '$action.result';
    final packageName = (await PackageInfo.fromPlatform()).packageName;
    final completer = Completer<PvSalesResponseModel>();

    _listener[actionResult] = (PvSalesResponseModel res) {
      res.ourOperationIsSuccess = _isSuccess(res, paymentStatusId: paymentStatusId ?? PavoPaymentStatusId.Completed);
      completer.complete(res);
    };

    final requestMap = {'OrderNo': orderNo};

    AndroidIntent(
      type: 'application/json',
      package: appType.packageName,
      action: action,
      flags: [0x10000000],
      arguments: <String, dynamic>{
        'Sale': jsonEncode(requestMap),
        'packageName': packageName,
      },
    ).launch();

    log(requestMap.toString(), name: '---------> PAVO');
    return completer.future;
  }

  Future<PvSalesResponseModel> cancelSale(String orderNo) async {
    const action = 'pavopay.intent.action.cancel.sale';
    const actionResult = '$action.result';
    final packageName = (await PackageInfo.fromPlatform()).packageName;
    final completer = Completer<PvSalesResponseModel>();

    _listener[actionResult] = (PvSalesResponseModel res) {
      res.ourOperationIsSuccess = _isSuccess(res, pvStatusId: PVStatusId.PaymentCancelled);
      completer.complete(res);
    };

    final requestMap = {
      'OrderNo': orderNo,
      'SkipPaymentSummary': true,
      'EnableRefundMediatorsOnVoidFailure': false,
      'IsVoid': true,
      'ReceiptInformation': const PVSaleRequestReceiptInformationModel(
        receiptImageEnabled: false,
        receiptJsonEnabled: false,
        receiptTextEnabled: false,
        receiptWidth: "58mm",
        printCustomerReceipt: true,
        printCustomerReceiptCopy: false,
        printMerchantReceipt: false,
        enableExchangeRateField: false,
      ),
    };

    AndroidIntent(
      type: 'application/json',
      package: appType.packageName,
      action: action,
      flags: [0x10000000],
      arguments: <String, dynamic>{
        'Sale': jsonEncode(requestMap),
        'packageName': packageName,
      },
    ).launch();

    log(requestMap.toString(), name: '---------> PAVO');
    return completer.future;
  }

  Future<PvSalesResponseModel> getDeviceInfo(String orderNo) async {
    const action = 'pavopay.intent.action.get.device.info';
    const actionResult = '$action.result';
    final packageName = (await PackageInfo.fromPlatform()).packageName;
    final completer = Completer<PvSalesResponseModel>();

    _listener[actionResult] = (PvSalesResponseModel res) {
      res.ourOperationIsSuccess = res.hasError == false;
      completer.complete(res);
    };

    final requestMap = {
      "DeviceInfo": {
        "AdditionalInfo": {
          "serialNumber": true,
          "fingerPrint": true,
          "terminalSettings": true,
          "listTerminals": true,
          "networkStatus": true
        }
      }
    };

    AndroidIntent(
      type: 'application/json',
      package: appType.packageName,
      action: action,
      flags: [0x10000000],
      arguments: <String, dynamic>{
        'Sale': jsonEncode(requestMap),
        'packageName': packageName,
      },
    ).launch();

    log(requestMap.toString(), name: '---------> PAVO');
    return completer.future;
  }

  bool _isSuccess(PvSalesResponseModel res, {PavoPaymentStatusId? paymentStatusId, PVStatusId? pvStatusId}) {
    assert(paymentStatusId != null || pvStatusId != null);
    try {
      if (res.hasError == false) {
        if (paymentStatusId != null) {
          if (res.data != null) {
            return res.data!.addedPayments?.firstOrNull?.statusId == paymentStatusId.id;
          } else if (res.dataDynamic != null) {
            return (res.dataDynamic!['AddedPayments'] as List).first['StatusId'] == paymentStatusId.id;
          }
        } else {
          if (res.data != null) {
            return res.data!.statusId == pvStatusId!.id;
          } else if (res.dataDynamic != null) {
            return res.dataDynamic!['Data']['StatusId'] == pvStatusId!.id;
          }
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<String?> getDeviceSerialNumber() async {
    try {
      return await methodChannel.invokeMethod<String>('getSerialNumber');
    } catch (e) {
      return null;
    }
  }

  static Future<bool?> isAppInstalled(String packageName) async {
    try {
      bool result = await methodChannel.invokeMethod('isAppInstalled', {'packageName': packageName});
      return result;
    } catch (_) {
      return false;
    }
  }

  String? _getMessageFromPaymentStatus(PvSalesResponseModel res) {
    try {
      if (res.message?.trim().isNotEmpty == true) return res.message;
      final statusId = res.data?.statusId;
      return PVStatusId.values.firstWhere((type) => type.id == statusId).title;
    } catch (e) {
      return null;
    }
  }

  Future<int?> initPrinter() => methodChannel.invokeMethod('initPrinter');

  Future<void> appendText(
    String col1, {
    String col2 = '',
    NexgoFontSize size = NexgoFontSize.normal,
    NexgoAlign align = NexgoAlign.LEFT,
    double col1Wight = 0.5,
    bool bold = false,
  }) async {
    assert((0 < col1Wight && col1Wight <= 1));

    final totalChar = size.maxChar;

    if (col2.trim().isEmpty) {
      await methodChannel.invokeMethod('appendText', {
        'col1': col1,
        'col2': '',
        'fontSize': size.value,
        'align': align.value,
        'bold': bold,
      });
    } else {
      final col1Char = (totalChar * col1Wight).ceil();
      final col2Char = (totalChar * (1 - col1Wight)).ceil();

      final listCol1 = _separationCol(col1, col1Char);
      final listCol2 = _separationCol(col2, col2Char);

      final int length = listCol1.length > listCol2.length ? listCol1.length : listCol2.length;
      for (int i = 0; i < length; i++) {
        await methodChannel.invokeMethod('appendText', {
          'col1': listCol1.elementAtOrNull(i) ?? '',
          'col2': listCol2.elementAtOrNull(i) ?? '',
          'fontSize': size.value,
          'align': align.value,
          'bold': bold,
        });
      }
    }
  }

  List<String> _separationCol(String col, int maxChar) {
    final List<String> listCol1 = [];
    if (col.length > maxChar) {
      String reminder = col.trim();
      while (reminder.isNotEmpty) {
        if (reminder.length < maxChar) {
          listCol1.add(reminder.trim().withoutDiacriticalMarks());
          break;
        }

        String chars = reminder.substring(0, maxChar).withoutDiacriticalMarks();
        reminder = reminder.substring(maxChar);

        if (chars[chars.length - 1] == ' ' || (reminder.isNotEmpty && reminder[0] == ' ')) {
          chars = chars;
          reminder = reminder.trim();
        } else {
          final char = chars[chars.length - 1];
          chars = '${chars.substring(0, chars.length - 1)}-';
          reminder = '$char$reminder'.trim();
        }

        listCol1.add(chars.trim().withoutDiacriticalMarks());
        debugPrint(reminder);
      }
    } else {
      listCol1.add(col);
    }

    return listCol1;
  }

  Future<int?> appendQR(String text, {int size = 24, NexgoAlign align = NexgoAlign.LEFT}) {
    text = text.withoutDiacriticalMarks();
    return methodChannel.invokeMethod('appendQR', {
      'qr': text,
      'fontSize': size,
      'align': align.value,
    });
  }

  Future<void> appendSeparator() async {
    await appendText('──────────────────────');
  }

  Future<void> feedLine([String? char]) async {
    final size = NexgoFontSize.big;
    await appendText(' ' * size.maxChar, size: size);
  }

  Future<int?> feedPaper([int lines = 1]) {
    return methodChannel.invokeMethod('feedPaper', {
      'lines': lines,
    });
  }

  Future<int?> cutPaper() {
    return methodChannel.invokeMethod('cutPaper');
  }

  Future startPrint() => methodChannel.invokeMethod('startPrint');
}

extension DiacriticsAwareString on String {
  String withoutDiacriticalMarks() {
    const diacritics = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏİìíîïÙÚÛÜùúûüÑñŠšŸÿýŽžıŞşĞğ';
    const nonDiacritics = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiiUUUUuuuuNnSsYyyZziSsGg';

    return splitMapJoin(
      '',
      onNonMatch: (char) =>
          char.isNotEmpty && diacritics.contains(char) ? nonDiacritics[diacritics.indexOf(char)] : char,
    );
  }
}

enum NexgoFontSize {
  small(20, 32),
  normal(24, 27),
  big(28, 24);

  final int value;
  final int maxChar;

  const NexgoFontSize(this.value, this.maxChar);
}

enum NexgoAlign {
  CENTER(1),
  RIGHT(2),
  LEFT(3);

  final int value;

  const NexgoAlign(this.value);
}
