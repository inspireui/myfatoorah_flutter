import 'package:myfatoorah_flutter/utils/MFRecurringType.dart';

class MFExecutePaymentRequest {
  int? paymentMethodId;
  String? sessionId;
  String? customerName;
  String? displayCurrencyIso;
  String? mobileCountryCode;
  String? customerMobile;
  String? customerEmail;
  double? invoiceValue;
  String? callBackUrl;
  String? errorUrl;
  String? language;
  String? customerReference;
  String? customerCivilId;
  String? userDefinedField;
  CustomerAddress? customerAddress;
  String? expiryDate;
  @Deprecated("Use the 'suppliers' instead")
  int? supplierCode;
  @Deprecated("Use the 'suppliers' instead")
  double? supplierValue;
  List<InvoiceItem>? invoiceItems;
  String? sourceInfo;
  List<Supplier>? suppliers;
  RecurringModel? recurringModel;

  MFExecutePaymentRequest(int paymentMethodId, double invoiceValue) {
    this.paymentMethodId = paymentMethodId;
    this.invoiceValue = invoiceValue;
  }

  MFExecutePaymentRequest.constructor(double invoiceValue) {
    this.invoiceValue = invoiceValue;
  }

  MFExecutePaymentRequest.constructorForApplyPay(
      double invoiceValue, String displayCurrencyIso) {
    this.invoiceValue = invoiceValue;
    this.displayCurrencyIso = displayCurrencyIso;
  }

  MFExecutePaymentRequest.fromJson(Map<String, dynamic> json) {
    paymentMethodId = json['PaymentMethodId'];
    sessionId = json['SessionId'];
    customerName = json['CustomerName'];
    displayCurrencyIso = json['DisplayCurrencyIso'];
    mobileCountryCode = json['MobileCountryCode'];
    customerMobile = json['CustomerMobile'];
    customerEmail = json['CustomerEmail'];
    invoiceValue = json['InvoiceValue'];
    callBackUrl = json['CallBackUrl'];

    errorUrl = json['ErrorUrl'];
    language = json['Language'];
    customerReference = json['CustomerReference'];
    customerCivilId = json['CustomerCivilId'];
    userDefinedField = json['UserDefinedField'];
    customerAddress = json['CustomerAddress'] != null
        ? new CustomerAddress.fromJson(json['CustomerAddress'])
        : null;
    expiryDate = json['ExpiryDate'];
    supplierCode = json['SupplierCode'];
    supplierValue = json['SupplierValue'];
    if (json['InvoiceItems'] != null) {
      invoiceItems = [];
      json['InvoiceItems'].forEach((v) {
        invoiceItems!.add(new InvoiceItem.fromJson(v));
      });
    }
    sourceInfo = json['SourceInfo'];
    if (json['Suppliers'] != null) {
      suppliers = [];
      json['Suppliers'].forEach((v) {
        suppliers!.add(new Supplier.fromJson(v));
      });
    }
    recurringModel = json['RecurringModel'] != null
        ? new RecurringModel.fromJson(json['RecurringModel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentMethodId != null)
      data['PaymentMethodId'] = this.paymentMethodId.toString();
    if (this.sessionId != null) data['SessionId'] = this.sessionId;
    if (this.customerName != null) data['CustomerName'] = this.customerName;
    if (this.displayCurrencyIso != null)
      data['DisplayCurrencyIso'] = this.displayCurrencyIso;
    if (this.mobileCountryCode != null)
      data['MobileCountryCode'] = this.mobileCountryCode;
    if (this.customerMobile != null)
      data['CustomerMobile'] = this.customerMobile;
    if (this.customerEmail != null) data['CustomerEmail'] = this.customerEmail;
    if (this.invoiceValue != null)
      data['InvoiceValue'] = this.invoiceValue.toString();
    if (this.callBackUrl != null) data['CallBackUrl'] = this.callBackUrl;
    if (this.errorUrl != null) data['ErrorUrl'] = this.errorUrl;
    if (this.language != null) data['Language'] = this.language;
    if (this.customerReference != null)
      data['CustomerReference'] = this.customerReference;
    if (this.customerCivilId != null)
      data['CustomerCivilId'] = this.customerCivilId;
    if (this.userDefinedField != null)
      data['UserDefinedField'] = this.userDefinedField;
    if (this.customerAddress != null) {
      data['CustomerAddress'] = this.customerAddress!.toJson();
    }
    if (this.expiryDate != null) data['ExpiryDate'] = this.expiryDate;
    if (this.supplierCode != null)
      data['SupplierCode'] = this.supplierCode.toString();
    if (this.supplierValue != null)
      data['SupplierValue'] = this.supplierValue.toString();
    if (this.invoiceItems != null) {
      data['InvoiceItems'] = this.invoiceItems!.map((v) => v.toJson()).toList();
    }
    if (this.sourceInfo != null) data['SourceInfo'] = this.sourceInfo;
    if (this.suppliers != null)
      data['Suppliers'] = this.suppliers!.map((v) => v.toJson()).toList();
    if (this.recurringModel != null)
      data['RecurringModel'] = this.recurringModel!.toJson();
    return data;
  }
}

class CustomerAddress {
  String? block;
  String? street;
  String? houseBuildingNo;
  String? address;
  String? addressInstructions;

  CustomerAddress(
      {this.block,
      this.street,
      this.houseBuildingNo,
      this.address,
      this.addressInstructions});

  CustomerAddress.fromJson(Map<String, dynamic> json) {
    block = json['Block'];
    street = json['Street'];
    houseBuildingNo = json['HouseBuildingNo'];
    address = json['Address'];
    addressInstructions = json['AddressInstructions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.block != null) data['Block'] = this.block;
    if (this.street != null) data['Street'] = this.street;
    if (this.houseBuildingNo != null)
      data['HouseBuildingNo'] = this.houseBuildingNo;
    if (this.address != null) data['Address'] = this.address;
    if (this.addressInstructions != null)
      data['AddressInstructions'] = this.addressInstructions;
    return data;
  }
}

class InvoiceItem {
  String? itemName;
  int? quantity;
  double? unitPrice;

  InvoiceItem({this.itemName, this.quantity, this.unitPrice});

  InvoiceItem.fromJson(Map<String, dynamic> json) {
    itemName = json['ItemName'];
    quantity = json['Quantity'];
    unitPrice = json['UnitPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.itemName != null) data['ItemName'] = this.itemName;
    if (this.quantity != null) data['Quantity'] = this.quantity.toString();
    if (this.unitPrice != null) data['UnitPrice'] = this.unitPrice.toString();
    return data;
  }
}

class Supplier {
  int? supplierCode;
  double? proposedShare;
  double? invoiceShare;

  Supplier({this.supplierCode, this.proposedShare, this.invoiceShare});

  Supplier.fromJson(Map<String, dynamic> json) {
    supplierCode = json['SupplierCode'];
    proposedShare = json['ProposedShare'];
    invoiceShare = json['InvoiceShare'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.supplierCode != null)
      data['SupplierCode'] = this.supplierCode.toString();
    if (this.proposedShare != null)
      data['ProposedShare'] = this.proposedShare.toString();
    if (this.invoiceShare != null)
      data['InvoiceShare'] = this.invoiceShare.toString();
    return data;
  }
}

class RecurringModel {
  String? recurringType;
  int? intervalDays;
  int? iteration;

  RecurringModel(MFRecurringType mfRecurringType, {int? iteration}) {
    this.iteration = iteration;
    if (mfRecurringType.type == Type.CUSTOM) {
      this.recurringType = "Custom";
      this.intervalDays = mfRecurringType.days;
    } else if (mfRecurringType.type == Type.DAILY)
      this.recurringType = "Daily";
    else if (mfRecurringType.type == Type.WEEKLY)
      this.recurringType = "Weekly";
    else if (mfRecurringType.type == Type.MONTHLY)
      this.recurringType = "Monthly";
  }

  RecurringModel.fromJson(Map<String, dynamic> json) {
    recurringType = json['RecurringType'];
    intervalDays = json['IntervalDays'];
    iteration = json['Iteration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recurringType != null)
      data['RecurringType'] = this.recurringType.toString();
    if (this.intervalDays != null)
      data['IntervalDays'] = this.intervalDays.toString();
    if (this.iteration != null) data['Iteration'] = this.iteration.toString();
    return data;
  }
}
