library pavopackage;

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pavopackage/constant/enum.dart';
import 'package:receive_intent/receive_intent.dart';

import 'model/pv_sales_request_model.dart';
import 'model/pv_sales_response_model.dart';

/// A Calculator.
class PavoPosPackage {
  static PavoPosPackage? _instance;
  final String _package = 'tr.com.overtech.overpay_pos_demo';
  late StreamSubscription<Intent?> _intentSubscription;
  final HashMap<String, void Function(PvSalesResponseModel res)> _listener = HashMap();

  factory PavoPosPackage() => _instance ??= PavoPosPackage._();

  PavoPosPackage._() {
    _intentSubscription = ReceiveIntent.receivedIntentStream.listen(
      (Intent? intent) {
        if (intent == null) return;
        log(intent.extra.toString(), name: '<--------- PAVO');
        try {
          final PvSalesResponseModel response = PvSalesResponseModel().jsonParserByMap(intent.extra);
          final fun = _listener[intent.action!]!;
          _listener.remove(intent.action!);
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
    final packageName = (await PackageInfo.fromPlatform()).packageName;
    final completer = Completer<PvSalesResponseModel>();

    _listener[actionResult] = (PvSalesResponseModel res) {
      res.ourOperationIsSuccess = _isSuccess(res, paymentStatusId: PaymentStatusId.Completed);
      completer.complete(res);
    };

    final requestMap = modelReq?.toJson() ?? mapReq!;
    AndroidIntent(
      type: 'application/json',
      package: _package,
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

  Future<PvSalesResponseModel> getSaleDetail(String orderNo) async {
    const action = 'pavopay.intent.action.completed.sale';
    const actionResult = '$action.result';
    final packageName = (await PackageInfo.fromPlatform()).packageName;
    final completer = Completer<PvSalesResponseModel>();

    _listener[actionResult] = (PvSalesResponseModel res) {
      res.ourOperationIsSuccess = _isSuccess(res, paymentStatusId: PaymentStatusId.Completed);
      completer.complete(res);
    };

    final requestMap = {'OrderNo': orderNo};

    AndroidIntent(
      type: 'application/json',
      package: _package,
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
      package: _package,
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

  bool _isSuccess(PvSalesResponseModel res, {PaymentStatusId? paymentStatusId, PVStatusId? pvStatusId}) {
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
}
