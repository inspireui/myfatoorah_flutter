import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfatoorah_flutter/ConfigManager.dart';
import 'package:myfatoorah_flutter/model/MFError.dart';
import 'package:myfatoorah_flutter/utils/ErrorsEnum.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../myfatoorah_flutter.dart';
import 'MFApplePayButton.dart';

class MFApplePayButtonWebView extends State<MFApplePayButton> {
  static late MFExecutePaymentRequest request;
  static late String apiLang;
  static late Function callback;
  Function? _startLoading;

  double mHeight = 0;
  double radius = 8;
  String? buttonText;
  bool isLoadingIndicatorHidden = false;
  static InAppWebViewController? _webViewController;
  bool isHTMLHVisible = true;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
  );
  MFApplePayButtonWebView(double height,
      {this.radius = 8,
      this.buttonText,
      this.isLoadingIndicatorHidden = false}) {
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
            child: Stack(
              children: [
                Visibility(
                  visible: isHTMLHVisible,
                  child: InAppWebView(
                    initialData: InAppWebViewInitialData(data: setHTML()),
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        transparentBackground: true,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: true,
                  child: InAppWebView(
                    initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                            transparentBackground: true,
                            useShouldOverrideUrlLoading: true),
                        ios: IOSInAppWebViewOptions(applePayAPIEnabled: true)),
                    onWebViewCreated:
                        (InAppWebViewController webViewController) {
                      _webViewController = webViewController;
                    },
                    shouldOverrideUrlLoading:
                        (controller, navigationAction) async {
                      checkURL(navigationAction.request.url.toString());
                      return NavigationActionPolicy.ALLOW;
                    },
                    onLoadStop: (controller, url) {
                      setState(() {
                        isHTMLHVisible = false;
                      });
                      // print('Page finished loading: $url');
                    },
                  ),
                ),
              ],
            )));
  }

  String setHTML() {
    return ('''
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <style>
        .apple-pay-btn {
            background-color: #161515;
            justify-content: center;
            height: ${mHeight}px;
            border-radius: ${this.radius}px;
            opacity: 0.5;
        }

        .btn {
            border: none;
            display: flex;
            align-items: center;
            color: white;
            cursor: pointer;
            font-family: 'Roboto', sans-serif;
        }

        .apple-logo {
            width: 1rem;
        }

        h4 {
            margin: 0;
            padding: 0;
            font-weight: 500;
            vertical-align: baseline;
        }

        body {
            margin: 0;
        }
        .lds-ripple {
          display: inline-block;
          position: absolute;
          width: 30px;
          height: 30px;
        }
        .lds-ripple div {
          position: absolute;
          border: 4px solid #fff;
          opacity: 1;
          border-radius: 50%;
          animation: lds-ripple 1s cubic-bezier(0, 0.2, 0.8, 1) infinite;
        }
        .lds-ripple div:nth-child(2) {
          animation-delay: -0.5s;
        }
        @keyframes lds-ripple {
          0% {
            top: 12px;
            left: 12px;
            width: 0;
            height: 0;
            opacity: 0;
          }
          4.9% {
            top: 12px;
            left: 12px;
            width: 0;
            height: 0;
            opacity: 0;
          }
          5% {
            top: 12px;
            left: 12px;
            width: 0;
            height: 0;
            opacity: 1;
          }
          100% {
            top: 0px;
            left: 0px;
            width: 25px;
            height: 25px;
            opacity: 0;
          }
    </Style>
</head>
<a id="btnSubmitApplePay" class="applePay pay-now btnApplePay btn apple-pay-btn">
    
    <h4 id="btnText"> ${this.buttonText == null ? "Pay with" : this.buttonText!}</h4>
    <text>&nbsp;</text>
    <img src="data:image/png;base64,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" class="apple-logo">
    <h4> Pay </h4>
    ${this.isLoadingIndicatorHidden ? "" : "<div class=\"lds-ripple\"><div></div><div></div></div>"}
</a>

    ''');
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
      if (_startLoading != null) {
        _startLoading!();
      }
      executePayment(context, sessionId!);
    }
  }

  void buildLoad(MFInitiateSessionResponse initiateSession,
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

    var text = this.buttonText == null ? "" : this.buttonText!;
    var queryParam = text.isEmpty ? "" : "buttonText=$text";
    var url =
        "https://ap.myfatoorah.com/?sessionId=${initiateSession.sessionId!}&countryCode=${initiateSession.countryCode!}&currencyCode=${req.displayCurrencyIso}&amount=${req.invoiceValue}&platform=flutter&isLive=${ConfigManager.isLive()}&radius=${this.radius}&height=$mHeight&$queryParam";
    request = req;
    apiLang = lang;
    callback = func;
    _webViewController!
        .loadUrl(urlRequest: URLRequest(url: Uri.parse(Uri.encodeFull(url))));
  }

  void load(MFInitiateSessionResponse initiateSession,
      MFExecutePaymentRequest req, String lang, Function func) {
    buildLoad(initiateSession, req, lang, func);
  }

  void loadWithStartLoading(
      MFInitiateSessionResponse initiateSession,
      MFExecutePaymentRequest req,
      String lang,
      Function startLoading,
      Function func) {
    _startLoading = startLoading;
    buildLoad(initiateSession, req, lang, func);
  }
}
