class MFInitiatePaymentRequest {
  double? invoiceAmount;
  String? currencyIso;

  MFInitiatePaymentRequest(double invoiceAmount, String currencyIso) {
    this.invoiceAmount = invoiceAmount;
    this.currencyIso = currencyIso;
  }

  MFInitiatePaymentRequest.fromJson(Map<String, dynamic> json) {
    invoiceAmount = json['InvoiceAmount'];
    currencyIso = json['CurrencyIso'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['InvoiceAmount'] = this.invoiceAmount.toString();
    data['CurrencyIso'] = this.currencyIso;
    return data;
  }
}
