import 'dart:convert';

import 'package:background_json_parser/background_json_parser.dart';

class PvSalesResponseModel extends IBaseModel<PvSalesResponseModel> {
  int? errorCode;
  String? message;
  PvSalesResponseDataModel? data;
  Map<String, dynamic>? dataDynamic; // temp tir response dönmez
  bool? hasError;
  bool? ourOperationIsSuccess; // işlem tamamlandı mı (getSaleDetail foksiyonu ise ödeme yapılmış mı yapılmamış mı)

  PvSalesResponseModel({
    this.errorCode,
    this.message,
    this.data,
    this.dataDynamic,
    this.hasError,
    this.ourOperationIsSuccess,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    errorCode = json["ErrorCode"];
    message = json["Message"];
    hasError = json["HasError"];
    try {
      final dataMap = jsonDecode(json["Data"]);
      dataDynamic = dataMap;
      data = json["Data"] == null ? null : PvSalesResponseDataModel.fromJson(dataMap);
    } catch (_) {}
    return this;
  }

  @override
  Map<String, dynamic> toJson() => {
        "ErrorCode": errorCode,
        "Message": message,
        "Data": data?.toJson(),
        "HasError": hasError,
      };
}

class PvSalesResponseDataModel {
  int? id;
  int? organizationId;
  bool? deleted;
  String? createDate;
  int? createUserId;
  int? createChannelId;
  int? createBranchId;
  int? createScreenId;
  int? merchantId;
  PvSalesResponseMerchantModel? merchant;
  int? applicationId;
  PvSalesResponseApplicationModel? application;
  int? typeId;
  int? statusId;
  String? saleDate;
  int? terminalId;
  PvSalesResponseTerminalModel? terminal;
  double? grossPrice;
  double? totalPrice;
  double? totalVatAmount;
  String? startTime;
  bool? multiPayment;
  bool? multiDocument;
  List<PvSalesResponseAddedSaleItemModel>? addedSaleItems;
  List<dynamic>? removedSaleItems;
  List<dynamic>? refundedSaleItems;
  List<dynamic>? allSaleItems;
  String? inqueryHash;
  String? orderNo;
  List<PvSalesResponseAddedPaymentModel>? addedPayments;
  String? gmuVersion;
  String? saleNumber;
  List<dynamic>? addedPriceEffects;
  List<PvSalesResponseFinancialDocumentModel>? financialDocuments;
  bool? isOffline;
  bool? sendPhoneNotification;
  bool? sendEMailNotification;
  String? refererApp;
  String? refererAppVersion;
  String? terminalVersion;
  double? convertedTotal;
  int? conversionCurrencyId;
  double? conversionRate;
  int? ownerBranchId;
  String? saleUid;
  String? currencyCode;
  PvSalesResponseExchangeRateInfoModel? exchangeRateInfo;
  String? terminalSerialNo;
  bool? isInFlightSale;
  bool? cancelRequested;
  bool? isSuspendedSale;
  double? remainingPaymentAmount;
  int? rawDocumentId;
  int? signedDocumentId;
  int? transactionReportId;

  PvSalesResponseDataModel({
    this.id,
    this.organizationId,
    this.deleted,
    this.createDate,
    this.createUserId,
    this.createChannelId,
    this.createBranchId,
    this.createScreenId,
    this.merchantId,
    this.merchant,
    this.applicationId,
    this.application,
    this.typeId,
    this.statusId,
    this.saleDate,
    this.terminalId,
    this.terminal,
    this.grossPrice,
    this.totalPrice,
    this.totalVatAmount,
    this.startTime,
    this.multiPayment,
    this.multiDocument,
    this.addedSaleItems,
    this.removedSaleItems,
    this.refundedSaleItems,
    this.allSaleItems,
    this.inqueryHash,
    this.orderNo,
    this.addedPayments,
    this.gmuVersion,
    this.saleNumber,
    this.addedPriceEffects,
    this.financialDocuments,
    this.isOffline,
    this.sendPhoneNotification,
    this.sendEMailNotification,
    this.refererApp,
    this.refererAppVersion,
    this.terminalVersion,
    this.convertedTotal,
    this.conversionCurrencyId,
    this.conversionRate,
    this.ownerBranchId,
    this.saleUid,
    this.currencyCode,
    this.exchangeRateInfo,
    this.terminalSerialNo,
    this.isInFlightSale,
    this.cancelRequested,
    this.isSuspendedSale,
    this.remainingPaymentAmount,
    this.rawDocumentId,
    this.signedDocumentId,
    this.transactionReportId,
  });

  factory PvSalesResponseDataModel.fromJson(Map<String, dynamic> json) => PvSalesResponseDataModel(
        id: json["Id"],
        organizationId: json["OrganizationId"],
        deleted: json["Deleted"],
        createDate: json["CreateDate"],
        createUserId: json["CreateUserId"],
        createChannelId: json["CreateChannelId"],
        createBranchId: json["CreateBranchId"],
        createScreenId: json["CreateScreenId"],
        merchantId: json["MerchantId"],
        merchant: json["Merchant"] == null ? null : PvSalesResponseMerchantModel.fromJson(json["Merchant"]),
        applicationId: json["ApplicationId"],
        application: json["Application"] == null ? null : PvSalesResponseApplicationModel.fromJson(json["Application"]),
        typeId: json["TypeId"],
        statusId: json["StatusId"],
        saleDate: json["SaleDate"],
        terminalId: json["TerminalId"],
        terminal: json["Terminal"] == null ? null : PvSalesResponseTerminalModel.fromJson(json["Terminal"]),
        grossPrice: json["GrossPrice"]?.toDouble(),
        totalPrice: json["TotalPrice"]?.toDouble(),
        totalVatAmount: json["TotalVATAmount"]?.toDouble(),
        startTime: json["StartTime"],
        multiPayment: json["MultiPayment"],
        multiDocument: json["MultiDocument"],
        addedSaleItems: json["AddedSaleItems"] == null
            ? []
            : List<PvSalesResponseAddedSaleItemModel>.from(
                json["AddedSaleItems"]!.map((x) => PvSalesResponseAddedSaleItemModel.fromJson(x))),
        removedSaleItems:
            json["RemovedSaleItems"] == null ? [] : List<dynamic>.from(json["RemovedSaleItems"]!.map((x) => x)),
        refundedSaleItems:
            json["RefundedSaleItems"] == null ? [] : List<dynamic>.from(json["RefundedSaleItems"]!.map((x) => x)),
        allSaleItems: json["AllSaleItems"] == null ? [] : List<dynamic>.from(json["AllSaleItems"]!.map((x) => x)),
        inqueryHash: json["InqueryHash"],
        orderNo: json["OrderNo"],
        addedPayments: json["AddedPayments"] == null
            ? []
            : List<PvSalesResponseAddedPaymentModel>.from(
                json["AddedPayments"]!.map((x) => PvSalesResponseAddedPaymentModel.fromJson(x))),
        gmuVersion: json["GMUVersion"],
        saleNumber: json["SaleNumber"],
        addedPriceEffects:
            json["AddedPriceEffects"] == null ? [] : List<dynamic>.from(json["AddedPriceEffects"]!.map((x) => x)),
        financialDocuments: json["FinancialDocuments"] == null
            ? []
            : List<PvSalesResponseFinancialDocumentModel>.from(
                json["FinancialDocuments"]!.map((x) => PvSalesResponseFinancialDocumentModel.fromJson(x))),
        isOffline: json["IsOffline"],
        sendPhoneNotification: json["SendPhoneNotification"],
        sendEMailNotification: json["SendEMailNotification"],
        refererApp: json["RefererApp"],
        refererAppVersion: json["RefererAppVersion"],
        terminalVersion: json["TerminalVersion"],
        convertedTotal: json["ConvertedTotal"]?.toDouble(),
        conversionCurrencyId: json["ConversionCurrencyId"],
        conversionRate: json["ConversionRate"]?.toDouble(),
        ownerBranchId: json["OwnerBranchId"],
        saleUid: json["SaleUid"],
        currencyCode: json["CurrencyCode"],
        exchangeRateInfo: json["ExchangeRateInfo"] == null
            ? null
            : PvSalesResponseExchangeRateInfoModel.fromJson(json["ExchangeRateInfo"]),
        terminalSerialNo: json["TerminalSerialNo"],
        isInFlightSale: json["IsInFlightSale"],
        cancelRequested: json["CancelRequested"],
        isSuspendedSale: json["IsSuspendedSale"],
        remainingPaymentAmount: json["RemainingPaymentAmount"]?.toDouble(),
        rawDocumentId: json["RawDocumentId"],
        signedDocumentId: json["SignedDocumentId"],
        transactionReportId: json["TransactionReportId"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "OrganizationId": organizationId,
        "Deleted": deleted,
        "CreateDate": createDate,
        "CreateUserId": createUserId,
        "CreateChannelId": createChannelId,
        "CreateBranchId": createBranchId,
        "CreateScreenId": createScreenId,
        "MerchantId": merchantId,
        "Merchant": merchant?.toJson(),
        "ApplicationId": applicationId,
        "Application": application?.toJson(),
        "TypeId": typeId,
        "StatusId": statusId,
        "SaleDate": saleDate,
        "TerminalId": terminalId,
        "Terminal": terminal?.toJson(),
        "GrossPrice": grossPrice,
        "TotalPrice": totalPrice,
        "TotalVATAmount": totalVatAmount,
        "StartTime": startTime,
        "MultiPayment": multiPayment,
        "MultiDocument": multiDocument,
        "AddedSaleItems": addedSaleItems == null ? [] : List<dynamic>.from(addedSaleItems!.map((x) => x.toJson())),
        "RemovedSaleItems": removedSaleItems == null ? [] : List<dynamic>.from(removedSaleItems!.map((x) => x)),
        "RefundedSaleItems": refundedSaleItems == null ? [] : List<dynamic>.from(refundedSaleItems!.map((x) => x)),
        "AllSaleItems": allSaleItems == null ? [] : List<dynamic>.from(allSaleItems!.map((x) => x)),
        "InqueryHash": inqueryHash,
        "OrderNo": orderNo,
        "AddedPayments": addedPayments == null ? [] : List<dynamic>.from(addedPayments!.map((x) => x.toJson())),
        "GMUVersion": gmuVersion,
        "SaleNumber": saleNumber,
        "AddedPriceEffects": addedPriceEffects == null ? [] : List<dynamic>.from(addedPriceEffects!.map((x) => x)),
        "FinancialDocuments":
            financialDocuments == null ? [] : List<dynamic>.from(financialDocuments!.map((x) => x.toJson())),
        "IsOffline": isOffline,
        "SendPhoneNotification": sendPhoneNotification,
        "SendEMailNotification": sendEMailNotification,
        "RefererApp": refererApp,
        "RefererAppVersion": refererAppVersion,
        "TerminalVersion": terminalVersion,
        "ConvertedTotal": convertedTotal,
        "ConversionCurrencyId": conversionCurrencyId,
        "ConversionRate": conversionRate,
        "OwnerBranchId": ownerBranchId,
        "SaleUid": saleUid,
        "CurrencyCode": currencyCode,
        "ExchangeRateInfo": exchangeRateInfo?.toJson(),
        "TerminalSerialNo": terminalSerialNo,
        "IsInFlightSale": isInFlightSale,
        "CancelRequested": cancelRequested,
        "IsSuspendedSale": isSuspendedSale,
        "RemainingPaymentAmount": remainingPaymentAmount,
        "RawDocumentId": rawDocumentId,
        "SignedDocumentId": signedDocumentId,
        "TransactionReportId": transactionReportId,
      };
}

class PvSalesResponseAddedPaymentModel {
  int? id;
  int? organizationId;
  bool? deleted;
  String? createDate;
  int? createUserId;
  int? createChannelId;
  int? createBranchId;
  int? createScreenId;
  int? saleId;
  int? statusId;
  int? merchantId;
  int? positionNo;
  double? paymentAmount;
  String? startTime;
  int? paymentTypeId;
  PvSalesResponsePaymentTypeModel? paymentType;
  int? paymentMediatorId;
  PvSalesResponsePaymentMediatorModel? paymentMediator;
  PvSalesResponseCashPaymentModel? cashPayment;
  List<PvSalesResponseItemPaymentModel>? itemPayments;
  String? tempId;
  int? operationTypeId;
  bool? isExternal;
  bool? isAllPaymentsCancelled;
  bool? isSaleAbondoned;
  int? terminalId;
  int? currencyId;
  double? exchangeRate;
  double? saleTotalPrice;
  double? convertedTotal;
  String? currencyCode;
  String? mediatorPaymentReference;

  PvSalesResponseAddedPaymentModel({
    this.id,
    this.organizationId,
    this.deleted,
    this.createDate,
    this.createUserId,
    this.createChannelId,
    this.createBranchId,
    this.createScreenId,
    this.saleId,
    this.statusId,
    this.merchantId,
    this.positionNo,
    this.paymentAmount,
    this.startTime,
    this.paymentTypeId,
    this.paymentType,
    this.paymentMediatorId,
    this.paymentMediator,
    this.cashPayment,
    this.itemPayments,
    this.tempId,
    this.operationTypeId,
    this.isExternal,
    this.isAllPaymentsCancelled,
    this.isSaleAbondoned,
    this.terminalId,
    this.currencyId,
    this.exchangeRate,
    this.saleTotalPrice,
    this.convertedTotal,
    this.currencyCode,
    this.mediatorPaymentReference,
  });

  factory PvSalesResponseAddedPaymentModel.fromJson(Map<String, dynamic> json) => PvSalesResponseAddedPaymentModel(
        id: json["Id"],
        organizationId: json["OrganizationId"],
        deleted: json["Deleted"],
        createDate: json["CreateDate"],
        createUserId: json["CreateUserId"],
        createChannelId: json["CreateChannelId"],
        createBranchId: json["CreateBranchId"],
        createScreenId: json["CreateScreenId"],
        saleId: json["SaleId"],
        statusId: json["StatusId"],
        merchantId: json["MerchantId"],
        positionNo: json["PositionNo"],
        paymentAmount: json["PaymentAmount"]?.toDouble(),
        startTime: json["StartTime"],
        paymentTypeId: json["PaymentTypeId"],
        paymentType: json["PaymentType"] == null ? null : PvSalesResponsePaymentTypeModel.fromJson(json["PaymentType"]),
        paymentMediatorId: json["PaymentMediatorId"],
        paymentMediator: json["PaymentMediator"] == null
            ? null
            : PvSalesResponsePaymentMediatorModel.fromJson(json["PaymentMediator"]),
        cashPayment: json["CashPayment"] == null ? null : PvSalesResponseCashPaymentModel.fromJson(json["CashPayment"]),
        itemPayments: json["ItemPayments"] == null
            ? []
            : List<PvSalesResponseItemPaymentModel>.from(
                json["ItemPayments"]!.map((x) => PvSalesResponseItemPaymentModel.fromJson(x))),
        tempId: json["TempId"],
        operationTypeId: json["OperationTypeId"],
        isExternal: json["IsExternal"],
        isAllPaymentsCancelled: json["IsAllPaymentsCancelled"],
        isSaleAbondoned: json["IsSaleAbondoned"],
        terminalId: json["TerminalId"],
        currencyId: json["CurrencyId"],
        exchangeRate: json["ExchangeRate"]?.toDouble(),
        saleTotalPrice: json["SaleTotalPrice"]?.toDouble(),
        convertedTotal: json["ConvertedTotal"]?.toDouble(),
        currencyCode: json["CurrencyCode"],
        mediatorPaymentReference: json["MediatorPaymentReference"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "OrganizationId": organizationId,
        "Deleted": deleted,
        "CreateDate": createDate,
        "CreateUserId": createUserId,
        "CreateChannelId": createChannelId,
        "CreateBranchId": createBranchId,
        "CreateScreenId": createScreenId,
        "SaleId": saleId,
        "StatusId": statusId,
        "MerchantId": merchantId,
        "PositionNo": positionNo,
        "PaymentAmount": paymentAmount,
        "StartTime": startTime,
        "PaymentTypeId": paymentTypeId,
        "PaymentType": paymentType?.toJson(),
        "PaymentMediatorId": paymentMediatorId,
        "PaymentMediator": paymentMediator?.toJson(),
        "CashPayment": cashPayment?.toJson(),
        "ItemPayments": itemPayments == null ? [] : List<dynamic>.from(itemPayments!.map((x) => x.toJson())),
        "TempId": tempId,
        "OperationTypeId": operationTypeId,
        "IsExternal": isExternal,
        "IsAllPaymentsCancelled": isAllPaymentsCancelled,
        "IsSaleAbondoned": isSaleAbondoned,
        "TerminalId": terminalId,
        "CurrencyId": currencyId,
        "ExchangeRate": exchangeRate,
        "SaleTotalPrice": saleTotalPrice,
        "ConvertedTotal": convertedTotal,
        "CurrencyCode": currencyCode,
        "MediatorPaymentReference": mediatorPaymentReference,
      };
}

class PvSalesResponseCashPaymentModel {
  int? id;
  int? organizationId;
  bool? deleted;
  String? createDate;
  int? createUserId;
  int? createChannelId;
  int? createBranchId;
  int? createScreenId;
  int? paymentId;
  int? saleId;
  double? givenAmount;
  double? changeAmount;

  PvSalesResponseCashPaymentModel({
    this.id,
    this.organizationId,
    this.deleted,
    this.createDate,
    this.createUserId,
    this.createChannelId,
    this.createBranchId,
    this.createScreenId,
    this.paymentId,
    this.saleId,
    this.givenAmount,
    this.changeAmount,
  });

  factory PvSalesResponseCashPaymentModel.fromJson(Map<String, dynamic> json) => PvSalesResponseCashPaymentModel(
        id: json["Id"],
        organizationId: json["OrganizationId"],
        deleted: json["Deleted"],
        createDate: json["CreateDate"],
        createUserId: json["CreateUserId"],
        createChannelId: json["CreateChannelId"],
        createBranchId: json["CreateBranchId"],
        createScreenId: json["CreateScreenId"],
        paymentId: json["PaymentId"],
        saleId: json["SaleId"],
        givenAmount: json["GivenAmount"]?.toDouble(),
        changeAmount: json["ChangeAmount"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "OrganizationId": organizationId,
        "Deleted": deleted,
        "CreateDate": createDate,
        "CreateUserId": createUserId,
        "CreateChannelId": createChannelId,
        "CreateBranchId": createBranchId,
        "CreateScreenId": createScreenId,
        "PaymentId": paymentId,
        "SaleId": saleId,
        "GivenAmount": givenAmount,
        "ChangeAmount": changeAmount,
      };
}

class PvSalesResponseItemPaymentModel {
  int? id;
  int? organizationId;
  bool? deleted;
  String? createDate;
  int? createUserId;
  int? createChannelId;
  int? createBranchId;
  int? createScreenId;
  int? paymentId;
  int? saleId;
  int? saleItemId;
  double? amount;
  String? tempSaleItemId;
  String? tempPaymentId;

  PvSalesResponseItemPaymentModel({
    this.id,
    this.organizationId,
    this.deleted,
    this.createDate,
    this.createUserId,
    this.createChannelId,
    this.createBranchId,
    this.createScreenId,
    this.paymentId,
    this.saleId,
    this.saleItemId,
    this.amount,
    this.tempSaleItemId,
    this.tempPaymentId,
  });

  factory PvSalesResponseItemPaymentModel.fromJson(Map<String, dynamic> json) => PvSalesResponseItemPaymentModel(
        id: json["Id"],
        organizationId: json["OrganizationId"],
        deleted: json["Deleted"],
        createDate: json["CreateDate"],
        createUserId: json["CreateUserId"],
        createChannelId: json["CreateChannelId"],
        createBranchId: json["CreateBranchId"],
        createScreenId: json["CreateScreenId"],
        paymentId: json["PaymentId"],
        saleId: json["SaleId"],
        saleItemId: json["SaleItemId"],
        amount: json["Amount"]?.toDouble(),
        tempSaleItemId: json["TempSaleItemId"],
        tempPaymentId: json["TempPaymentId"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "OrganizationId": organizationId,
        "Deleted": deleted,
        "CreateDate": createDate,
        "CreateUserId": createUserId,
        "CreateChannelId": createChannelId,
        "CreateBranchId": createBranchId,
        "CreateScreenId": createScreenId,
        "PaymentId": paymentId,
        "SaleId": saleId,
        "SaleItemId": saleItemId,
        "Amount": amount,
        "TempSaleItemId": tempSaleItemId,
        "TempPaymentId": tempPaymentId,
      };
}

class PvSalesResponsePaymentMediatorModel {
  int? id;
  String? name;
  int? paymentTypeId;
  String? notes;
  bool? isExternal;
  bool? isOffline;
  int? mediatorGroupId;
  bool? allowCurrency;

  PvSalesResponsePaymentMediatorModel({
    this.id,
    this.name,
    this.paymentTypeId,
    this.notes,
    this.isExternal,
    this.isOffline,
    this.mediatorGroupId,
    this.allowCurrency,
  });

  factory PvSalesResponsePaymentMediatorModel.fromJson(Map<String, dynamic> json) =>
      PvSalesResponsePaymentMediatorModel(
        id: json["Id"],
        name: json["Name"],
        paymentTypeId: json["PaymentTypeId"],
        notes: json["Notes"],
        isExternal: json["IsExternal"],
        isOffline: json["IsOffline"],
        mediatorGroupId: json["MediatorGroupId"],
        allowCurrency: json["AllowCurrency"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "PaymentTypeId": paymentTypeId,
        "Notes": notes,
        "IsExternal": isExternal,
        "IsOffline": isOffline,
        "MediatorGroupId": mediatorGroupId,
        "AllowCurrency": allowCurrency,
      };
}

class PvSalesResponsePaymentTypeModel {
  int? id;
  String? name;
  String? unedifactName;
  String? unedifactCode;

  PvSalesResponsePaymentTypeModel({
    this.id,
    this.name,
    this.unedifactName,
    this.unedifactCode,
  });

  factory PvSalesResponsePaymentTypeModel.fromJson(Map<String, dynamic> json) => PvSalesResponsePaymentTypeModel(
        id: json["Id"],
        name: json["Name"],
        unedifactName: json["UnedifactName"],
        unedifactCode: json["UnedifactCode"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "UnedifactName": unedifactName,
        "UnedifactCode": unedifactCode,
      };
}

class PvSalesResponseAddedSaleItemModel {
  int? id;
  int? organizationId;
  bool? deleted;
  String? createDate;
  int? createUserId;
  int? createChannelId;
  int? createBranchId;
  int? createScreenId;
  int? statusId;
  String? name;
  int? itemNo;
  String? insertTime;
  int? unitId;
  PvSalesResponseUnitModel? unit;
  double? itemQuantity;
  double? unitPriceAmount;
  double? grossPriceAmount;
  double? totalPriceAmount;
  double? vatAmount;
  double? vatRate;
  String? unitName;
  int? taxGroupId;
  bool? isGeneric;
  double? convertedTotal;
  List<PvSalesResponseItemPaymentModel>? itemPayments;
  String? tempId;

  PvSalesResponseAddedSaleItemModel({
    this.id,
    this.organizationId,
    this.deleted,
    this.createDate,
    this.createUserId,
    this.createChannelId,
    this.createBranchId,
    this.createScreenId,
    this.statusId,
    this.name,
    this.itemNo,
    this.insertTime,
    this.unitId,
    this.unit,
    this.itemQuantity,
    this.unitPriceAmount,
    this.grossPriceAmount,
    this.totalPriceAmount,
    this.vatAmount,
    this.vatRate,
    this.unitName,
    this.taxGroupId,
    this.isGeneric,
    this.convertedTotal,
    this.itemPayments,
    this.tempId,
  });

  factory PvSalesResponseAddedSaleItemModel.fromJson(Map<String, dynamic> json) => PvSalesResponseAddedSaleItemModel(
        id: json["Id"],
        organizationId: json["OrganizationId"],
        deleted: json["Deleted"],
        createDate: json["CreateDate"],
        createUserId: json["CreateUserId"],
        createChannelId: json["CreateChannelId"],
        createBranchId: json["CreateBranchId"],
        createScreenId: json["CreateScreenId"],
        statusId: json["StatusId"],
        name: json["Name"],
        itemNo: json["ItemNo"],
        insertTime: json["InsertTime"],
        unitId: json["UnitId"],
        unit: json["Unit"] == null ? null : PvSalesResponseUnitModel.fromJson(json["Unit"]),
        itemQuantity: json["ItemQuantity"]?.toDouble(),
        unitPriceAmount: json["UnitPriceAmount"]?.toDouble(),
        grossPriceAmount: json["GrossPriceAmount"]?.toDouble(),
        totalPriceAmount: json["TotalPriceAmount"]?.toDouble(),
        vatAmount: json["VATAmount"]?.toDouble(),
        vatRate: json["VATRate"]?.toDouble(),
        unitName: json["UnitName"],
        taxGroupId: json["TaxGroupId"],
        isGeneric: json["IsGeneric"],
        convertedTotal: json["ConvertedTotal"]?.toDouble(),
        itemPayments: json["ItemPayments"] == null
            ? []
            : List<PvSalesResponseItemPaymentModel>.from(
                json["ItemPayments"]!.map((x) => PvSalesResponseItemPaymentModel.fromJson(x))),
        tempId: json["TempId"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "OrganizationId": organizationId,
        "Deleted": deleted,
        "CreateDate": createDate,
        "CreateUserId": createUserId,
        "CreateChannelId": createChannelId,
        "CreateBranchId": createBranchId,
        "CreateScreenId": createScreenId,
        "StatusId": statusId,
        "Name": name,
        "ItemNo": itemNo,
        "InsertTime": insertTime,
        "UnitId": unitId,
        "Unit": unit?.toJson(),
        "ItemQuantity": itemQuantity,
        "UnitPriceAmount": unitPriceAmount,
        "GrossPriceAmount": grossPriceAmount,
        "TotalPriceAmount": totalPriceAmount,
        "VATAmount": vatAmount,
        "VATRate": vatRate,
        "UnitName": unitName,
        "TaxGroupId": taxGroupId,
        "IsGeneric": isGeneric,
        "ConvertedTotal": convertedTotal,
        "ItemPayments": itemPayments == null ? [] : List<dynamic>.from(itemPayments!.map((x) => x.toJson())),
        "TempId": tempId,
      };
}

class PvSalesResponseUnitModel {
  int? id;
  String? name;
  bool? hasDecimal;
  String? description;
  String? tuikCode;
  String? ublCode;
  String? ublName;

  PvSalesResponseUnitModel({
    this.id,
    this.name,
    this.hasDecimal,
    this.description,
    this.tuikCode,
    this.ublCode,
    this.ublName,
  });

  factory PvSalesResponseUnitModel.fromJson(Map<String, dynamic> json) => PvSalesResponseUnitModel(
        id: json["Id"],
        name: json["Name"],
        hasDecimal: json["HasDecimal"],
        description: json["Description"],
        tuikCode: json["TUIKCode"],
        ublCode: json["UBLCode"],
        ublName: json["UBLName"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "HasDecimal": hasDecimal,
        "Description": description,
        "TUIKCode": tuikCode,
        "UBLCode": ublCode,
        "UBLName": ublName,
      };
}

class PvSalesResponseApplicationModel {
  int? id;
  String? name;
  int? mainDocumentTypeId;
  bool? isActive;
  bool? isInternal;
  bool? autoSequence;
  bool? genericProductOnly;
  int? terminalTypeId;

  PvSalesResponseApplicationModel({
    this.id,
    this.name,
    this.mainDocumentTypeId,
    this.isActive,
    this.isInternal,
    this.autoSequence,
    this.genericProductOnly,
    this.terminalTypeId,
  });

  factory PvSalesResponseApplicationModel.fromJson(Map<String, dynamic> json) => PvSalesResponseApplicationModel(
        id: json["Id"],
        name: json["Name"],
        mainDocumentTypeId: json["MainDocumentTypeId"],
        isActive: json["IsActive"],
        isInternal: json["IsInternal"],
        autoSequence: json["AutoSequence"],
        genericProductOnly: json["GenericProductOnly"],
        terminalTypeId: json["TerminalTypeId"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "MainDocumentTypeId": mainDocumentTypeId,
        "IsActive": isActive,
        "IsInternal": isInternal,
        "AutoSequence": autoSequence,
        "GenericProductOnly": genericProductOnly,
        "TerminalTypeId": terminalTypeId,
      };
}

class PvSalesResponseExchangeRateInfoModel {
  PvSalesResponseExchangeRateInfoModel();

  factory PvSalesResponseExchangeRateInfoModel.fromJson(Map<String, dynamic> json) =>
      PvSalesResponseExchangeRateInfoModel();

  Map<String, dynamic> toJson() => {};
}

class PvSalesResponseFinancialDocumentModel {
  int? id;
  int? organizationId;
  bool? deleted;
  String? createDate;
  int? createUserId;
  int? createChannelId;
  int? createBranchId;
  int? createScreenId;
  int? typeId;
  PvSalesResponseTypeModel? type;
  int? statusId;
  String? documentNo;
  String? invoiceNo;
  String? inquiryLink;
  double? documentAmount;

  PvSalesResponseFinancialDocumentModel({
    this.id,
    this.organizationId,
    this.deleted,
    this.createDate,
    this.createUserId,
    this.createChannelId,
    this.createBranchId,
    this.createScreenId,
    this.typeId,
    this.type,
    this.statusId,
    this.documentNo,
    this.invoiceNo,
    this.inquiryLink,
    this.documentAmount,
  });

  factory PvSalesResponseFinancialDocumentModel.fromJson(Map<String, dynamic> json) =>
      PvSalesResponseFinancialDocumentModel(
        id: json["Id"],
        organizationId: json["OrganizationId"],
        deleted: json["Deleted"],
        createDate: json["CreateDate"],
        createUserId: json["CreateUserId"],
        createChannelId: json["CreateChannelId"],
        createBranchId: json["CreateBranchId"],
        createScreenId: json["CreateScreenId"],
        typeId: json["TypeId"],
        type: json["Type"] == null ? null : PvSalesResponseTypeModel.fromJson(json["Type"]),
        statusId: json["StatusId"],
        documentNo: json["DocumentNo"],
        invoiceNo: json["InvoiceNo"],
        inquiryLink: json["InquiryLink"],
        documentAmount: json["DocumentAmount"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "OrganizationId": organizationId,
        "Deleted": deleted,
        "CreateDate": createDate,
        "CreateUserId": createUserId,
        "CreateChannelId": createChannelId,
        "CreateBranchId": createBranchId,
        "CreateScreenId": createScreenId,
        "TypeId": typeId,
        "Type": type?.toJson(),
        "StatusId": statusId,
        "DocumentNo": documentNo,
        "InvoiceNo": invoiceNo,
        "InvoiceNoInquiryLink": inquiryLink,
        "DocumentAmount": documentAmount,
      };
}

class PvSalesResponseTypeModel {
  int? id;
  String? name;
  int? mainDocumentTypeId;
  bool? cancellable;

  PvSalesResponseTypeModel({
    this.id,
    this.name,
    this.mainDocumentTypeId,
    this.cancellable,
  });

  factory PvSalesResponseTypeModel.fromJson(Map<String, dynamic> json) => PvSalesResponseTypeModel(
        id: json["Id"],
        name: json["Name"],
        mainDocumentTypeId: json["MainDocumentTypeId"],
        cancellable: json["Cancellable"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "MainDocumentTypeId": mainDocumentTypeId,
        "Cancellable": cancellable,
      };
}

class PvSalesResponseMerchantModel {
  int? id;
  int? organizationId;
  bool? deleted;
  String? createDate;
  String? updateDate;
  int? createUserId;
  int? updateUserId;
  String? merchantName;
  int? typeId;
  bool? isActive;
  String? taxNumber;
  int? taxOfficeId;
  String? invoiceTitle;
  bool? basicTax;
  int? defaultAdminGroupId;
  int? defaultUserGroupId;
  int? taxPayerTypeId;
  bool? allowOffline;
  double? offlineTransactionLimit;
  double? offlineDayLimit;
  double? offlineSaleLimit;
  double? offlineTotalSaleLimit;
  String? merchantShortName;
  bool? allowCurrency;

  PvSalesResponseMerchantModel({
    this.id,
    this.organizationId,
    this.deleted,
    this.createDate,
    this.updateDate,
    this.createUserId,
    this.updateUserId,
    this.merchantName,
    this.typeId,
    this.isActive,
    this.taxNumber,
    this.taxOfficeId,
    this.invoiceTitle,
    this.basicTax,
    this.defaultAdminGroupId,
    this.defaultUserGroupId,
    this.taxPayerTypeId,
    this.allowOffline,
    this.offlineTransactionLimit,
    this.offlineDayLimit,
    this.offlineSaleLimit,
    this.offlineTotalSaleLimit,
    this.merchantShortName,
    this.allowCurrency,
  });

  factory PvSalesResponseMerchantModel.fromJson(Map<String, dynamic> json) => PvSalesResponseMerchantModel(
        id: json["Id"],
        organizationId: json["OrganizationId"],
        deleted: json["Deleted"],
        createDate: json["CreateDate"],
        updateDate: json["UpdateDate"],
        createUserId: json["CreateUserId"],
        updateUserId: json["UpdateUserId"],
        merchantName: json["MerchantName"],
        typeId: json["TypeId"],
        isActive: json["IsActive"],
        taxNumber: json["TaxNumber"],
        taxOfficeId: json["TaxOfficeId"],
        invoiceTitle: json["InvoiceTitle"],
        basicTax: json["BasicTax"],
        defaultAdminGroupId: json["DefaultAdminGroupId"],
        defaultUserGroupId: json["DefaultUserGroupId"],
        taxPayerTypeId: json["TaxPayerTypeId"],
        allowOffline: json["AllowOffline"],
        offlineTransactionLimit: json["OfflineTransactionLimit"]?.toDouble(),
        offlineDayLimit: json["OfflineDayLimit"]?.toDouble(),
        offlineSaleLimit: json["OfflineSaleLimit"]?.toDouble(),
        offlineTotalSaleLimit: json["OfflineTotalSaleLimit"]?.toDouble(),
        merchantShortName: json["MerchantShortName"],
        allowCurrency: json["AllowCurrency"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "OrganizationId": organizationId,
        "Deleted": deleted,
        "CreateDate": createDate,
        "UpdateDate": updateDate,
        "CreateUserId": createUserId,
        "UpdateUserId": updateUserId,
        "MerchantName": merchantName,
        "TypeId": typeId,
        "IsActive": isActive,
        "TaxNumber": taxNumber,
        "TaxOfficeId": taxOfficeId,
        "InvoiceTitle": invoiceTitle,
        "BasicTax": basicTax,
        "DefaultAdminGroupId": defaultAdminGroupId,
        "DefaultUserGroupId": defaultUserGroupId,
        "TaxPayerTypeId": taxPayerTypeId,
        "AllowOffline": allowOffline,
        "OfflineTransactionLimit": offlineTransactionLimit,
        "OfflineDayLimit": offlineDayLimit,
        "OfflineSaleLimit": offlineSaleLimit,
        "OfflineTotalSaleLimit": offlineTotalSaleLimit,
        "MerchantShortName": merchantShortName,
        "AllowCurrency": allowCurrency,
      };
}

class PvSalesResponseTerminalModel {
  int? id;
  int? organizationId;
  bool? deleted;
  String? createDate;
  String? updateDate;
  int? createUserId;
  int? updateUserId;
  int? merchantId;
  String? serialNumber;
  int? typeId;
  int? statusId;
  int? modelId;
  PvSalesResponseModelModel? model;
  String? applicationVersion;
  String? uuid;
  bool? isActive;
  String? saleHostUrl;
  int? criticalBatteryLevel;
  bool? allowOffline;
  double? offlineTransactionLimit;
  double? offlineDayLimit;
  double? offlineSaleLimit;
  bool? allowCurrency;
  int? ownerBranchId;
  bool? enableAsyncSale;
  bool? isUnattended;
  bool? isSingleUserEnabled;
  int? pairedUserId;

  PvSalesResponseTerminalModel({
    this.id,
    this.organizationId,
    this.deleted,
    this.createDate,
    this.updateDate,
    this.createUserId,
    this.updateUserId,
    this.merchantId,
    this.serialNumber,
    this.typeId,
    this.statusId,
    this.modelId,
    this.model,
    this.applicationVersion,
    this.uuid,
    this.isActive,
    this.saleHostUrl,
    this.criticalBatteryLevel,
    this.allowOffline,
    this.offlineTransactionLimit,
    this.offlineDayLimit,
    this.offlineSaleLimit,
    this.allowCurrency,
    this.ownerBranchId,
    this.enableAsyncSale,
    this.isUnattended,
    this.isSingleUserEnabled,
    this.pairedUserId,
  });

  factory PvSalesResponseTerminalModel.fromJson(Map<String, dynamic> json) => PvSalesResponseTerminalModel(
        id: json["Id"],
        organizationId: json["OrganizationId"],
        deleted: json["Deleted"],
        createDate: json["CreateDate"],
        updateDate: json["UpdateDate"],
        createUserId: json["CreateUserId"],
        updateUserId: json["UpdateUserId"],
        merchantId: json["MerchantId"],
        serialNumber: json["SerialNumber"],
        typeId: json["TypeId"],
        statusId: json["StatusId"],
        modelId: json["ModelId"],
        model: json["Model"] == null ? null : PvSalesResponseModelModel.fromJson(json["Model"]),
        applicationVersion: json["ApplicationVersion"],
        uuid: json["UUID"],
        isActive: json["IsActive"],
        saleHostUrl: json["SaleHostUrl"],
        criticalBatteryLevel: json["CriticalBatteryLevel"],
        allowOffline: json["AllowOffline"],
        offlineTransactionLimit: json["OfflineTransactionLimit"]?.toDouble(),
        offlineDayLimit: json["OfflineDayLimit"]?.toDouble(),
        offlineSaleLimit: json["OfflineSaleLimit"]?.toDouble(),
        allowCurrency: json["AllowCurrency"],
        ownerBranchId: json["OwnerBranchId"],
        enableAsyncSale: json["EnableAsyncSale"],
        isUnattended: json["IsUnattended"],
        isSingleUserEnabled: json["IsSingleUserEnabled"],
        pairedUserId: json["PairedUserId"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "OrganizationId": organizationId,
        "Deleted": deleted,
        "CreateDate": createDate,
        "UpdateDate": updateDate,
        "CreateUserId": createUserId,
        "UpdateUserId": updateUserId,
        "MerchantId": merchantId,
        "SerialNumber": serialNumber,
        "TypeId": typeId,
        "StatusId": statusId,
        "ModelId": modelId,
        "Model": model?.toJson(),
        "ApplicationVersion": applicationVersion,
        "UUID": uuid,
        "IsActive": isActive,
        "SaleHostUrl": saleHostUrl,
        "CriticalBatteryLevel": criticalBatteryLevel,
        "AllowOffline": allowOffline,
        "OfflineTransactionLimit": offlineTransactionLimit,
        "OfflineDayLimit": offlineDayLimit,
        "OfflineSaleLimit": offlineSaleLimit,
        "AllowCurrency": allowCurrency,
        "OwnerBranchId": ownerBranchId,
        "EnableAsyncSale": enableAsyncSale,
        "IsUnattended": isUnattended,
        "IsSingleUserEnabled": isSingleUserEnabled,
        "PairedUserId": pairedUserId,
      };
}

class PvSalesResponseModelModel {
  int? id;
  String? name;
  int? vendorId;
  PvSalesResponseVendorModel? vendor;
  String? code;

  PvSalesResponseModelModel({
    this.id,
    this.name,
    this.vendorId,
    this.vendor,
    this.code,
  });

  factory PvSalesResponseModelModel.fromJson(Map<String, dynamic> json) => PvSalesResponseModelModel(
        id: json["Id"],
        name: json["Name"],
        vendorId: json["VendorId"],
        vendor: json["Vendor"] == null ? null : PvSalesResponseVendorModel.fromJson(json["Vendor"]),
        code: json["Code"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "VendorId": vendorId,
        "Vendor": vendor?.toJson(),
        "Code": code,
      };
}

class PvSalesResponseVendorModel {
  int? id;
  String? name;
  String? code;
  String? notes;

  PvSalesResponseVendorModel({
    this.id,
    this.name,
    this.code,
    this.notes,
  });

  factory PvSalesResponseVendorModel.fromJson(Map<String, dynamic> json) => PvSalesResponseVendorModel(
        id: json["Id"],
        name: json["Name"],
        code: json["Code"],
        notes: json["Notes"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Code": code,
        "Notes": notes,
      };
}
