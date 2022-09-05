class MFInitiateSessionRequest {
  String customerIdentifier = "";

  MFInitiateSessionRequest(String customerIdentifier) {
    this.customerIdentifier = customerIdentifier;
  }

  MFInitiateSessionRequest.fromJson(Map<String, dynamic> json) {
    customerIdentifier = json['CustomerIdentifier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CustomerIdentifier'] = this.customerIdentifier;
    return data;
  }
}
