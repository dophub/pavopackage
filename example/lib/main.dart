import 'dart:developer';
import 'dart:math' as m;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:pavopackage/constant/enum.dart';
import 'package:pavopackage/model/pv_sales_request_model.dart';
import 'package:pavopackage/pavopackage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String resultText = '';

  @override
  Widget build(BuildContext context) {
    final orderNo = '231e2rklo342r0${m.Random().nextInt(100000)}';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 100),
            Text(
              resultText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => sale(orderNo),
              child: const Text("Sale"),
            ),
            ElevatedButton(
              onPressed: () => cancel(orderNo),
              child: const Text("cancel"),
            ),
            ElevatedButton(
              onPressed: () => getSaleDetail(orderNo),
              child: const Text("get sale detail"),
            ),
            ElevatedButton(
              onPressed: () => getDeviceInfo(orderNo),
              child: const Text("get device info"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sale(String orderNo) async {
    final deviceInfo = DeviceInfoPlugin();
    final androidDeviceInfo = await deviceInfo.androidInfo;
    final req = PVSalesRequestModel(
      orderNo: orderNo,
      showCreditCardMenu: false,
      mainDocumentType: 1,
      refererApp: "Intent Example",
      refererAppVersion: "1.0.0",
      grossPrice: 1,
      totalPrice: 1,
      sendPhoneNotification: false,
      sendEMailNotification: false,
      receiptInformation: const PVSaleRequestReceiptInformationModel(
        receiptImageEnabled: false,
        receiptJsonEnabled: false,
        receiptTextEnabled: false,
        receiptWidth: "58mm",
        printCustomerReceipt: true,
        printCustomerReceiptCopy: false,
        printMerchantReceipt: false,
        enableExchangeRateField: false,
      ),
      selectedSlots: PVPaymentSlotType.values.map((e) => e.name).toList(),
      allowDismissCardRead: true,
      skipAmountCash: true,
      askCustomer: false,
      tryAgainOnPaymentFailure: false,
      installmentCount: 0,
      addedSaleItems: [
        PVSaleRequestModelSaleItemModel(
          name: "Çay",
          isGeneric: false,
          unitCode: "KGM",
          taxGroupCode: "KDV8",
          itemQuantity: 1.0,
          unitPriceAmount: 1,
          grossPriceAmount: 1,
          totalPriceAmount: 1,
        )
      ],
      paymentInformations: [
        PVSaleRequestPaymentInformationModel(mediator: PVPaymentType.Nakit.type, amount: 1),
      ],
      allowedPaymentMediators: [
        PVSaleRequestPaymentAllowedPaymentMediatorModel(mediator: PVPaymentType.Nakit.type),
      ],
      referOtherMediatorsToRetryPayment: false,
      additionalInfo: [],
      topPrintableItems: [
        PVSalePrinterModel(
          type: PVPrinterDataType.dText,
          isCenter: true,
          size: 34,
          isBold: true,
          text: "SR Döner",
        ),
        PVSalePrinterModel(
          type: PVPrinterDataType.dSpace,
          size: 10,
        ),
        PVSalePrinterModel(
          type: PVPrinterDataType.dLine,
          size: 50,
        ),
      ],
      bottomPrintableItems: [
        PVSalePrinterModel(
          type: PVPrinterDataType.dLine,
          size: 50,
        ),
        PVSalePrinterModel(
          type: PVPrinterDataType.dSpace,
          size: 10,
        ),
        PVSalePrinterModel(
          type: PVPrinterDataType.dText,
          isCenter: true,
          size: 34,
          isBold: true,
          text: "SR Döner",
        ),
        PVSalePrinterModel(
          type: PVPrinterDataType.dText,
          isCenter: true,
          size: 22,
          isBold: true,
          text: "Abdurrahmangazi, Fatih Blv. No: 114/B, 34920 Sultanbeyli/İstanbul",
        ),
      ],
    );
    final res = await PavoPosPackage().sale(modelReq: req);
    resultText = res.ourOperationIsSuccess == true ? 'Staış Başarılı' : 'Staış Başarısızı: ${res.message}';
    setState(() {});
    log('example log: ', name: res.toJson().toString());
  }

  Future<void> cancel(String orderNo) async {
    final res = await PavoPosPackage().cancelSale(orderNo);
    resultText = res.ourOperationIsSuccess == true ? 'İade Başarılı' : 'Staış Başarısızı: ${res.message}';
    setState(() {});
    log('example log: ', name: res.toJson().toString());
  }

  Future<void> getSaleDetail(String orderNo) async {
    final res = await PavoPosPackage().getSaleDetail(orderNo);
    resultText = res.ourOperationIsSuccess == true ? 'İşlem Başarılı' : 'Staış Başarısız: ${res.message}';
    setState(() {});
    log('example log: ', name: res.toJson().toString());
  }

  Future<void> getDeviceInfo(String orderNo) async {
    final res = await PavoPosPackage().getDeviceInfo(orderNo);
    resultText = res.ourOperationIsSuccess == true ? 'İşlem Başarılı' : 'Staış Başarısız: ${res.message}';
    setState(() {});
    log('example log: ', name: res.toJson().toString());
  }
}
