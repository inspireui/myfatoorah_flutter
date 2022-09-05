import 'package:myfatoorah_flutter/model/directpayment/SDKDirectPaymentResponse.dart';
import 'package:myfatoorah_flutter/model/paymentstatus/SDKPaymentStatusResponse.dart';

class MFDirectPaymentResponse {
  MFPaymentStatusResponse? mfPaymentStatusResponse;
  DirectPaymentResponse? cardInfoResponse;

  MFDirectPaymentResponse(MFPaymentStatusResponse? mfPaymentStatusResponse,
      DirectPaymentResponse? cardInfoResponse) {
    this.mfPaymentStatusResponse = mfPaymentStatusResponse;
    this.cardInfoResponse = cardInfoResponse;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mfPaymentStatusResponse != null) {
      data['mfPaymentStatusResponse'] = this.mfPaymentStatusResponse!.toJson();
    }
    if (this.cardInfoResponse != null)
      data["cardInfoResponse"] = this.cardInfoResponse!.toJson();
    return data;
  }
}
