package com.myfatoorahflutter.myfatoorah_flutter.crossplatform.models;

import com.myfatoorah.sdk.entity.executepayment.MFExecutePaymentRequest;
import com.myfatoorah.sdk.entity.executepayment_cardinfo.MFCardInfo;

public class MFDirectPaymentRequest {
    public MFExecutePaymentRequest ExecutePaymentRequest;
    public MFCardInfo.CardInfo Card = null;
    public String Token = null;
    public boolean SaveToken = false;
    public boolean Bypass3DS = false;
    public MFExecutePaymentRequest getExecutePaymentRequest() {
        return ExecutePaymentRequest;
    }

    public void setExecutePaymentRequest(MFExecutePaymentRequest executePaymentRequest) {
        ExecutePaymentRequest = executePaymentRequest;
    }

    public MFCardInfo.CardInfo getCard() {
        return Card;
    }

    public void setCard(MFCardInfo.CardInfo card) {
        Card = card;
    }

    public String getToken() {
        return Token;
    }

    public void setToken(String token) {
        Token = token;
    }

    public boolean isSaveToken() {
        return SaveToken;
    }

    public void setSaveToken(boolean saveToken) {
        SaveToken = saveToken;
    }

    public boolean isBypass3DS() {
        return Bypass3DS;
    }

    public void setBypass3DS(boolean bypass3DS) {
        Bypass3DS = bypass3DS;
    }


}
