class MFError {
  int? code;
  String? message;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.code;
    data['message'] = this.message;
    return data;
  }

  MFError(int? _code, String? _message) {
    this.code = _code;
    this.message = _message;
  }
}
