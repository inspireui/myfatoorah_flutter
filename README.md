# myfatoorah_flutter

In order to simplify the integration of your application with MyFatoorah payment platforms, we have developed 
a cutting-edge plugin that works smoothly with your application and provide you with a simple way to embed our payment 
functions within your application. 

The plugin will save your efforts and time instead of integrating with our API using normal API calls, and will allow
you to have the setup ready in a quick, modern and secured way.


## Prerequisites

In order to have the plugin integration working on live environment, please refer to the section 
[Prerequisites](https://myfatoorah.readme.io/v2.0/docs/prerequisites-2) 
and read it for more details

# Integration 


## Installation

##### 1. Add MyFatoorah plugin to your pubspec.yaml file.

    dependencies:
        myfatoorah_flutter: ^2.1.12    
	  
##### 2. Install the plugin by running the following command.

    $ flutter pub get

## Usage
Inside your Dart code do the following:

##### 1. To start using MyFatoorah plugin, import it into your Flutter app. 
 
    import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

#####  2. Initiate MyFatoorah Plugin inside initState().

    MFSDK.init(<Put API URL here>, MFCountry.KUWAIT, MFEnvironment.TEST);
    
* You can get the `API URL` for testing from [here](https://myfatoorah.readme.io/docs/test-token)	
* Once your testing is finished, simply replace the `API URL` and `environment` with the live information, click
[here](https://myfatoorah.readme.io/docs/live-token) for more information.   
     
#####  3. (Optional).

* Use the following lines if you want to set up the properties of AppBar.

        MFSDK.setUpAppBar(
            title: "MyFatoorah Payment",
            titleColor: Colors.white,  // Color(0xFFFFFFFF)
            backgroundColor: Colors.black, // Color(0xFF000000)
            isShowAppBar: true); // For Android platform only

* And use this line, if you want to hide the AppBar. Note, if the platform is iOS, this line will not affected

        MFSDK.setUpAppBar(isShowAppBar: false);
	

### Initiate / Execute Payment


* Initiate Payment: this step will simply return you all available Payment Methods for the account with the actual
 charge that the customer will pay on the gateway.
  
        var request = new MFInitiatePaymentRequest(0.100, MFCurrencyISO.KUWAIT_KWD);
    
        MFSDK.initiatePayment(request, MFAPILanguage.EN,
                (MFResult<MFInitiatePaymentResponse> result) => {
    
              if(result.isSuccess()) {
                print(result.response.toJson().toString())
              }
              else {
                print(result.error.message)
              }
            });

  
* Execute Payment: once the payment has been initiated, this step will do execute the actual transaction creation at 
MyFatoorah platform and will return to your application the URL to redirect your customer to make the payment.
  
        // The value 1 is the paymentMethodId of KNET payment method.
        // You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
        String paymentMethod = 1;
    
        var request = new MFExecutePaymentRequest(paymentMethod, 0.100);
    
        MFSDK.executePayment(context, request, MFAPILanguage.EN,
                (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
    
              if(result.isSuccess()) {
                print(result.response.toJson().toString())
              }
              else {
                print(result.error.message)
              }
            });
  
* As a good practice, you don't have to call the Initiate Payment function every time you need to execute payment, but
 you have to call it at least once to save the PaymentMethodId that you will need to call Execute Payment
  
### Direct Payment / Tokenization

You have to know the following steps to understand how it works:
  
* Get the payment method that allows Direct Payment by calling initiatePayment to get paymentMethodId
* Collect card info from user MFCardInfo(cardNumber: "51234500000000081", cardExpiryMonth: "05", cardExpiryYear: "21", cardSecurityCode: "100", saveToken: false)
* If you want to save your credit card info and get a token for next payment you have to set saveToken: true and you will get the token in the response read more in Tokenization
* If you want to execute a payment through a saved token you have use 

      MFCardInfo(cardToken: "put your token here")
      
* Now you are ready to execute the payment, please check the following sample code.
      
  
    // The value 2 is the paymentMethodId of Visa/Master payment method.
    // You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
    String paymentMethod = 2;

    var request = new MFExecutePaymentRequest(paymentMethod, 0.100);
	
	// var mfCardInfo = new MFCardInfo(cardToken: "Put your token here");

    var mfCardInfo = new MFCardInfo("2223000000000007", "05", "21", "100",
        bypass3DS: false, saveToken: true);

    MFSDK.executeDirectPayment(context, request, mfCardInfo, MFAPILanguage.EN,
            (String invoiceId, MFResult<MFDirectPaymentResponse> result) => {

          if(result.isSuccess()) {
            print(result.response.toJson().toString())
          }
          else {
            print(result.error.message)
          }
        });
		
		
		
### Send Payment (Offline)
This will allow you to generate a payment link that can be sent by any channel we support and collect it once it's 
paid by your customer

    var request = MFSendPaymentRequest(invoiceValue: 0.100, customerName: "Customer name",
		notificationOption: MFNotificationOption.LINK);

    MFSDK.sendPayment(context, MFAPILanguage.EN, request, 
            (MFResult<MFSendPaymentResponse> result) => {
      
      if(result.isSuccess()) {
        print(result.response.toJson().toString())
      }
      else {
        print(result.error.message)
      }
    });
	
	
	
### Payment Enquiry
This will enable your application to get the full details about a certain invoice / payment
    
    var request = MFPaymentStatusRequest(invoiceId: "12345");

    MFSDK.getPaymentStatus(MFAPILanguage.EN, request,
            (MFResult<MFPaymentStatusResponse> result) => {

          if(result.isSuccess()) {
            print(result.response.toJson().toString())
          }
          else {
            print(result.error.message)
          }
        });

  
### Embedded Payment (new)
#### Introduction
If you would like your customer to complete the payment on your checkout page without being redirected to another page (except for the `3D Secure` page) and the `PCI DSS` compliance is a blocker, MyFatoorah embedded payment feature is your optimum solution.

#### Usage

##### Step 1:

Create instance of `MFPaymentCardView` and add it to your `build()` function like the following: 

      @override
      Widget build(BuildContext context) {
        return createPaymentCardView();
      }
    
      createPaymentCardView() {
        mfPaymentCardView = MFPaymentCardView();
        return mfPaymentCardView;
      }
      
###### Note: you could custom a lot of properties of the payment card view like the following:

    mfPaymentCardView = MFPaymentCardView(
          inputColor: Colors.red,
          labelColor: Colors.yellow,
          errorColor: Colors.blue,
          borderColor: Colors.green,
          fontSize: 14,
          borderWidth: 1,
          borderRadius: 10,
          cardHeight: 220,
          cardHolderNameHint: "card holder name hint",
          cardNumberHint: "card number hint",
          expiryDateHint: "expiry date hint",
          cvvHint: "cvv hint",
          showLabels: true,
          cardHolderNameLabel: "card holder name label",
          cardNumberLabel: "card number label",
          expiryDateLabel: "expiry date label",
          cvvLabel: "securtity code label",
        );
      
##### Step 2:

You need to call `initiateSession()` function to create session. You need to do this for each payment separately. `Session` is valid for only one payment. and inside it's success state, call `load()` function and pass it the session response, to load the payment card view on the screen, like the following:
    
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
        MFSDK.initiateSession(null, (MFResult<MFInitiateSessionResponse> result) => {
          if(result.isSuccess()) 
            mfPaymentCardView.load(result.response!)
          else
            print("Response: " + result.error!.toJson().toString().toString());
        });
      }
###### Note: The `initiateSession()` function should called after `MFSDK.init()` function (that we mentioned above).
##### Step 3:

After that, you need to handle your `Pay` button to call the `pay()` function, copy the below code to your pay event handler section:

    var request = MFExecutePaymentRequest.constructor(0.100);
    
    mfPaymentCardView.pay(
        request,
        MFAPILanguage.EN,
            (String invoiceId, MFResult<MFPaymentStatusResponse> result) =>
        {
          if (result.isSuccess())
            {
              setState(() {
                print("Response: " + result.response!.toJson().toString());
                _response = result.response!.toJson().toString();
              })
            }
          else
            {
              setState(() {
                print("Error: " + result.error!.toJson().toString());
                _response = result.error!.message!;
              })
            }
        });

### Apple Pay Embedded Payment (new for iOS only)
#### Introduction
To provide a better user experience to your Apple Pay users, MyFatoorah is providing the Apple Pay embedded payment. Follow these steps:

#### Usage

##### Step 1:

Create instance of `MFApplePayButton` and add it to your `build()` function like the following:

      @override
      Widget build(BuildContext context) {
        return createApplePayButton();
      }

      createApplePayButton() {
        mfApplePayButton = MFApplePayButton();
        return mfApplePayButton;
      }

##### Step 2:

You need to call `initiateSession()` function to create session. You need to do this for each payment separately. `Session` is valid for only one payment. and inside it's success state, call `load()` function and pass it the session response, like the following:

    void initiateSession() {
        MFSDK.initiateSession((MFResult<MFInitiateSessionResponse> result) => {
          if(result.isSuccess()) 
            loadApplePay(result.response)
          else
            print("Response: " + result.error!.toJson().toString().toString());
        });
      }

    void loadApplePay(MFInitiateSessionResponse mfInitiateSessionResponse) {
        var request = MFExecutePaymentRequest.constructorForApplyPay(
        0.100, MFCurrencyISO.KUWAIT_KWD);

        mfApplePayButton.load(
        mfInitiateSessionResponse,
        request,
        MFAPILanguage.EN,
            (String invoiceId, MFResult<MFPaymentStatusResponse> result) =>
        {
            if (result.isSuccess())
            {
                setState(() {
                    print("invoiceId: " + invoiceId);
                    print("Response: " + result.response.toJson().toString());
                    _response = result.response.toJson().toString();
                })
            }
            else
            {
                setState(() {
                    print("invoiceId: " + invoiceId);
                    print("Error: " + result.error.toJson().toString());
                        _response = result.error.message;
                    })
                }
            });
    }

###### Note: The `initiateSession()` function should called after `MFSDK.init()` function (that we mentioned above).

