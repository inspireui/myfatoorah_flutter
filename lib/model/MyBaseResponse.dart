class MyBaseResponse {
  bool? isSuccess;
  String? message;
  List<ValidationErrors>? validationErrors;

  MyBaseResponse({this.isSuccess, this.message, this.validationErrors});

  MyBaseResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    message = json['Message'];
    if (json['ValidationErrors'] != null) {
      validationErrors = [];
      json['ValidationErrors'].forEach((v) {
        validationErrors!.add(new ValidationErrors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    data['Message'] = this.message;
    if (this.validationErrors != null) {
      data['ValidationErrors'] =
          this.validationErrors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ValidationErrors {
  String? name;
  String? error;

  ValidationErrors({this.name, this.error});

  ValidationErrors.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    error = json['Error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Error'] = this.error;
    return data;
  }
}
