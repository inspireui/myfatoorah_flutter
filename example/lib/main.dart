import 'package:flutter/material.dart';
import 'package:myfatoorah_flutter/embeddedapplepay/MFApplePayButton.dart';
import 'package:myfatoorah_flutter/model/initsession/MFInitiateSessionRequest.dart';
import 'package:myfatoorah_flutter/model/initsession/SDKInitSessionResponse.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:myfatoorah_flutter/utils/MFCountry.dart';
import 'package:myfatoorah_flutter/utils/MFEnvironment.dart';
import 'dart:io' show Platform;

/*
TODO: The following API token key for testing only, so that when you go live
      don't forget to replace the following key with the live key provided
      by MyFatoorah.
*/

// You can get the API Token Key from here:
// https://myfatoorah.readme.io/docs/test-token
final String mAPIKey = "";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyFatoorah Plugin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'MyFatoorah Plugin Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _response = '';
  String _loading = "Loading...";
  var sessionIdValue = "";
  late MFPaymentCardView mfPaymentCardView;
  late MFApplePayButton mfApplePayButton;

  @override
  void initState() {
    super.initState();

    if (mAPIKey.isEmpty) {
      setState(() {
        _response =
            "Missing API Token Key.. You can get it from here: https://myfatoorah.readme.io/docs/test-token";
      });
      return;
    }

    // TODO, don't forget to init the MyFatoorah Plugin with the following line
    MFSDK.init(mAPIKey, MFCountry.KUWAIT, MFEnvironment.TEST);
    initiateSession();
    // (Optional) un comment the following lines if you want to set up properties of AppBar.

//    MFSDK.setUpAppBar(
//      title: "MyFatoorah Payment",
//      titleColor: Colors.white,  // Color(0xFFFFFFFF)
//      backgroundColor: Colors.lightBlue, // Color(0xFF000000)
//      isShowAppBar: true); // For Android platform only

    // (Optional) un comment this line, if you want to hide the AppBar.
    // Note, if the platform is iOS, this line will not affected

    MFSDK.setUpAppBar(isShowAppBar: false);
  }

  void initiateSession() {
    /**
     * If you want to use saved card option with embedded payment, send the parameter
     * "customerIdentifier" with a unique value for each customer. This value cannot be used
     * for more than one Customer.
     */
    // var request = MFInitiateSessionRequest("12332212");

    /**
     * If not, then send null like this.
     */
    MFSDK.initiateSession(
        null,
        (MFResult<MFInitiateSessionResponse> result) => {
              if (result.isSuccess())
                {
                  // This for embedded payment view
                  mfPaymentCardView.load(result.response!)

                  /// This used for Apple Pay in iOS only.
                  // loadApplePay(result.response!)
                }
              else
                {
                  setState(() {
                    print("Response: " +
                        result.error!.toJson().toString().toString());
                    _response = result.error!.message!;
                  })
                }
            });
  }

  void payWithEmbeddedPayment() {
    var request = MFExecutePaymentRequest.constructor(0.100);
    mfPaymentCardView.pay(
        request,
        MFAPILanguage.EN,
        (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
              if (result.isSuccess())
                {
                  setState(() {
                    print("invoiceId: " + invoiceId);
                    print("Response: " + result.response!.toJson().toString());
                    _response = result.response!.toJson().toString();
                  })
                }
              else
                {
                  setState(() {
                    print("invoiceId: " + invoiceId);
                    print("Error: " + result.error!.toJson().toString());
                    _response = result.error!.message!;
                  })
                }
            });
  }

  /// This used for Apple Pay in iOS only.
  void loadApplePay(MFInitiateSessionResponse mfInitiateSessionResponse) {
    var request = MFExecutePaymentRequest.constructorForApplyPay(
        0.100, MFCurrencyISO.KUWAIT_KWD);
    mfApplePayButton.load(
        mfInitiateSessionResponse,
        request,
        MFAPILanguage.EN,
        (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
              if (result.isSuccess())
                {
                  setState(() {
                    print("invoiceId: " + invoiceId);
                    print("Response: " + result.response!.toJson().toString());
                    _response = result.response!.toJson().toString();
                  })
                }
              else
                {
                  setState(() {
                    print("invoiceId: " + invoiceId);
                    print("Error: " + result.error!.toJson().toString());
                    _response = result.error!.message!;
                  })
                }
            });
  }

  /*
    Send Payment
   */
  void sendPayment() {
    var request = MFSendPaymentRequest(
        invoiceValue: 0.100,
        customerName: "Customer name",
        notificationOption: MFNotificationOption.LINK);

    MFSDK.sendPayment(
        context,
        MFAPILanguage.EN,
        request,
        (MFResult<MFSendPaymentResponse> result) => {
              if (result.isSuccess())
                {
                  setState(() {
                    print("Response: " +
                        result.response!.toJson().toString().toString());
                    _response = result.response!.toJson().toString().toString();
                  })
                }
              else
                {
                  setState(() {
                    print("Response: " +
                        result.error!.toJson().toString().toString());
                    _response = result.error!.message!;
                  })
                }
            });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Initiate Payment
   */
  void initiatePayment() {
    var request = new MFInitiatePaymentRequest(5.5, MFCurrencyISO.KUWAIT_KWD);

    MFSDK.initiatePayment(
        request,
        MFAPILanguage.EN,
        (MFResult<MFInitiatePaymentResponse> result) => {
              if (result.isSuccess())
                {
                  setState(() {
                    print("Response: " + result.response!.toJson().toString());
                    _response = result.response!.toJson().toString().toString();
                  })
                }
              else
                {
                  setState(() {
                    print("Response: " + result.error!.toJson().toString());
                    _response = result.error!.message!;
                  })
                }
            });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Execute Regular Payment
   */
  void executeRegularPayment() {
    // The value 1 is the paymentMethodId of KNET payment method.
    // You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
    int paymentMethod = 1;

    var request = new MFExecutePaymentRequest(paymentMethod, 0.100);

    MFSDK.executePayment(context, request, MFAPILanguage.EN,
        onInvoiceCreated: (String invoiceId) =>
            {print("invoiceId: " + invoiceId)},
        onPaymentResponse: (String invoiceId,
                MFResult<MFPaymentStatusResponse> result) =>
            {
              if (result.isSuccess())
                {
                  setState(() {
                    print("invoiceId: " + invoiceId);
                    print("Response: " + result.response!.toJson().toString());
                    _response = result.response!.toJson().toString().toString();
                  })
                }
              else
                {
                  setState(() {
                    print("invoiceId: " + invoiceId);
                    print("Response: " + result.error!.toJson().toString());
                    _response = result.error!.message!;
                  })
                }
            });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Execute Direct Payment
   */
  void executeDirectPayment() {
    // The value 9 is the paymentMethodId of Visa/Master payment method.
    // You should call the "initiatePayment" API to can get this id and the
    // ids of all other payment methods
    int paymentMethod = 9;

    var request = new MFExecutePaymentRequest(paymentMethod, 0.100);

//    var mfCardInfo = new MFCardInfo(cardToken: "Put your API token key here");

    var mfCardInfo = new MFCardInfo(
        cardNumber: "5453010000095489",
        expiryMonth: "05",
        expiryYear: "21",
        securityCode: "100",
        cardHolderName: "Set Name",
        bypass3DS: false,
        saveToken: false);

    MFSDK.executeDirectPayment(
        context,
        request,
        mfCardInfo,
        MFAPILanguage.EN,
        (String invoiceId, MFResult<MFDirectPaymentResponse> result) => {
              if (result.isSuccess())
                {
                  setState(() {
                    print("invoiceId: " + invoiceId);
                    print("Response: " + result.response!.toJson().toString());
                    _response = result.response!.toJson().toString().toString();
                  })
                }
              else
                {
                  setState(() {
                    print("invoiceId: " + invoiceId);
                    print("Response: " + result.error!.toJson().toString());
                    _response = result.error!.message!;
                  })
                }
            });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Execute Direct Payment with Recurring
   */
  void executeDirectPaymentWithRecurring() {
    // The value 20 is the paymentMethodId of Visa/Master payment method.
    // You should call the "initiatePayment" API to can get this id and the ids
    // of all other payment methods
    int paymentMethod = 20;

    var request = new MFExecutePaymentRequest(paymentMethod, 100.0);

    var mfCardInfo = new MFCardInfo(
        cardNumber: "5453010000095539",
        expiryMonth: "05",
        expiryYear: "21",
        securityCode: "100",
        cardHolderName: "Set Name",
        bypass3DS: true,
        saveToken: true);

    mfCardInfo.iteration = 12;

    MFSDK.executeRecurringDirectPayment(
        context,
        request,
        mfCardInfo,
        MFRecurringType.monthly,
        MFAPILanguage.EN,
        (String invoiceId, MFResult<MFDirectPaymentResponse> result) => {
              if (result.isSuccess())
                {
                  setState(() {
                    print("Response: " + invoiceId);
                    print("Response: " + result.response!.toJson().toString());
                    _response = result.response!.toJson().toString().toString();
                  })
                }
              else
                {
                  setState(() {
                    print("Response: " + invoiceId);
                    print("Response: " + result.error!.toJson().toString());
                    _response = result.error!.message!;
                  })
                }
            });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Payment Enquiry
   */
  void getPaymentStatus() {
    var request = MFPaymentStatusRequest(invoiceId: "1209756"); // 1209773

    MFSDK.getPaymentStatus(
        MFAPILanguage.EN,
        request,
        (MFResult<MFPaymentStatusResponse> result) => {
              if (result.isSuccess())
                {
                  setState(() {
                    print("Response: " + result.response!.toJson().toString());
                    _response = result.response!.toJson().toString().toString();
                  })
                }
              else
                {
                  setState(() {
                    print("Response: " + result.error!.toJson().toString());
                    _response = result.error!.message!;
                  })
                }
            });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Cancel Token
   */
  void cancelToken() {
    MFSDK.cancelToken(
        "Put your token here",
        MFAPILanguage.EN,
        (MFResult<bool> result) => {
              if (result.isSuccess())
                {
                  setState(() {
                    print("Response: " + result.response.toString());
                    _response = result.response.toString();
                  })
                }
              else
                {
                  setState(() {
                    print("Response: " + result.error!.toJson().toString());
                    _response = result.error!.message!;
                  })
                }
            });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Cancel Recurring Payment
   */
  void cancelRecurringPayment() {
    MFSDK.cancelRecurringPayment(
        "Put RecurringId here",
        MFAPILanguage.EN,
        (MFResult<bool> result) => {
              if (result.isSuccess())
                {
                  setState(() {
                    print("Response: " + result.response.toString());
                    _response = result.response.toString();
                  })
                }
              else
                {
                  setState(() {
                    print("Response: " + result.error!.toJson().toString());
                    _response = result.error!.message!;
                  })
                }
            });

    setState(() {
      _response = _loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  createPaymentCardView(),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  if (Platform.isIOS) createApplePayView(),
                  // RaisedButton(
                  //   child: Text('Pay (Embedded Payment)'),
                  //   onPressed: payWithEmbeddedPayment,
                  // ),
                  // RaisedButton(
                  //   child: Text('Send Payment'),
                  //   onPressed: sendPayment,
                  // ),
                  // RaisedButton(
                  //   child: Text('Initiate Payment'),
                  //   onPressed: initiatePayment,
                  // ),
                  // RaisedButton(
                  //   child: Text('Execute Regular Payment'),
                  //   onPressed: executeRegularPayment,
                  // ),
                  // RaisedButton(
                  //   child: Text('Execute Direct Payment'),
                  //   onPressed: executeDirectPayment,
                  // ),
                  // RaisedButton(
                  //   child: Text('Execute Direct Payment with Recurring'),
                  //   onPressed: executeDirectPaymentWithRecurring,
                  // ),
                  // RaisedButton(
                  //   child: Text('Cancel Recurring Payment'),
                  //   onPressed: cancelRecurringPayment,
                  // ),
                  // RaisedButton(
                  //   child: Text('Cancel Token'),
                  //   onPressed: cancelToken,
                  // ),
                  // RaisedButton(
                  //   child: Text('Get Payment Status'),
                  //   onPressed: getPaymentStatus,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(_response),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  createPaymentCardView() {
    mfPaymentCardView = MFPaymentCardView(
//      inputColor: Colors.red,
//      labelColor: Colors.yellow,
//      errorColor: Colors.blue,
//      borderColor: Colors.green,
//      fontSize: 14,
//      borderWidth: 1,
//      borderRadius: 10,
//      cardHeight: 220,
//      cardHolderNameHint: "card holder name hint",
//      cardNumberHint: "card number hint",
//      expiryDateHint: "expiry date hint",
//      cvvHint: "cvv hint",
//      showLabels: true,
//      cardHolderNameLabel: "card holder name label",
//      cardNumberLabel: "card number label",
//      expiryDateLabel: "expiry date label",
//      cvvLabel: "cvv label",
        );

    return mfPaymentCardView;
  }

  /// This for Apple pay button
  createApplePayView() {
    mfApplePayButton = MFApplePayButton();
    return mfApplePayButton;
  }
}
