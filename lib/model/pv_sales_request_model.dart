import 'package:background_json_parser/background_json_parser.dart';

import '../constant/enum.dart';

class PVSalesRequestModel extends IBaseModel<PVSalesRequestModel> {
  /// Sipariş numarası (benzersiz olmalı)
  final String orderNo;

  /// False olarak ayarlanırsa kredi kartı ödemelerinde direkt kart okuma ekranı açılır.
  final bool showCreditCardMenu;

  /// Satış yapılacak doküman tipi. 1: E-Fatura, 9: Gider Pusulası
  final int mainDocumentType;

  /// İşlem başlatan uygulamanın adı
  final String refererApp;

  /// İşlem başlatan uygulamanın versiyonu
  final String refererAppVersion;

  /// Sepetin brüt tutarı
  final double grossPrice;

  /// Sepetin net tutarı
  final double totalPrice;

  /// Telefon bildirim gönderme seçeneği
  final bool sendPhoneNotification;

  /// E-posta bildirimi gönderme seçeneği
  final bool sendEMailNotification;

  /// Fiş bilgileri
  final PVSaleRequestReceiptInformationModel receiptInformation;

  /// Kart ekranında görüntülenecek ödeme slotları
  late final List<String> selectedSlots;

  /// Kart okuma ekranında “Vazgeç” butonunun gösterilmesi
  final bool allowDismissCardRead;

  /// Nakit ödeme ekranının atlanıp atlanmayacağı
  final bool skipAmountCash;

  /// Ödeme ekranından önce müşteri seçme veya ekleme ekranının açılması
  final bool askCustomer;

  /// Ödeme hatasında tekrar deneme seçeneği
  final bool tryAgainOnPaymentFailure;

  /// Taksit sayısı
  final int? installmentCount;

  /// Satışa eklenen ürünler
  final List<PVSaleRequestModelSaleItemModel> addedSaleItems;

  /// Ödeme bilgileri
  ///
  /// Ödemenin nasıl alınacağı bilgisini içerir. Ödeme yöntemleri pos cihazı ekranından seçilmek istenirse PaymentInformations gönderilmez.Ödeme PaymentInformations içerisindeki sıraya göre ardışık alınır.
  late final List<PVSaleRequestPaymentInformationModel> paymentInformations;

  /// İzin verilen ödeme yöntemleri
  late final List<PVSaleRequestPaymentAllowedPaymentMediatorModel> allowedPaymentMediators;

  /// Belirtilen ödeme aracısı hata alırsa diğer ödeme seçeneklerini gösterme durumu
  final bool referOtherMediatorsToRetryPayment;

  /// İlave bilgiler
  final List<Map<String, dynamic>> additionalInfo;

  /// Satış fişi üst bilgileri
  final List<Map<String, dynamic>> topPrintibleItems;

  /// Satış fişi alt bilgileri
  final List<Map<String, dynamic>> bottomPrintibleItems;

  PVSalesRequestModel({
    required this.orderNo,
    this.showCreditCardMenu = false,
    this.mainDocumentType = 1,
    required this.refererApp,
    required this.refererAppVersion,
    required this.grossPrice,
    required this.totalPrice,
    this.sendPhoneNotification = false,
    this.sendEMailNotification = false,
    this.receiptInformation = const PVSaleRequestReceiptInformationModel(),
    final List<String>? selectedSlots,
    this.allowDismissCardRead = true,
    this.skipAmountCash = true,
    this.askCustomer = false,
    this.tryAgainOnPaymentFailure = false,
    this.installmentCount = 0,
    required this.addedSaleItems,
    final List<PVSaleRequestPaymentInformationModel>? paymentInformations,
    final List<PVSaleRequestPaymentAllowedPaymentMediatorModel>? allowedPaymentMediators,
    this.referOtherMediatorsToRetryPayment = false,
    this.additionalInfo = const [],
    this.topPrintibleItems = const [],
    this.bottomPrintibleItems = const [],
  }) {
    this.selectedSlots = selectedSlots ?? PVPaymentSlotType.values.map((e) => e.name).toList();
    this.paymentInformations = paymentInformations ??
        [
          PVSaleRequestPaymentInformationModel(
            mediator: 2,
            amount: totalPrice,
          )
        ];
    this.allowedPaymentMediators = allowedPaymentMediators ??
        [
          PVSaleRequestPaymentAllowedPaymentMediatorModel(mediator: 2),
        ];
  }

  @override
  Map<String, dynamic> toJson() => {
        "OrderNo": orderNo,
        "ShowCreditCardMenu": showCreditCardMenu,
        "MainDocumentType": mainDocumentType,
        "RefererApp": refererApp,
        "RefererAppVersion": refererAppVersion,
        "GrossPrice": grossPrice,
        "TotalPrice": totalPrice,
        "SendPhoneNotification": sendPhoneNotification,
        "SendEMailNotification": sendEMailNotification,
        "ReceiptInformation": receiptInformation.toJson(),
        "SelectedSlots": List<dynamic>.from(selectedSlots.map((x) => x)),
        "AllowDismissCardRead": allowDismissCardRead,
        "SkipAmountCash": skipAmountCash,
        "AskCustomer": askCustomer,
        "TryAgainOnPaymentFailure": tryAgainOnPaymentFailure,
        "InstallmentCount": installmentCount,
        "AddedSaleItems": List<dynamic>.from(addedSaleItems.map((x) => x.toJson())),
        "PaymentInformations": List<dynamic>.from(paymentInformations.map((x) => x.toJson())),
        "AllowedPaymentMediators": List<dynamic>.from(allowedPaymentMediators.map((x) => x.toJson())),
        "ReferOtherMediatorsToRetryPayment": referOtherMediatorsToRetryPayment,
        "AdditionalInfo": List<dynamic>.from(additionalInfo.map((x) => x)),
        "TopPrintibleItems": List<dynamic>.from(topPrintibleItems.map((x) => x)),
        "BottomPrintibleItems": List<dynamic>.from(bottomPrintibleItems.map((x) => x)),
      };

  @override
  PVSalesRequestModel fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}

class PVSaleRequestReceiptInformationModel {
  // Satış sonrası oluşan müşteri nüshasını ve iş yeri nüshalarını base64 formatında geri döner. Varsayılan değeri false.
  final bool receiptImageEnabled;

  // Satış sonrası oluşan müşteri nüshasını ve iş yeri nüshalarını json formatında geri döner. Varsayılan değeri false
  final bool receiptJsonEnabled;

  // Satış sonrası oluşan müşteri nüshasını ve iş yeri nüshalarımı text formatında geri döner. Varsayılan değeri false.
  final bool receiptTextEnabled;

  final String receiptWidth;

  // Müşteri nüshasının opsiyonel olarak yazdırılması. Varsayılan değeri true.
  final bool printCustomerReceipt;

  // Müşteri nüshası kopyasının opsiyonel olarak yazdırılması. Varsayılan değeri false.
  final bool printCustomerReceiptCopy;

  // İşyeri nüshasının opsiyonel olarak yazdırılması. Varsayılan değeri true.
  final bool printMerchantReceipt;

  // Kur bilgileri alanının satış slibinde gösterilmesi. Varsayılan değeri false
  final bool enableExchangeRateField;

  const PVSaleRequestReceiptInformationModel({
    this.receiptImageEnabled = false,
    this.receiptJsonEnabled = false,
    this.receiptTextEnabled = false,
    this.receiptWidth = "58mm",
    this.printCustomerReceipt = true,
    this.printCustomerReceiptCopy = false,
    this.printMerchantReceipt = false,
    this.enableExchangeRateField = false,
  });

  factory PVSaleRequestReceiptInformationModel.fromJson(Map<String, dynamic> json) =>
      PVSaleRequestReceiptInformationModel(
        receiptImageEnabled: json["ReceiptImageEnabled"],
        receiptJsonEnabled: json["ReceiptJsonEnabled"],
        receiptTextEnabled: json["ReceiptTextEnabled"],
        receiptWidth: json["ReceiptWidth"],
        printCustomerReceipt: json["PrintCustomerReceipt"],
        printCustomerReceiptCopy: json["PrintCustomerReceiptCopy"],
        printMerchantReceipt: json["PrintMerchantReceipt"],
        enableExchangeRateField: json["EnableExchangeRateField"],
      );

  Map<String, dynamic> toJson() => {
        "ReceiptImageEnabled": receiptImageEnabled,
        "ReceiptJsonEnabled": receiptJsonEnabled,
        "ReceiptTextEnabled": receiptTextEnabled,
        "ReceiptWidth": receiptWidth,
        "PrintCustomerReceipt": printCustomerReceipt,
        "PrintCustomerReceiptCopy": printCustomerReceiptCopy,
        "PrintMerchantReceipt": printMerchantReceipt,
        "EnableExchangeRateField": enableExchangeRateField,
      };
}

class PVSaleRequestModelSaleItemModel {
  // Ürünün adı.
  final String name;

  // Ürünün kısım ürün olup olmadığı bilgisi.
  final bool isGeneric;

  // Ürünün biriminin kodu. Bkz. GİB birim kodları.
  final String unitCode;

  // Ürünün ait olduğu vergi grubunun kodu Bkz. Referans Bilgiler - Tax Group Code.
  final String taxGroupCode;

  // Ürünün miktarı.
  final double itemQuantity;

  // Ürünün birim fiyatı.
  final double unitPriceAmount;

  // Ürünün brüt fiyatı.
  final double grossPriceAmount;

  // Ürünün net fiyatı.
  final double totalPriceAmount;

  PVSaleRequestModelSaleItemModel({
    required this.name,
    required this.isGeneric,
    required this.unitCode,
    required this.taxGroupCode,
    required this.itemQuantity,
    required this.unitPriceAmount,
    required this.grossPriceAmount,
    required this.totalPriceAmount,
  });

  factory PVSaleRequestModelSaleItemModel.fromJson(Map<String, dynamic> json) => PVSaleRequestModelSaleItemModel(
        name: json["Name"],
        isGeneric: json["IsGeneric"],
        unitCode: json["UnitCode"],
        taxGroupCode: json["TaxGroupCode"],
        itemQuantity: json["ItemQuantity"],
        unitPriceAmount: json["UnitPriceAmount"],
        grossPriceAmount: json["GrossPriceAmount"],
        totalPriceAmount: json["TotalPriceAmount"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "IsGeneric": isGeneric,
        "UnitCode": unitCode,
        "TaxGroupCode": taxGroupCode,
        "ItemQuantity": itemQuantity,
        "UnitPriceAmount": unitPriceAmount,
        "GrossPriceAmount": grossPriceAmount,
        "TotalPriceAmount": totalPriceAmount,
      };
}

class PVSaleRequestPaymentInformationModel {
  final int mediator;
  final double amount;

  PVSaleRequestPaymentInformationModel({
    required this.mediator,
    required this.amount,
  });

  factory PVSaleRequestPaymentInformationModel.fromJson(Map<String, dynamic> json) =>
      PVSaleRequestPaymentInformationModel(
        mediator: json["Mediator"],
        amount: json["Amount"],
      );

  Map<String, dynamic> toJson() => {
        "Mediator": mediator,
        "Amount": amount,
      };
}

class PVSaleRequestPaymentAllowedPaymentMediatorModel {
  int? mediator;

  PVSaleRequestPaymentAllowedPaymentMediatorModel({
    this.mediator,
  });

  factory PVSaleRequestPaymentAllowedPaymentMediatorModel.fromJson(Map<String, dynamic> json) =>
      PVSaleRequestPaymentAllowedPaymentMediatorModel(
        mediator: json["Mediator"],
      );

  Map<String, dynamic> toJson() => {
        "Mediator": mediator,
      };
}
