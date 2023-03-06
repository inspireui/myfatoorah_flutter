import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:myfatoorah_flutter/model/MFError.dart';
import 'package:myfatoorah_flutter/utils/ErrorsEnum.dart';
import 'package:webview_flutter/src/webview_flutter_legacy.dart';

import '../myfatoorah_flutter.dart';
import 'MFPaymentCardView.dart';

class HtmlPage extends State<MFPaymentCardView> {
  static int cardHeight = 230;
  static String html = "";
  static late MFExecutePaymentRequest request;
  static late String apiLang;
  static late Function callback;
  static WebViewController? _webViewController;

  HtmlPage(String htmlCode) {
    html = htmlCode;
  }

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  void load(String htmlCode, int cardH) {
    html = htmlCode;
    cardHeight = cardH;
    _webViewController!.loadUrl(convertHTMLToURL(html));
  }

  void submit(MFExecutePaymentRequest req, String lang, Function func) {
    if (req.paymentMethodId != null) {
      func(
          "",
          MFResult.fail<MFPaymentStatusResponse>(new MFError(
              ErrorHelper.getValue(
                      ErrorsEnum.EMBEDDED_PAYMENT_WITH_PAYMENT_METHOD_ID_ERROR)
                  .code,
              ErrorHelper.getValue(
                      ErrorsEnum.EMBEDDED_PAYMENT_WITH_PAYMENT_METHOD_ID_ERROR)
                  .message)));
      return;
    }
    request = req;
    apiLang = lang;
    callback = func;
    _webViewController!.evaluateJavascript('submit()');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardHeight.toDouble(),
      child: GestureDetector(
        onHorizontalDragUpdate: (updateDetails) {},
        onVerticalDragUpdate: (updateDetails) {},
        child: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _webViewController = webViewController;
            },
            javascriptChannels: Set.from([
              JavascriptChannel(
                  name: 'Success',
                  onMessageReceived: (JavascriptMessage message) {
                    executePayment(context, message.message);
                  }),
              JavascriptChannel(
                  name: 'Fail',
                  onMessageReceived: (JavascriptMessage message) {
                    returnPaymentFailed(message.message);
                  })
            ]),
            initialUrl: convertHTMLToURL(html)),
      ),
    );
  }

  void executePayment(BuildContext context, String sessionId) {
    request.sessionId = sessionId;

    MFSDK.callExecutePayment(context, request, apiLang, onResponse: callback);
  }

  void returnPaymentFailed(String error) {
    callback(
        "",
        MFResult.fail<MFPaymentStatusResponse>(new MFError(
            ErrorHelper.getValue(ErrorsEnum.EMBEDDED_PAYMENT_ERROR).code,
            error)));
  }

  String convertHTMLToURL(String html) {
    return new Uri.dataFromString(html,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString();
  }
}
