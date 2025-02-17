package com.myfatoorahflutter.myfatoorah_flutter.crossplatform.utils;

public class MFConstants {
    public static final String MFModuleNAME = "MFModule";
    public static final String MFCardViewModuleNAME = "MFCardView";
    public static final String MFGooglePayButtonModuleNAME = "MFGooglePayButton";
    public static final int GooglePayRequestCODE = 991;
    public static final String MFEventChannelName = "onEventChannel";

    // TODO remove after updating native SDK
    public static final String CALL_BACK_URL = "https://myfatoorah.com/";
    public static final String ERROR_URL = "https://myfatooraherror.com/";


    public static class ChannelName {
        public static final String loadConfig = "MF.MFSDKHelper.loadConfig";
        public static final String setUpActionBar = "MF.MFSDKHelper.setUpActionBar";
        public static final String initiatePayment = "MF.MFSDKHelper.initiatePayment";
        public static final String sendPayment = "MF.MFSDKHelper.sendPayment";
        public static final String getPaymentStatus = "MF.MFSDKHelper.getPaymentStatus";
        public static final String executePayment = "MF.MFSDKHelper.executePayment";
        public static final String executePaymentWithSavedToken = "MF.MFSDKHelper.executePaymentWithSavedToken";
        public static final String executeDirectPayment = "MF.MFSDKHelper.executeDirectPayment";
        public static final String cancelToken = "MF.MFSDKHelper.cancelToken";
        public static final String cancelRecurringPayment = "MF.MFSDKHelper.cancelRecurringPayment";
        public static final String initSession = "MF.MFSDKHelper.initSession";
        public static final String load = "MF.MFSDKHelper.load";
        public static final String initiateSession = "MF.MFSDKHelper.initiateSession";
        public static final String pay = "MF.MFSDKHelper.pay";
        public static final String validate = "MF.MFSDKHelper.validate";
        public static final String googlePayPayment = "MF.MFSDKHelper.googlePayPayment";
    }

    public static class BufferType {
        public static final int MFPaymentWithSavedTokenRequest = 130;
        public static final int MFDirectPaymentRequest = 131;
        public static final int MFDirectPaymentResponse = 132;
        public static final int MFExecutePaymentRequest = 133;
        public static final int MFGetPaymentStatusRequest = 134;
        public static final int MFGetPaymentStatusResponse = 135;
        public static final int MFInitiatePaymentRequest = 136;
        public static final int MFInitiatePaymentResponse = 137;
        public static final int MFInitiateSessionRequest = 138;
        public static final int MFInitiateSessionResponse = 139;
        public static final int MFSendPaymentRequest = 144;
        public static final int MFSendPaymentResponse = 145;
        public static final int MFGooglePayRequest = 147;
        public static final int MFError = 999;
    }
}
