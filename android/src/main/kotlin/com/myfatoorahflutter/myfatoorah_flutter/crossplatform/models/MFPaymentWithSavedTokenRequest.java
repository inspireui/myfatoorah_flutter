package com.myfatoorahflutter.myfatoorah_flutter.crossplatform.models;

import com.myfatoorah.sdk.entity.executepayment.MFExecutePaymentRequest;

public class MFPaymentWithSavedTokenRequest {
    public MFExecutePaymentRequest ExecutePaymentRequest;
    public String Token;
    public String SecurityCode;

    public MFExecutePaymentRequest getExecutePaymentRequest() {
        return ExecutePaymentRequest;
    }

    public void setExecutePaymentRequest(MFExecutePaymentRequest executePaymentRequest) {
        ExecutePaymentRequest = executePaymentRequest;
    }

    public String getToken() {
        return Token;
    }

    public void setToken(String token) {
        Token = token;
    }

    public String getSecurityCode() {
        return SecurityCode;
    }

    public void setSecurityCode(String securityCode) {
        SecurityCode = securityCode;
    }
}
