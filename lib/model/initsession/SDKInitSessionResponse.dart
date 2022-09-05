import '../MyBaseResponse.dart';

class SDKInitiateSessionResponse extends MyBaseResponse {
  MFInitiateSessionResponse? data;

  SDKInitiateSessionResponse({this.data});

  SDKInitiateSessionResponse.fromJson(Map<String, dynamic> json) {
    data = json['Data'] != null
        ? new MFInitiateSessionResponse.fromJson(json['Data'])
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

class MFInitiateSessionResponse {
  String? sessionId;
  String? countryCode;

  MFInitiateSessionResponse({this.sessionId});

  MFInitiateSessionResponse.fromJson(Map<String, dynamic> json) {
    sessionId = json['SessionId'];
    countryCode = json['CountryCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SessionId'] = this.sessionId;
    data['CountryCode'] = this.countryCode;
    return data;
  }
}
