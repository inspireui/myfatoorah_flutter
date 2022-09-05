import 'package:myfatoorah_flutter/utils/MFCountry.dart';
import 'package:myfatoorah_flutter/utils/MFEnvironment.dart';

class UserConfig {
  late MFEnvironment environment;
  late MFCountry country;

  UserConfig(MFEnvironment environment, MFCountry country) {
    this.environment = environment;
    this.country = country;
  }
}
