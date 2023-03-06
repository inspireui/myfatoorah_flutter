import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myfatoorah_flutter/ConfigManager.dart';
import 'package:myfatoorah_flutter/model/MFError.dart';
import 'package:myfatoorah_flutter/model/initsession/SDKInitSessionResponse.dart';
import 'package:myfatoorah_flutter/utils/ErrorsEnum.dart';
import 'package:webview_flutter/src/webview_flutter_legacy.dart';

import '../myfatoorah_flutter.dart';
import 'MFApplePayButton.dart';

class MFApplePayButtonWebView extends State<MFApplePayButton> {
  static late MFExecutePaymentRequest request;
  static late String apiLang;
  static late Function callback;
  static double mHeight = 0;
  static WebViewController? _webViewController;

  MFApplePayButtonWebView(double height) {
    WidgetsFlutterBinding.ensureInitialized();
    mHeight = height;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: mHeight,
        alignment: Alignment.center,
        child: GestureDetector(
          onHorizontalDragUpdate: (updateDetails) {},
          onVerticalDragUpdate: (updateDetails) {},
          child: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _webViewController = webViewController;
            },
            navigationDelegate: (NavigationRequest request) {
              checkURL(request.url);
              return NavigationDecision.navigate;
            },
            onPageFinished: (String url) {
              // print('Page finished loading: $url');
            },
            gestureNavigationEnabled: false,
            initialUrl: "",
          ),
        ));
  }

  void executePayment(BuildContext context, String sessionId) {
    request.sessionId = sessionId;
    MFSDK.callExecutePaymentForInAppApplePay(
        context, request, apiLang, callback);
  }

  void checkURL(String url) {
    Uri uri = Uri.dataFromString(url);
    if (url.contains("finish")) {
      String? sessionId = uri.queryParameters["sessionId"];
      executePayment(context, sessionId!);
    }
  }

  void load(MFInitiateSessionResponse initiateSession,
      MFExecutePaymentRequest req, String lang, Function func) {
    if (req.displayCurrencyIso == null || req.displayCurrencyIso!.isEmpty) {
      func(
          "",
          MFResult.fail<MFPaymentStatusResponse>(new MFError(
              ErrorHelper.getValue(ErrorsEnum.APPLE_PAY_CURRENCY_ERROR).code,
              ErrorHelper.getValue(ErrorsEnum.APPLE_PAY_CURRENCY_ERROR)
                  .message)));
      return;
    }

    var url =
        "https://ap.myfatoorah.com/?sessionId=${initiateSession.sessionId!}&countryCode=${initiateSession.countryCode!}&currencyCode=${req.displayCurrencyIso}&amount=${req.invoiceValue}&platform=flutter&isLive=${ConfigManager.isLive()}";
    request = req;
    apiLang = lang;
    callback = func;
    _webViewController!.loadUrl(url);
  }
}
