import '../MyBaseResponse.dart';

class SDKSendPaymentResponse extends MyBaseResponse {
  MFSendPaymentResponse? data;

  SDKSendPaymentResponse({this.data});

  SDKSendPaymentResponse.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null
        ? new MFSendPaymentResponse.fromJson(json['Data'])
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

class MFSendPaymentResponse {
  int? invoiceId;
  String? invoiceURL;
  String? customerReference;
  String? userDefinedField;

  MFSendPaymentResponse(
      {this.invoiceId,
      this.invoiceURL,
      this.customerReference,
      this.userDefinedField});

  MFSendPaymentResponse.fromJson(Map<String, dynamic> json) {
    invoiceId = json['InvoiceId'];
    invoiceURL = json['InvoiceURL'];
    customerReference = json['CustomerReference'];
    userDefinedField = json['UserDefinedField'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['InvoiceId'] = this.invoiceId;
    data['InvoiceURL'] = this.invoiceURL;
    data['CustomerReference'] = this.customerReference;
    data['UserDefinedField'] = this.userDefinedField;
    return data;
  }
}
