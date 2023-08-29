import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../myfatoorah_flutter.dart';
import 'MFApplePayButtonWebView.dart';

class MFApplePayButton extends StatefulWidget {
  late final MFApplePayButtonWebView? mfInAppApplePayWebView;

  MFApplePayButton({
    Key? key,
    double height = 35,
    double radius = 8,
    String? buttonText,
    bool isLoadingIndicatorHidden = false,
  }) : super(key: key) {
    this.mfInAppApplePayWebView = MFApplePayButtonWebView(height,
        radius: radius,
        buttonText: buttonText,
        isLoadingIndicatorHidden: isLoadingIndicatorHidden);
  }

  @override
  State<StatefulWidget> createState() {
    return mfInAppApplePayWebView!;
  }

  void load(MFInitiateSessionResponse initSessionResponse,
      MFExecutePaymentRequest request, String apiLang, Function callback) {
    mfInAppApplePayWebView!
        .load(initSessionResponse, request, apiLang, callback);
  }

  void loadWithStartLoading(
      MFInitiateSessionResponse initSessionResponse,
      MFExecutePaymentRequest request,
      String apiLang,
      Function startLoading,
      Function callback) {
    mfInAppApplePayWebView!.loadWithStartLoading(
        initSessionResponse, request, apiLang, startLoading, callback);
  }
}
