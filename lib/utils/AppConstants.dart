abstract class AppConstants {
  static String versionPrefix = "/v";
  static String mAPIVersion = "2";

  static String loadConfig =
      "https://portal.myfatoorah.com/Files/API/mf-config.json";
  static String sendPayment = versionPrefix + mAPIVersion + "/SendPayment";
  static String initiatePayment =
      versionPrefix + mAPIVersion + "/InitiatePayment";
  static String executePayment =
      versionPrefix + mAPIVersion + "/ExecutePayment";
  static String paymentStatus =
      versionPrefix + mAPIVersion + "/GetPaymentStatus";
  static String cancelRecurringPayment =
      versionPrefix + mAPIVersion + "/CancelRecurringPayment";
  static String cancelToken = versionPrefix + mAPIVersion + "/CancelToken";
  static String initSession = versionPrefix + mAPIVersion + "/InitiateSession";

  static String? callBackUrl = "https://myfatoorah.com/";
  static String? errorUrl = "https://myfatooraherror.com/";

  static String apiKey = "";

  static const SUCCESS = 200;
  static const SERVER_ERROR = 500;
  static const CONFIG_ERROR = 100;
  static const UN_AUTHORIZED_ERROR = 401;
  static const CONNECTION_ERROR = -2;
  static const PAYMENT_CANCELED_ERROR = -1;

  static const KEY_CARD = "card";
  static const KEY_TOKEN = "token";

  static const TRANSACTION_SUCCESS = "Succss";
  static const TRANSACTION_FAILED = "Failed";
}
