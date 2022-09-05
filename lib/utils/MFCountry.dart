import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:myfatoorah_flutter/utils/MFEnvironment.dart';

enum MFCountry {
  KUWAIT,
  SAUDI_ARABIA,
  BAHRAIN,
  UNITED_ARAB_EMIRATES,
  QATAR,
  OMAN,
  JORDAN,
  EGYPT
}

class MFCountryHelper {
  static getCountryKey(MFCountry mfCountry) {
    switch (mfCountry) {
      case MFCountry.KUWAIT:
        return "KWT";
      case MFCountry.SAUDI_ARABIA:
        return "SAU";
      case MFCountry.BAHRAIN:
        return "BHR";
      case MFCountry.UNITED_ARAB_EMIRATES:
        return "ARE";
      case MFCountry.QATAR:
        return "QAT";
      case MFCountry.OMAN:
        return "OMN";
      case MFCountry.JORDAN:
        return "JOD";
      case MFCountry.EGYPT:
        return "EGY";
    }
  }
}
