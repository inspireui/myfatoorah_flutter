import 'package:myfatoorah_flutter/utils/AppConstants.dart';
import 'package:myfatoorah_flutter/utils/MFRecurringType.dart';
export 'package:myfatoorah_flutter/model/directpayment/MFCardInfo.dart';

class MFCardInfo {
  String? paymentType;
  bool? saveToken;
  bool? isRecurring;
  int? _intervalDays;
  String? _recurringType;
  int? iteration = 0;
  Card? card;
  String? token;
  bool? bypass3DS;

  MFCardInfo(
      {String cardToken = "",
      String? cardNumber,
      String? expiryMonth,
      String? expiryYear,
      String? securityCode,
      String? cardHolderName,
      bool bypass3DS: false,
      bool saveToken: false}) {
    if (cardToken.isNotEmpty) {
      this.paymentType = AppConstants.KEY_TOKEN;
      this.token = cardToken;
    } else {
      this.paymentType = AppConstants.KEY_CARD;
      this.card = new Card(
          cardNumber, expiryMonth, expiryYear, securityCode, cardHolderName);
    }

    this.saveToken = saveToken;
    this.bypass3DS = bypass3DS;
  }

  void setRecurringIntervalDays(int intervalDays) {
    this.isRecurring = true;
    this.saveToken = false;
    this._intervalDays = intervalDays;
  }

  void setRecurringPeriod(MFRecurringType mfRecurringType) {
    this.isRecurring = true;
    this.saveToken = false;

    if (mfRecurringType.type == Type.CUSTOM) {
      _recurringType = "Custom";
      _intervalDays = mfRecurringType.days;
    } else if (mfRecurringType.type == Type.DAILY)
      _recurringType = "Daily";
    else if (mfRecurringType.type == Type.WEEKLY)
      _recurringType = "Weekly";
    else if (mfRecurringType.type == Type.MONTHLY) _recurringType = "Monthly";
  }

  MFCardInfo.fromJson(Map<String, dynamic> json) {
    paymentType = json['PaymentType'];
    saveToken = json['SaveToken'] == 'true';
    isRecurring = json['IsRecurring'] == 'true';
    _intervalDays = json['IntervalDays'];
    _recurringType = json['RecurringType'];
    iteration = json['Iteration'];
    card = json['Card'] != null ? new Card.fromJson(json['Card']) : null;
    token = json['Token'];
    bypass3DS = json['Bypass3DS'] == 'false';
  }

  Map<String, Object?> toJson() {
    final Map<String, Object?> data = new Map<String, Object?>();
    if (this.paymentType != null) data['PaymentType'] = this.paymentType;
    if (this.saveToken != null) data['SaveToken'] = this.saveToken.toString();
    if (this.isRecurring != null)
      data['IsRecurring'] = this.isRecurring.toString();
    if (this._intervalDays != null) data['IntervalDays'] = this._intervalDays;
    if (this._recurringType != null)
      data['RecurringType'] = this._recurringType;
    if (this.iteration != null) data['Iteration'] = this.iteration;
    if (this.card != null) {
      data['Card'] = this.card!.toJson();
    }
    if (this.token != null) data['Token'] = this.token;
    if (this.bypass3DS != null) data['Bypass3DS'] = this.bypass3DS.toString();
    return data;
  }
}

class Card {
  String? number;
  String? expiryMonth;
  String? expiryYear;
  String? securityCode;
  String? cardHolderName;

  Card(this.number, this.expiryMonth, this.expiryYear, this.securityCode,
      this.cardHolderName) {
    this.number = number;
    this.expiryMonth = expiryMonth;
    this.expiryYear = expiryYear;
    this.securityCode = securityCode;
    this.cardHolderName = cardHolderName;
  }

  Card.fromJson(Map<String, dynamic> json) {
    number = json['Number'];
    expiryMonth = json['ExpiryMonth'];
    expiryYear = json['ExpiryYear'];
    securityCode = json['SecurityCode'];
    cardHolderName = json['CardHolderName'];
  }

  toMap() {
    return {
      "Number": this.number,
      "ExpiryMonth": this.expiryMonth,
      "ExpiryYear": this.expiryYear,
      "SecurityCode": this.securityCode,
      "CardHolderName": this.cardHolderName
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Number'] = this.number;
    data['ExpiryMonth'] = this.expiryMonth;
    data['ExpiryYear'] = this.expiryYear;
    data['SecurityCode'] = this.securityCode;
    data['CardHolderName'] = this.cardHolderName;
    return data;
  }
}
