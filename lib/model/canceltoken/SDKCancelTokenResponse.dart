import 'package:myfatoorah_flutter/model/MyBaseResponse.dart';

class SDKCancelTokenResponse extends MyBaseResponse {
  bool? data;

  SDKCancelTokenResponse({this.data});

  SDKCancelTokenResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    message = json['Message'];
    if (json['ValidationErrors'] != null) {
      validationErrors = [];
      json['ValidationErrors'].forEach((v) {
        validationErrors!.add(new ValidationErrors.fromJson(v));
      });
    }
    data = json['Data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    data['Message'] = this.message;
    if (this.validationErrors != null) {
      data['ValidationErrors'] =
          this.validationErrors!.map((v) => v.toJson()).toList();
    }
    data['Data'] = this.data;
    return data;
  }
}
