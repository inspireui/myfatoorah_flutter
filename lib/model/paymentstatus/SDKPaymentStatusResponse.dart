import 'package:myfatoorah_flutter/model/MyBaseResponse.dart';
import 'package:myfatoorah_flutter/model/executepayment/MFExecutePaymentRequest.dart';

class SDKPaymentStatusResponse extends MyBaseResponse {
  MFPaymentStatusResponse? data;

  SDKPaymentStatusResponse({this.data});

  SDKPaymentStatusResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    message = json['Message'];
    if (json['ValidationErrors'] != null) {
      validationErrors = [];
      json['ValidationErrors'].forEach((v) {
        validationErrors!.add(new ValidationErrors.fromJson(v));
      });
    }
    data = json['Data'] != null
        ? new MFPaymentStatusResponse.fromJson(json['Data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    return data;
  }
}

class MFPaymentStatusResponse {
  int? invoiceId;
  String? invoiceStatus;
  String? invoiceReference;
  String? customerReference;
  String? createdDate;
  String? expiryDate;
  double? invoiceValue;
  String? comments;
  String? customerName;
  String? customerMobile;
  String? customerEmail;
  String? userDefinedField;
  String? invoiceDisplayValue;
  List<InvoiceItem>? invoiceItems;
  List<InvoiceTransactions>? invoiceTransactions;
  List<SupplierItem>? suppliers;
  String? recurringId;

  MFPaymentStatusResponse(
      {this.invoiceId,
      this.invoiceStatus,
      this.invoiceReference,
      this.customerReference,
      this.createdDate,
      this.expiryDate,
      this.invoiceValue,
      this.comments,
      this.customerName,
      this.customerMobile,
      this.customerEmail,
      this.userDefinedField,
      this.invoiceDisplayValue,
      this.invoiceItems,
      this.invoiceTransactions,
      this.suppliers,
      this.recurringId});

  MFPaymentStatusResponse.fromJson(Map<String, dynamic> json) {
    invoiceId = json['InvoiceId'];
    invoiceStatus = json['InvoiceStatus'];
    invoiceReference = json['InvoiceReference'];
    customerReference = json['CustomerReference'];
    createdDate = json['CreatedDate'];
    expiryDate = json['ExpiryDate'];
    invoiceValue = json['InvoiceValue'];
    comments = json['Comments'];
    customerName = json['CustomerName'];
    customerMobile = json['CustomerMobile'];
    customerEmail = json['CustomerEmail'];
    userDefinedField = json['UserDefinedField'];
    invoiceDisplayValue = json['InvoiceDisplayValue'];
    if (json['InvoiceItems'] != null) {
      invoiceItems = [];
      json['InvoiceItems'].forEach((v) {
        invoiceItems!.add(new InvoiceItem.fromJson(v));
      });
    }
    if (json['InvoiceTransactions'] != null) {
      invoiceTransactions = [];
      json['InvoiceTransactions'].forEach((v) {
        invoiceTransactions!.add(new InvoiceTransactions.fromJson(v));
      });
    }
    if (json['Suppliers'] != null) {
      suppliers = [];
      json['Suppliers'].forEach((v) {
        suppliers!.add(new SupplierItem.fromJson(v));
      });
    }
    recurringId = json['RecurringId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['InvoiceId'] = this.invoiceId;
    data['InvoiceStatus'] = this.invoiceStatus;
    data['InvoiceReference'] = this.invoiceReference;
    data['CustomerReference'] = this.customerReference;
    data['CreatedDate'] = this.createdDate;
    data['ExpiryDate'] = this.expiryDate;
    data['InvoiceValue'] = this.invoiceValue;
    data['Comments'] = this.comments;
    data['CustomerName'] = this.customerName;
    data['CustomerMobile'] = this.customerMobile;
    data['CustomerEmail'] = this.customerEmail;
    data['UserDefinedField'] = this.userDefinedField;
    data['InvoiceDisplayValue'] = this.invoiceDisplayValue;
    if (this.invoiceItems != null) {
      data['InvoiceItems'] = this.invoiceItems!.map((v) => v.toJson()).toList();
    }
    if (this.invoiceTransactions != null) {
      data['InvoiceTransactions'] =
          this.invoiceTransactions!.map((v) => v.toJson()).toList();
    }
    if (this.suppliers != null) {
      data['Suppliers'] = this.suppliers!.map((v) => v.toJson()).toList();
    }
    data['RecurringId'] = this.recurringId;
    return data;
  }
}

class InvoiceTransactions {
  String? transactionDate;
  String? paymentGateway;
  String? referenceId;
  String? trackId;
  String? transactionId;
  String? paymentId;
  String? authorizationId;
  String? transactionStatus;
  String? transationValue;
  String? customerServiceCharge;
  String? dueValue;
  String? paidCurrency;
  String? paidCurrencyValue;
  String? currency;
  String? error;
  String? cardNumber;

  InvoiceTransactions(
      {this.transactionDate,
      this.paymentGateway,
      this.referenceId,
      this.trackId,
      this.transactionId,
      this.paymentId,
      this.authorizationId,
      this.transactionStatus,
      this.transationValue,
      this.customerServiceCharge,
      this.dueValue,
      this.paidCurrency,
      this.paidCurrencyValue,
      this.currency,
      this.error,
      this.cardNumber});

  InvoiceTransactions.fromJson(Map<String, dynamic> json) {
    transactionDate = json['TransactionDate'];
    paymentGateway = json['PaymentGateway'];
    referenceId = json['ReferenceId'];
    trackId = json['TrackId'];
    transactionId = json['TransactionId'];
    paymentId = json['PaymentId'];
    authorizationId = json['AuthorizationId'];
    transactionStatus = json['TransactionStatus'];
    transationValue = json['TransationValue'];
    customerServiceCharge = json['CustomerServiceCharge'];
    dueValue = json['DueValue'];
    paidCurrency = json['PaidCurrency'];
    paidCurrencyValue = json['PaidCurrencyValue'];
    currency = json['Currency'];
    error = json['Error'];
    cardNumber = json['CardNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TransactionDate'] = this.transactionDate;
    data['PaymentGateway'] = this.paymentGateway;
    data['ReferenceId'] = this.referenceId;
    data['TrackId'] = this.trackId;
    data['TransactionId'] = this.transactionId;
    data['PaymentId'] = this.paymentId;
    data['AuthorizationId'] = this.authorizationId;
    data['TransactionStatus'] = this.transactionStatus;
    data['TransationValue'] = this.transationValue;
    data['CustomerServiceCharge'] = this.customerServiceCharge;
    data['DueValue'] = this.dueValue;
    data['PaidCurrency'] = this.paidCurrency;
    data['PaidCurrencyValue'] = this.paidCurrencyValue;
    data['Currency'] = this.currency;
    data['Error'] = this.error;
    data['CardNumber'] = this.cardNumber;
    return data;
  }
}

class SupplierItem {
  int? supplierCode;
  String? supplierName;
  double? invoiceShare;
  double? proposedShare;
  double? depositShare;

  SupplierItem(
      {this.supplierCode,
      this.supplierName,
      this.invoiceShare,
      this.proposedShare,
      this.depositShare});

  SupplierItem.fromJson(Map<String, dynamic> json) {
    supplierCode = json['SupplierCode'];
    supplierName = json['SupplierName'];
    invoiceShare = json['InvoiceShare'];
    proposedShare = json['ProposedShare'];
    depositShare = json['DepositShare'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.supplierCode != null) data['SupplierCode'] = this.supplierCode;
    if (this.supplierName != null) data['SupplierName'] = this.supplierName;
    if (this.invoiceShare != null)
      data['InvoiceShare'] = this.invoiceShare.toString();
    if (this.proposedShare != null)
      data['ProposedShare'] = this.proposedShare.toString();
    if (this.depositShare != null)
      data['DepositShare'] = this.depositShare.toString();
    return data;
  }
}
