import 'package:myfatoorah_flutter/model/MyBaseResponse.dart';

class SDKDirectPaymentResponse extends MyBaseResponse {
  DirectPaymentResponse? data;

  SDKDirectPaymentResponse({this.data});

  SDKDirectPaymentResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    message = json['Message'];
    if (json['ValidationErrors'] != null) {
      validationErrors = [];
      json['ValidationErrors'].forEach((v) {
        validationErrors!.add(new ValidationErrors.fromJson(v));
      });
    }
    data = json['Data'] != null
        ? new DirectPaymentResponse.fromJson(json['Data'])
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

class DirectPaymentResponse {
  String? status;
  String? errorMessage;
  String? paymentId;
  String? token;
  String? paymentURL;
  CardInfo? cardInfo;

  DirectPaymentResponse(
      {this.status,
      this.errorMessage,
      this.paymentId,
      this.token,
      this.paymentURL,
      this.cardInfo});

  DirectPaymentResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    errorMessage = json['ErrorMessage'];
    paymentId = json['PaymentId'];
    token = json['Token'];
    paymentURL = json['PaymentURL'];
    cardInfo = json['CardInfo'] != null
        ? new CardInfo.fromJson(json['CardInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['ErrorMessage'] = this.errorMessage;
    data['PaymentId'] = this.paymentId;
    data['Token'] = this.token;
    data['PaymentURL'] = this.paymentURL;
    if (this.cardInfo != null) {
      data['CardInfo'] = this.cardInfo!.toJson();
    }
    return data;
  }
}

class CardInfo {
  String? number;
  String? expiryMonth;
  String? expiryYear;
  String? brand;
  String? issuer;

  CardInfo(
      {this.number,
      this.expiryMonth,
      this.expiryYear,
      this.brand,
      this.issuer});

  CardInfo.fromJson(Map<String, dynamic> json) {
    number = json['Number'];
    expiryMonth = json['ExpiryMonth'];
    expiryYear = json['ExpiryYear'];
    brand = json['Brand'];
    issuer = json['Issuer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Number'] = this.number;
    data['ExpiryMonth'] = this.expiryMonth;
    data['ExpiryYear'] = this.expiryYear;
    data['Brand'] = this.brand;
    data['Issuer'] = this.issuer;
    return data;
  }
}
