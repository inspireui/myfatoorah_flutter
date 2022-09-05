import 'package:myfatoorah_flutter/model/MFError.dart';

class MFResult<T> {
  Status? status;
  T? response;
  MFError? error;

  MFResult(Status? status, T? response, MFError? error) {
    this.status = status;
    this.response = response;
    this.error = error;
  }

  static MFResult<T?> success<T>(T? response) {
    return new MFResult<T>(Status.SUCCESS, response, null);
  }

  static MFResult<T?> fail<T>(MFError? error) {
    return new MFResult<T>(Status.ERROR, null, error);
  }

  bool isSuccess() {
    return status == Status.SUCCESS && response != null;
  }
}

enum Status { SUCCESS, ERROR }
