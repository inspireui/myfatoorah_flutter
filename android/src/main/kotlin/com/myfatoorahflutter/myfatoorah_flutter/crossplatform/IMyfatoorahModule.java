package com.myfatoorahflutter.myfatoorah_flutter.crossplatform;

import androidx.annotation.ColorRes;

import com.myfatoorah.sdk.entity.executepayment.MFExecutePaymentRequest;
import com.myfatoorah.sdk.entity.googlepay.GooglePayRequest;
import com.myfatoorah.sdk.entity.initiatepayment.MFInitiatePaymentRequest;
import com.myfatoorah.sdk.entity.initiatesession.MFInitiateSessionRequest;
import com.myfatoorah.sdk.entity.initiatesession.MFInitiateSessionResponse;
import com.myfatoorah.sdk.entity.paymentstatus.MFGetPaymentStatusRequest;
import com.myfatoorah.sdk.entity.sendpayment.MFSendPaymentRequest;
import com.myfatoorahflutter.myfatoorah_flutter.crossplatform.models.MFDirectPaymentRequest;
import com.myfatoorahflutter.myfatoorah_flutter.crossplatform.models.MFPaymentWithSavedTokenRequest;

public interface IMyfatoorahModule {
    void loadConfig(String apiKey, String country, String environment, IMFCallBack promise);

    void setUpActionBar(String toolBarTitle, @ColorRes int toolBarTitleColor, @ColorRes int toolBarBackgroundColor, Boolean isShowToolBar, IMFCallBack promise);

    void InitiatePayment(MFInitiatePaymentRequest initiatePaymentRequest, String lang, IMFCallBack promise);

    void SendPayment(MFSendPaymentRequest sendPaymentRequest, String lang, IMFCallBack promise);

    void GetPaymentStatus(MFGetPaymentStatusRequest getPaymentStatusRequest, String lang, IMFCallBack promise);

    void ExecutePayment(MFExecutePaymentRequest executePaymentRequest, String lang, IMFCallBack promise);

    void ExecutePaymentWithSavedToken(MFPaymentWithSavedTokenRequest savedTokenRequest, String lang, IMFCallBack promise);

    void ExecuteDirectPayment(MFDirectPaymentRequest directPaymentRequest, String lang, IMFCallBack promise);//MFDirectPaymentResponse

    void cancelToken(String token, String lang, IMFCallBack promise);

    void cancelRecurringPayment(String recurringId, String lang, IMFCallBack promise);

    void InitSession(MFInitiateSessionRequest initiateSessionRequest, String lang, IMFCallBack promise);

    void Load(MFInitiateSessionResponse initiateSessionResponse, boolean showNFCReadCardIcon);

    void InitiateSession(MFInitiateSessionRequest initiateSessionRequest, boolean showNFCReadCardIcon, IMFCallBack promise);

    void Validate(String currency, IMFCallBack promise);

    void Pay(MFExecutePaymentRequest executePaymentRequest, String lang, String currency, IMFCallBack promise);

    void SetupGooglePayHelper(String sessionId, GooglePayRequest googlePayRequest, IMFCallBack promise);

    void addListener(String eventName);

    void removeListeners(Integer count);
}