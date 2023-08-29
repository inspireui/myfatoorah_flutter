import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:myfatoorah_flutter/model/MFError.dart';
import 'package:myfatoorah_flutter/utils/ErrorsEnum.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../myfatoorah_flutter.dart';

class HtmlPage extends State<MFPaymentCardView> {
  static int cardHeight = 230;
  static String html = "";
  static late MFExecutePaymentRequest request;
  static late String apiLang;
  static late Function submitCallBack;
  Function? onCardBinChanged;
  WebViewController _webViewController = WebViewController();

  HtmlPage(String htmlCode) {
    html = htmlCode;
  }

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _webViewController = _webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('Success',
          onMessageReceived: (JavaScriptMessage message) {
        executePayment(context, message.message);
      })
      ..addJavaScriptChannel('Fail',
          onMessageReceived: (JavaScriptMessage message) {
        returnPaymentFailed(message.message);
      })
      ..addJavaScriptChannel('BinChanges',
          onMessageReceived: (JavaScriptMessage message) {
        onCardBinChangedCallback(message.message);
      })
      ..setBackgroundColor(const Color(0x00000000))
      ..loadHtmlString(convertHTMLToURL(html));
  }

  void load(String htmlCode, int cardH, Function? onCardBinChanged) {
    html = htmlCode;
    cardHeight = cardH;
    this.onCardBinChanged = onCardBinChanged;
    _webViewController.loadRequest(convertHTMLToURI(html));
  }

  void submit(MFExecutePaymentRequest req, String lang, Function callback) {
    if (req.paymentMethodId != null) {
      callback(
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
    submitCallBack = callback;
    _webViewController.runJavaScript('submit()');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardHeight.toDouble(),
      child: GestureDetector(
        onHorizontalDragUpdate: (updateDetails) {},
        onVerticalDragUpdate: (updateDetails) {},
        child: WebViewWidget(
          controller: _webViewController,
        ),
      ),
    );
  }

  String convertHTMLToURL(String html) {
    return new Uri.dataFromString(html,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString();
  }

  Uri convertHTMLToURI(String html) {
    return new Uri.dataFromString(html,
        mimeType: 'text/html', encoding: Encoding.getByName('utf-8'));
  }

  void executePayment(BuildContext context, String sessionId) {
    request.sessionId = sessionId;

    MFSDK.callExecutePayment(context, request, apiLang,
        onResponse: submitCallBack, isEmbeddedPayment: true);
  }

  void returnPaymentFailed(String error) {
    submitCallBack(
        "",
        MFResult.fail<MFPaymentStatusResponse>(new MFError(
            ErrorHelper.getValue(ErrorsEnum.EMBEDDED_PAYMENT_ERROR).code,
            error)));
  }

  void onCardBinChangedCallback(String bin) {
    if (onCardBinChanged != null) onCardBinChanged!(bin);
  }
}
