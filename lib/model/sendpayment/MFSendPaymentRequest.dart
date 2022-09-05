import 'package:myfatoorah_flutter/model/executepayment/MFExecutePaymentRequest.dart';

class MFSendPaymentRequest {
  String? customerName;
  String? notificationOption;
  String? mobileCountryCode;
  String? customerMobile;
  String? customerEmail;
  double? invoiceValue;
  String? displayCurrencyIso;
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

  MFSendPaymentRequest(
      {this.customerName,
      this.notificationOption,
      this.mobileCountryCode,
      this.customerMobile,
      this.customerEmail,
      this.invoiceValue,
      this.displayCurrencyIso,
      this.callBackUrl,
      this.errorUrl,
      this.language,
      this.customerReference,
      this.customerCivilId,
      this.userDefinedField,
      this.customerAddress,
      this.expiryDate,
      @Deprecated("Use the 'suppliers' instead") this.supplierCode,
      @Deprecated("Use the 'suppliers' instead") this.supplierValue,
      this.invoiceItems,
      this.sourceInfo,
      this.suppliers});

  MFSendPaymentRequest.fromJson(Map<String, dynamic> json) {
    customerName = json['CustomerName'];
    notificationOption = json['NotificationOption'];
    mobileCountryCode = json['MobileCountryCode'];
    customerMobile = json['CustomerMobile'];
    customerEmail = json['CustomerEmail'];
    invoiceValue = json['InvoiceValue'];
    displayCurrencyIso = json['DisplayCurrencyIso'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.customerName != null) data['CustomerName'] = this.customerName;
    if (this.notificationOption != null)
      data['NotificationOption'] = this.notificationOption;
    if (this.mobileCountryCode != null)
      data['MobileCountryCode'] = this.mobileCountryCode;
    if (this.customerMobile != null)
      data['CustomerMobile'] = this.customerMobile;
    if (this.customerEmail != null) data['CustomerEmail'] = this.customerEmail;
    if (this.invoiceValue != null)
      data['InvoiceValue'] = this.invoiceValue.toString();
    if (this.displayCurrencyIso != null)
      data['DisplayCurrencyIso'] = this.displayCurrencyIso;
    if (this.callBackUrl != null) data['CallBackUrl'] = this.callBackUrl;
    if (this.errorUrl != null) data['ErrorUrl'] = this.errorUrl;
    if (this.language != null) data['Language'] = this.language;
    if (this.customerReference != null)
      data['CustomerReference'] = this.customerReference;
    if (this.customerCivilId != null)
      data['CustomerCivilId'] = this.customerCivilId;
    if (this.userDefinedField != null)
      data['UserDefinedField'] = this.userDefinedField;
    if (this.customerAddress != null)
      data['CustomerAddress'] = this.customerAddress!.toJson();
    if (this.expiryDate != null) data['ExpiryDate'] = this.expiryDate;
    if (this.supplierCode != null)
      data['SupplierCode'] = this.supplierCode.toString();
    if (this.supplierValue != null)
      data['SupplierValue'] = this.supplierValue.toString();
    if (this.invoiceItems != null)
      data['InvoiceItems'] = this.invoiceItems!.map((v) => v.toJson()).toList();
    if (this.sourceInfo != null) data['SourceInfo'] = this.sourceInfo;
    if (this.suppliers != null)
      data['Suppliers'] = this.suppliers!.map((v) => v.toJson()).toList();
    return data;
  }
}
