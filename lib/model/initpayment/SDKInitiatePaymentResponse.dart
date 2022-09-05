import 'package:myfatoorah_flutter/model/MyBaseResponse.dart';

class SDKInitiatePaymentResponse extends MyBaseResponse {
  MFInitiatePaymentResponse? data;

  SDKInitiatePaymentResponse({this.data});

  SDKInitiatePaymentResponse.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null
        ? new MFInitiatePaymentResponse.fromJson(json['Data'])
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

class MFInitiatePaymentResponse {
  List<PaymentMethods>? paymentMethods;

  MFInitiatePaymentResponse({this.paymentMethods});

  MFInitiatePaymentResponse.fromJson(Map<String, dynamic> json) {
    if (json['PaymentMethods'] != null) {
      paymentMethods = [];
      json['PaymentMethods'].forEach((v) {
        paymentMethods!.add(new PaymentMethods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paymentMethods != null) {
      data['PaymentMethods'] =
          this.paymentMethods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentMethods {
  int? paymentMethodId;
  String? paymentMethodAr;
  String? paymentMethodEn;
  String? paymentMethodCode;
  bool? isDirectPayment;
  double? serviceCharge;
  double? totalAmount;
  String? currencyIso;
  String? imageUrl;

  PaymentMethods(
      {this.paymentMethodId,
      this.paymentMethodAr,
      this.paymentMethodEn,
      this.paymentMethodCode,
      this.isDirectPayment,
      this.serviceCharge,
      this.totalAmount,
      this.currencyIso,
      this.imageUrl});

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    paymentMethodId = json['PaymentMethodId'];
    paymentMethodAr = json['PaymentMethodAr'];
    paymentMethodEn = json['PaymentMethodEn'];
    paymentMethodCode = json['PaymentMethodCode'];
    isDirectPayment = json['IsDirectPayment'];
    serviceCharge = json['ServiceCharge'];
    totalAmount = json['TotalAmount'];
    currencyIso = json['CurrencyIso'];
    imageUrl = json['ImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PaymentMethodId'] = this.paymentMethodId;
    data['PaymentMethodAr'] = this.paymentMethodAr;
    data['PaymentMethodEn'] = this.paymentMethodEn;
    data['PaymentMethodCode'] = this.paymentMethodCode;
    data['IsDirectPayment'] = this.isDirectPayment;
    data['ServiceCharge'] = this.serviceCharge;
    data['TotalAmount'] = this.totalAmount;
    data['CurrencyIso'] = this.currencyIso;
    data['ImageUrl'] = this.imageUrl;
    return data;
  }
}
