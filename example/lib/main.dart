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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    PavoPosPackage.init();
  }

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
    const orderNo = '231e2rklo342r0wrqwrqw';
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
            Text(
              resultText,
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () => sale(orderNo),
              child: const Text("Sale"),
            ),
            ElevatedButton(
              onPressed: () => createOrder(orderNo),
              child: const Text("createOrder"),
            ),
            ElevatedButton(
              onPressed: () => addPayment(orderNo),
              child: const Text("addPayment"),
            ),
            ElevatedButton(
              onPressed: () => removePayment(orderNo),
              child: const Text("removePayment"),
            ),
            ElevatedButton(
              onPressed: () => endPayment(orderNo),
              child: const Text("endPayment"),
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
            ElevatedButton(
              onPressed: () => getDeviceSerialNumber(orderNo),
              child: const Text("get device SN"),
            ),
            ElevatedButton(
              onPressed: print,
              child: const Text("Print"),
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
    final res = await PavoPosPackage.instance!.sale(modelReq: req);
    resultText = res.ourOperationIsSuccess == true ? 'Staış Başarılı' : 'Staış Başarısızı: ${res.message}';
    setState(() {});
    log('example log: ', name: res.toJson().toString());
  }

  Future<void> cancel(String orderNo) async {
    final res = await PavoPosPackage.instance!.cancelSale(
      {
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
      },
    );

    resultText = res.ourOperationIsSuccess == true ? 'İade Başarılı' : 'Staış Başarısızı: ${res.message}';
    setState(() {});
    log('example log: ', name: res.toJson().toString());
  }

  Future<void> getSaleDetail(String orderNo) async {
    final res = await PavoPosPackage.instance!.getSaleDetail(orderNo);
    resultText = res.ourOperationIsSuccess == true ? 'İşlem Başarılı' : 'Staış Başarısız: ${res.message}';
    setState(() {});
    log('example log: ', name: res.toJson().toString());
  }

  Future<void> getDeviceInfo(String orderNo) async {
    final res = await PavoPosPackage.instance!.getDeviceInfo();
    resultText = res.ourOperationIsSuccess == true ? 'İşlem Başarılı' : 'Staış Başarısız: ${res.message}';
    setState(() {});
    log('example log: ', name: res.toJson().toString());
  }

  Future<void> getDeviceSerialNumber(String orderNo) async {
    final res = await PavoPosPackage.instance!.getDeviceSerialNumber();
  }

  Future<void> print() async {
    await PavoPosPackage.instance!.initPrinter();
    await PavoPosPackage.instance!.appendText('Siparisim', align: NexgoAlign.CENTER, size: NexgoFontSize.big);
    await PavoPosPackage.instance!
        .appendText('Toplam Tutar', col2: '200.00TL', align: NexgoAlign.CENTER, size: NexgoFontSize.small, bold: true);
    await PavoPosPackage.instance!.feedPaper(4);
    await PavoPosPackage.instance!.cutPaper();
    await PavoPosPackage.instance!.startPrint();
  }

  String saleNo = '';

  Future<void> createOrder(orderNo) async {
    final random = m.Random();
    orderNo = orderNo + random.nextInt(10000).toString();
    final res = await PavoPosPackage.instance!.createPartialOrder(
      {
        "OrderNo": orderNo,
        "RefererApp": "Harici Uygulama",
        "RefererAppVersion": "1.0.0",
        "MainDocumentType": 1,
        "GrossPrice": 2,
        "TotalPrice": 2,
        //"PriceEffect": {"Type": 2, "Rate": 10, "Amount": null},
        "SendPhoneNotification": false,
        "SendEMailNotification": true,
        "NotificationPhone": "",
        "NotificationEMail": "me@info.com",
        "AddedSaleItems": [
          {
            "Name": "Gofret",
            "IsGeneric": false,
            "UnitCode": "KGM",
            "TaxGroupCode": "KDV18",
            "ItemQuantity": 1,
            "UnitPriceAmount": 2,
            "GrossPriceAmount": 2,
            "TotalPriceAmount": 2,
            "ReservedText": "TEST0001",
            //"PriceEffect": {"Type": 1, "Rate": 10, "Amount": null}
          }
        ],
        "CustomerParty": {
          "CustomerType": 1,
          "FirstName": "John",
          "MiddleName": "",
          "FamilyName": "Doe",
          "CompanyName": "",
          "TaxOfficeCode": "",
          "TaxNumber": "11111111111",
          "Phone": "",
          "EMail": "",
          "Country": "Türkiye",
          "City": "Ankara",
          "District": "Çankaya",
          "Neighborhood": "",
          "Address": ""
        },
        "AdditionalInfo": [
          {"Key": "Test", "Value": "Test", "Print": true}
        ]
      },
    );
    saleNo = res.data!.orderNo!;
    resultText = res.ourOperationIsSuccess == true ? 'Staış Başarılı' : 'Staış Başarısızı: ${res.message}';
    setState(() {});
    log('example log: ', name: res.toJson().toString());
  }

  Future<void> addPayment(orderNo) async {
    final res = await PavoPosPackage.instance!.addPaymentForPartialOrder(
      {
        "FinalizeAndReturnSale": false,
        "SaleNumber": saleNo,
        "OrderNo": saleNo,
        "GrossPrice": 2,
        "SkipAmountCash": true,
        "PaymentInformations": [
          {
            "Mediator": 1,
            "Amount": 1,
            "ExternalReferenceText": '$saleNo-1',
          }
        ],
        "RefererApp": "Dev Siparişim POS",
        "RefererAppVersion": "(1.1.8 Dev)+19",
        "logTag": "order_code=mto52",
        "ReceiptInformation": {
          "ReceiptImageEnabled": true,
          "ReceiptWidth": "58mm",
          "PrintCustomerReceipt": true,
          "PrintCustomerReceiptCopy": true,
          "PrintMerchantReceipt": true
        }
        /*"ExternalPayments": [
          {
            "Type": 3,
            "Mediator": 10,
            "Brand": 6,
            "ExternalReferenceText": "c5edb71f-b145-4e0c-beed-5a884a4bd08c",
            "CardNo": null,
            "AuthorizationCode": null,
            "Amount": 1
          }
        ],*/
      },
    );
    resultText = res.ourOperationIsSuccess == true ? 'Staış Başarılı' : 'Staış Başarısızı: ${res.message}';
    setState(() {});
    log('example log: ', name: res.toJson().toString());
  }

  Future<void> endPayment(orderNo) async {
    final res = await PavoPosPackage.instance!.addPaymentAndFinalizeForPartialOrder(
      {
        "FinalizeAndReturnSale": true,
        "SaleNumber": saleNo,
        "OrderNo": saleNo,
        "GrossPrice": 2,
        "SkipAmountCash": true,
        "PaymentInformations": [
          {"Mediator": 1, "Amount": 1}
        ],
        "RefererApp": "Dev Siparişim POS",
        "RefererAppVersion": "(1.1.8 Dev)+19",
        "ReceiptInformation": {
          "ReceiptImageEnabled": true,
          "ReceiptWidth": "58mm",
          "PrintCustomerReceipt": true,
          "PrintCustomerReceiptCopy": false,
          "PrintMerchantReceipt": true
        },
        "logTag": "order_code=mto52"
      },
    );
    resultText = res.ourOperationIsSuccess == true ? 'Staış Başarılı' : 'Staış Başarısızı: ${res.message}';
    setState(() {});
    log('example log: ', name: res.toJson().toString());
  }

  Future<void> removePayment(orderNo) async {
    final res = await PavoPosPackage.instance!.removePaymentForPartialOrder({
      "SaleNumber": saleNo,
      "OrderNo": saleNo,
      "FinalizeAndReturnSale": false,
      "PaymentReference": "231e2rklo342r0wrqwrqw6527-1",
      "IsVoid": true,
      "ReceiptInformation": {
        "ReceiptInformation": true,
        "ReceiptWidth": "58mm",
        "PrintCustomerReceipt": true,
        "PrintCustomerReceiptCopy": false,
        "PrintMerchantReceipt": true
      },
      "RefererApp": "Dev Siparişim POS",
      "RefererAppVersion": "(1.1.8 Dev)+19",
    });
    resultText = res.ourOperationIsSuccess == true ? 'Staış Başarılı' : 'Staış Başarısızı: ${res.message}';
    setState(() {});
    log('example log: ', name: res.toJson().toString());
  }
}
