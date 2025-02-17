import '../../utils/AppConstants.dart';
import '../../utils/MFRecurringType.dart';

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

  MFCardInfo({
    String cardToken = '',
    String? cardNumber,
    String? expiryMonth,
    String? expiryYear,
    String? securityCode,
    String? cardHolderName,
    bool bypass3DS = false,
    bool saveToken = false,
  }) {
    if (cardToken.isNotEmpty) {
      paymentType = AppConstants.KEY_TOKEN;
      token = cardToken;
    } else {
      paymentType = AppConstants.KEY_CARD;
      card = Card(
          cardNumber, expiryMonth, expiryYear, securityCode, cardHolderName);
    }

    this.saveToken = saveToken;
    this.bypass3DS = bypass3DS;
  }

  void setRecurringIntervalDays(int intervalDays) {
    isRecurring = true;
    saveToken = false;
    _intervalDays = intervalDays;
  }

  void setRecurringPeriod(MFRecurringType mfRecurringType) {
    isRecurring = true;
    saveToken = false;

    if (mfRecurringType.type == Type.CUSTOM) {
      _recurringType = 'Custom';
      _intervalDays = mfRecurringType.days;
    } else if (mfRecurringType.type == Type.DAILY)
      _recurringType = 'Daily';
    else if (mfRecurringType.type == Type.WEEKLY)
      _recurringType = 'Weekly';
    else if (mfRecurringType.type == Type.MONTHLY) _recurringType = 'Monthly';
  }

  MFCardInfo.fromJson(Map<String, dynamic> json) {
    paymentType = json['PaymentType'];
    saveToken = json['SaveToken'] == 'true';
    isRecurring = json['IsRecurring'] == 'true';
    _intervalDays = json['IntervalDays'];
    _recurringType = json['RecurringType'];
    iteration = json['Iteration'];
    card = json['Card'] != null ? Card.fromJson(json['Card']) : null;
    token = json['Token'];
    bypass3DS = json['Bypass3DS'] == 'false';
  }

  Map<String, Object?> toJson() {
    final data = <String, Object?>{};
    if (paymentType != null) data['PaymentType'] = paymentType;
    if (saveToken != null) data['SaveToken'] = saveToken.toString();
    if (isRecurring != null) data['IsRecurring'] = isRecurring.toString();
    if (_intervalDays != null) data['IntervalDays'] = _intervalDays;
    if (_recurringType != null) data['RecurringType'] = _recurringType;
    if (iteration != null) data['Iteration'] = iteration;
    if (card != null) {
      data['Card'] = card!.toJson();
    }
    if (token != null) data['Token'] = token;
    if (bypass3DS != null) data['Bypass3DS'] = bypass3DS.toString();
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
    number = number;
    expiryMonth = expiryMonth;
    expiryYear = expiryYear;
    securityCode = securityCode;
    cardHolderName = cardHolderName;
  }

  Card.fromJson(Map<String, dynamic> json) {
    number = json['Number'];
    expiryMonth = json['ExpiryMonth'];
    expiryYear = json['ExpiryYear'];
    securityCode = json['SecurityCode'];
    cardHolderName = json['CardHolderName'];
  }

  Map<String, String?> toMap() {
    return {
      'Number': number,
      'ExpiryMonth': expiryMonth,
      'ExpiryYear': expiryYear,
      'SecurityCode': securityCode,
      'CardHolderName': cardHolderName
    };
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Number'] = number;
    data['ExpiryMonth'] = expiryMonth;
    data['ExpiryYear'] = expiryYear;
    data['SecurityCode'] = securityCode;
    data['CardHolderName'] = cardHolderName;
    return data;
  }
}
