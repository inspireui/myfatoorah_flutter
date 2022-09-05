import 'package:myfatoorah_flutter/model/config/Country.dart';
import 'package:myfatoorah_flutter/model/config/UserConfig.dart';
import 'package:myfatoorah_flutter/utils/MFCountry.dart';
import 'package:myfatoorah_flutter/utils/MFEnvironment.dart';

class ConfigManager {
  static UserConfig? mUserConfig;
  static Map<String, Country>? mCountries = Map();

  static setUserConfig(UserConfig? userConfig) {
    mUserConfig = userConfig;
  }

  static setCountries(Map<String, Country>? countries) {
    mCountries = countries;
  }

  static getBaseURL() {
    var countryKey = MFCountryHelper.getCountryKey(mUserConfig!.country);
    var country = mCountries?[countryKey];

    if (mUserConfig?.environment == MFEnvironment.LIVE)
      return country?.v2;
    else if (mUserConfig?.environment == MFEnvironment.TEST)
      return country?.testv2;
    return "";
  }

  static getEmbeddedPaymentBaseURL() {
    var countryKey = MFCountryHelper.getCountryKey(mUserConfig!.country);
    var country = mCountries?[countryKey];

    if (mUserConfig?.environment == MFEnvironment.LIVE)
      return country?.portal;
    else if (mUserConfig?.environment == MFEnvironment.TEST)
      return country?.testPortal;
    return "";
  }

  static bool isConfigLoaded() {
    return mCountries != null && mCountries!.isNotEmpty;
  }

  static bool isLive() {
    return mUserConfig?.environment == MFEnvironment.LIVE;
  }
}
