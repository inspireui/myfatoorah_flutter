import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myfatoorah_flutter/model/executepayment/MFExecutePaymentRequest.dart';
import 'package:myfatoorah_flutter/model/initsession/SDKInitSessionResponse.dart';

import '../myfatoorah_flutter.dart';
import 'MFApplePayButtonWebView.dart';

class MFApplePayButton extends StatefulWidget {
  MFApplePayButtonWebView? mfInAppApplePayWebView;

  MFApplePayButton({
    Key? key,
    double height = 50,
  }) : super(key: key) {
    this.mfInAppApplePayWebView = MFApplePayButtonWebView(height);
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
}
