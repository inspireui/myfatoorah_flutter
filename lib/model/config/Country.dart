class Country {
  String? portal;
  String? v1;
  String? v2;
  String? testPortal;
  String? testv1;
  String? testv2;

  Country(
      {this.portal,
      this.v1,
      this.v2,
      this.testPortal,
      this.testv1,
      this.testv2});

  Country.fromJson(Map<String, dynamic> json) {
    portal = json['portal'];
    v1 = json['v1'];
    v2 = json['v2'];
    testPortal = json['testPortal'];
    testv1 = json['testv1'];
    testv2 = json['testv2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['portal'] = this.portal;
    data['v1'] = this.v1;
    data['v2'] = this.v2;
    data['testPortal'] = this.testPortal;
    data['testv1'] = this.testv1;
    data['testv2'] = this.testv2;
    return data;
  }
}
