import 'package:myfatoorah_flutter/utils/MFKeyType.dart';

class MFPaymentStatusRequest {
  String? key = "";
  String? keyType = "";

  MFPaymentStatusRequest({String? invoiceId, String? paymentId}) {
    if (invoiceId == null) {
      this.key = paymentId;
      this.keyType = MFKeyType.PAYMENT_ID;
    } else if (paymentId == null) {
      this.key = invoiceId;
      this.keyType = MFKeyType.INVOICE_ID;
    }
  }

  MFPaymentStatusRequest.fromJson(Map<String, dynamic> json) {
    key = json['Key'];
    keyType = json['KeyType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Key'] = this.key;
    data['KeyType'] = this.keyType;
    return data;
  }
}
