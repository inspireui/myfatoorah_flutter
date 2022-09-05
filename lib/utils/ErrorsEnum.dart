import 'package:myfatoorah_flutter/model/MFError.dart';

enum ErrorsEnum {
  INTERNET_CONNECTION_ERROR,

  CONFIG_BASE_URL_ERROR,

  CONFIG_API_KEY_ERROR,

  INVALID_CARD_NUMBER_ERROR,
  INVALID_CARD_EXPIRY_MONTH_ERROR,
  INVALID_CARD_EXPIRY_YEAR_ERROR,
  INVALID_CARD_SECURITY_CODE_ERROR,
  INVALID_CARD_HOLDER_NAME_ERROR,

  INCORRECT_PAYMENT_METHOD_ERROR,

  DIRECT_PAYMENT_NOT_FOUND_ERROR,

  PAYMENT_CANCELLED_ERROR,

  PAYMENT_TRANSACTION_FAILED_ERROR,

  EMBEDDED_PAYMENT_ERROR,

  UN_KNOWN_ERROR,

  EXECUTE_PAYMENT_WITHOUT_PAYMENT_METHOD_ID_ERROR,

  EMBEDDED_PAYMENT_WITH_PAYMENT_METHOD_ID_ERROR,

  APPLE_PAY_CURRENCY_ERROR,

  BAD_REQUEST_ERROR,

  UN_AUTHORIZED_ERROR,

  NOT_FOUND_ERROR,

  SERVER_ERROR
}

class ErrorHelper {
  static MFError getValue(ErrorsEnum color) {
    switch (color) {
      case ErrorsEnum.INTERNET_CONNECTION_ERROR:
        return new MFError(100, "Internet connection error");

      case ErrorsEnum.CONFIG_BASE_URL_ERROR:
        return new MFError(101, "The base URL is empty");

      case ErrorsEnum.CONFIG_API_KEY_ERROR:
        return new MFError(102, "The API token key is empty");

      case ErrorsEnum.INVALID_CARD_NUMBER_ERROR:
        return new MFError(103, "Invalid card number");
      case ErrorsEnum.INVALID_CARD_EXPIRY_MONTH_ERROR:
        return new MFError(103, "Invalid expiry month");
      case ErrorsEnum.INVALID_CARD_EXPIRY_YEAR_ERROR:
        return new MFError(103, "Invalid expiry year");
      case ErrorsEnum.INVALID_CARD_SECURITY_CODE_ERROR:
        return new MFError(103, "Invalid security code");
      case ErrorsEnum.INVALID_CARD_HOLDER_NAME_ERROR:
        return new MFError(103, "Invalid card holder name");

      case ErrorsEnum.INCORRECT_PAYMENT_METHOD_ERROR:
        return new MFError(104, "Your are using incorrect payment method");

      case ErrorsEnum.DIRECT_PAYMENT_NOT_FOUND_ERROR:
        return new MFError(105, "Your account doesn\'t have a direct payment");

      case ErrorsEnum.PAYMENT_CANCELLED_ERROR:
        return new MFError(106, "User clicked back button");

      case ErrorsEnum.PAYMENT_TRANSACTION_FAILED_ERROR:
        return new MFError(
            107, ""); // Error message will be get from transaction object;

      case ErrorsEnum.EMBEDDED_PAYMENT_ERROR:
        return new MFError(
            108, ""); // Error message will be get from embedded payment

      case ErrorsEnum.BAD_REQUEST_ERROR:
        return new MFError(400, ""); // Error will be get from backend response;

      case ErrorsEnum.EXECUTE_PAYMENT_WITHOUT_PAYMENT_METHOD_ID_ERROR:
        return new MFError(
            111, "You can\'t call executePayment without paymentMethodId");

      case ErrorsEnum.EMBEDDED_PAYMENT_WITH_PAYMENT_METHOD_ID_ERROR:
        return new MFError(112,
            "You can\'t pass paymentMethodId while using embedded payment");

      case ErrorsEnum.APPLE_PAY_CURRENCY_ERROR:
        return new MFError(113, "You should set 'displayCurrencyIso'");

      case ErrorsEnum.UN_KNOWN_ERROR:
        return new MFError(110, "Unknown error");

      case ErrorsEnum.UN_AUTHORIZED_ERROR:
        return new MFError(401,
            "The authorization token is incorrect or expired, or may be you are using test token with live environment or vise-versa");

      case ErrorsEnum.NOT_FOUND_ERROR:
        return new MFError(404, "Not found");

      case ErrorsEnum.SERVER_ERROR:
        return new MFError(500,
            "An error has been occurred, please contact MyFatoorah at tech@myfatoorah.com");

      default:
        return new MFError(110, "Unknown error");
    }
  }
}
