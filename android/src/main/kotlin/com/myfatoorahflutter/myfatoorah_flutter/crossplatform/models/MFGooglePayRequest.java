package com.myfatoorahflutter.myfatoorah_flutter.crossplatform.models;

public class MFGooglePayRequest {
    public String TotalPrice = null;
    public String MerchantId = null;
    public String MerchantName = null;
    public String CountryCode = null;
    public String CurrencyIso = null;

    public String getTotalPrice() {
        return TotalPrice;
    }

    public void setTotalPrice(String totalPrice) {
        TotalPrice = totalPrice;
    }

    public String getMerchantId() {
        return MerchantId;
    }

    public void setMerchantId(String merchantId) {
        MerchantId = merchantId;
    }

    public String getMerchantName() {
        return MerchantName;
    }

    public void setMerchantName(String merchantName) {
        MerchantName = merchantName;
    }

    public String getCountryCode() {
        return CountryCode;
    }

    public void setCountryCode(String countryCode) {
        CountryCode = countryCode;
    }

    public String getCurrencyIso() {
        return CurrencyIso;
    }

    public void setCurrencyIso(String currencyIso) {
        CurrencyIso = currencyIso;
    }
}