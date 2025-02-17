package com.myfatoorahflutter.myfatoorah_flutter.crossplatform;

import android.app.Activity;
import android.util.Log;
import android.view.View;

import androidx.annotation.NonNull;

import com.google.gson.Gson;
import com.myfatoorah.sdk.entity.MFError;
import com.myfatoorah.sdk.entity.executepayment.MFExecutePaymentRequest;
import com.myfatoorah.sdk.entity.executepayment_cardinfo.MFCardInfo;
import com.myfatoorah.sdk.entity.executepayment_cardinfo.MFDirectPaymentResponse;
import com.myfatoorah.sdk.entity.googlepay.GooglePayRequest;
import com.myfatoorah.sdk.entity.initiatepayment.MFInitiatePaymentRequest;
import com.myfatoorah.sdk.entity.initiatepayment.MFInitiatePaymentResponse;
import com.myfatoorah.sdk.entity.initiatesession.MFInitiateSessionRequest;
import com.myfatoorah.sdk.entity.initiatesession.MFInitiateSessionResponse;
import com.myfatoorah.sdk.entity.paymentstatus.MFGetPaymentStatusRequest;
import com.myfatoorah.sdk.entity.paymentstatus.MFGetPaymentStatusResponse;
import com.myfatoorah.sdk.entity.sendpayment.MFSendPaymentRequest;
import com.myfatoorah.sdk.entity.sendpayment.MFSendPaymentResponse;
import com.myfatoorah.sdk.entity.updatesession.MFUpdateSessionRequest;
import com.myfatoorah.sdk.entity.updatesession.MFUpdateSessionResponse;
import com.myfatoorah.sdk.enums.MFCountry;
import com.myfatoorah.sdk.enums.MFEnvironment;
import com.myfatoorah.sdk.enums.PlatformType;
import com.myfatoorah.sdk.enums.TokenType;
import com.myfatoorah.sdk.views.MFResult;
import com.myfatoorah.sdk.views.MFSDK;
import com.myfatoorah.sdk.views.embeddedpayment.MFPaymentCardView;
import com.myfatoorah.sdk.views.embeddedpayment.googlepay.MFGooglePayButton;
import com.myfatoorah.sdk.views.embeddedpayment.googlepay.MFGooglePayHelper;
import com.myfatoorahflutter.myfatoorah_flutter.CardViewFactory;
import com.myfatoorahflutter.myfatoorah_flutter.GooglePayButtonFactory;
import com.myfatoorahflutter.myfatoorah_flutter.MfSDKHelper;
import com.myfatoorahflutter.myfatoorah_flutter.crossplatform.models.MFDirectPaymentRequest;
import com.myfatoorahflutter.myfatoorah_flutter.crossplatform.models.MFPaymentWithSavedTokenRequest;
import com.myfatoorahflutter.myfatoorah_flutter.crossplatform.utils.MFConstants;
import com.myfatoorahflutter.myfatoorah_flutter.crossplatform.utils.MFExtentionsKt;

import kotlin.Unit;

//TODO make class MFCrossPlatformModule common between flutter and ReactNative
public class MyfatoorahModule implements MfSDKHelper.MFSDKHelper {

    public Activity activity = null;
    public CardViewFactory cardViewFactory;
    public GooglePayButtonFactory googlePayButtonFactory;
    public MFGooglePayHelper mfGooglePayHelper = null;
    private final String TAG = "MyfatoorahModule";

    //#region MFSDK Methods

    @Override
    public void loadConfig(@NonNull String apiKey, @NonNull String country, @NonNull String environment, @NonNull IMFCallBack promise) {
        MFSDK.INSTANCE.init(apiKey, getEnumCountry(country), getEnumEnvironment(environment));
        MFSDK.INSTANCE.setPlatForm(PlatformType.Flutter);
        OnSuccess(promise, "Success");
    }

    @NonNull
    @Override
    public void setUpActionBar(@NonNull String toolBarTitle, @NonNull int toolBarTitleColor, @NonNull int toolBarBackgroundColor, @NonNull Boolean isShowToolBar, @NonNull IMFCallBack promise) {
        MFSDK.INSTANCE.setUpActionBar(toolBarTitle, toolBarTitleColor, toolBarBackgroundColor, isShowToolBar);
        OnSuccess(promise, "Success");
    }

    @NonNull
    @Override
    public void InitiatePayment(@NonNull MFInitiatePaymentRequest initiatePaymentRequest, @NonNull String lang, @NonNull IMFCallBack promise) {
        MFSDK.INSTANCE.initiatePayment(initiatePaymentRequest, lang, (MFResult<MFInitiatePaymentResponse> result) -> {
            if (result instanceof MFResult.Success) {
                MFInitiatePaymentResponse response = ((MFResult.Success<MFInitiatePaymentResponse>) result).getResponse();
                OnSuccess(promise, response);
            } else if (result instanceof MFResult.Fail) {
                MFError mfError = ((MFResult.Fail) result).getError();
                OnError(promise, mfError);
            }
            return Unit.INSTANCE;
        });
    }

    @NonNull
    @Override
    public void SendPayment(@NonNull MFSendPaymentRequest sendPaymentRequest, @NonNull String lang, @NonNull IMFCallBack promise) {
        MFSDK.INSTANCE.sendPayment(sendPaymentRequest, lang, (MFResult<MFSendPaymentResponse> result) -> {
            if (result instanceof MFResult.Success) {
                MFSendPaymentResponse response = ((MFResult.Success<MFSendPaymentResponse>) result).getResponse();
                OnSuccess(promise, response);
            } else if (result instanceof MFResult.Fail) {
                MFError mfError = ((MFResult.Fail) result).getError();
                OnError(promise, mfError);
            }
            return Unit.INSTANCE;
        });
    }

    @Override
    public void GetPaymentStatus(@NonNull MFGetPaymentStatusRequest getPaymentStatusRequest, @NonNull String lang, @NonNull IMFCallBack promise) {
        MFSDK.INSTANCE.getPaymentStatus(getPaymentStatusRequest, lang, (MFResult<MFGetPaymentStatusResponse> result) -> {
            if (result instanceof MFResult.Success) {
                MFGetPaymentStatusResponse response = ((MFResult.Success<MFGetPaymentStatusResponse>) result).getResponse();
                OnSuccess(promise, response);
            } else if (result instanceof MFResult.Fail) {
                MFError mfError = ((MFResult.Fail) result).getError();
                OnError(promise, mfError);
            }
            return Unit.INSTANCE;
        });
    }

    @NonNull
    @Override
    public void ExecutePayment(@NonNull MFExecutePaymentRequest executePaymentRequest, @NonNull String lang, @NonNull IMFCallBack promise) {
        MFSDK.INSTANCE.executePayment(
                this.activity,
                executePaymentRequest,
                lang,
                (String invoiceId) -> {
                    OnInvoiceCreated(invoiceId);
                    Log.d("Tag", invoiceId);
                    return Unit.INSTANCE;
                },
                (String invoiceId, MFResult<MFGetPaymentStatusResponse> result) -> {
                    if (result instanceof MFResult.Success) {
                        MFGetPaymentStatusResponse response = ((MFResult.Success<MFGetPaymentStatusResponse>) result).getResponse();
                        OnSuccess(promise, response);
                    } else if (result instanceof MFResult.Fail) {
                        MFError mfError = ((MFResult.Fail) result).getError();
                        OnError(promise, mfError);
                    }
                    return Unit.INSTANCE;
                });
    }

    @NonNull
    @Override
    public void ExecutePaymentWithSavedToken(@NonNull MFPaymentWithSavedTokenRequest savedTokenRequest, @NonNull String lang, @NonNull IMFCallBack promise) {
        MFUpdateSessionRequest updateSessionRequest =
                new MFUpdateSessionRequest(
                        savedTokenRequest.ExecutePaymentRequest.getSessionId(),
                        savedTokenRequest.Token,
                        TokenType.MFtoken,
                        savedTokenRequest.SecurityCode
                );

        MFSDK.INSTANCE.updateSession(updateSessionRequest, (MFResult<MFUpdateSessionResponse> result) -> {
            if (result instanceof MFResult.Success) {
                executePaymentWithSavedToken(savedTokenRequest.ExecutePaymentRequest, lang, promise);
            } else if (result instanceof MFResult.Fail) {
                MFError mfError = ((MFResult.Fail) result).getError();
                OnError(promise, mfError);
            }
            return Unit.INSTANCE;
        });
    }

    private void executePaymentWithSavedToken(MFExecutePaymentRequest executePaymentRequest, String lang, IMFCallBack promise) {
        MFSDK.INSTANCE.executePaymentWithSavedToken(
                this.activity,
                executePaymentRequest,
                lang,
                (String invoiceId) -> {
                    OnInvoiceCreated(invoiceId);
                    Log.d("Tag", invoiceId);
                    return Unit.INSTANCE;
                },
                (String invoiceId, MFResult<MFGetPaymentStatusResponse> result) -> {
                    if (result instanceof MFResult.Success) {
                        MFGetPaymentStatusResponse response = ((MFResult.Success<MFGetPaymentStatusResponse>) result).getResponse();
                        OnSuccess(promise, response);
                    } else if (result instanceof MFResult.Fail) {
                        MFError mfError = ((MFResult.Fail) result).getError();
                        OnError(promise, mfError);
                    }
                    return Unit.INSTANCE;
                });
    }

    @NonNull
    @Override
    public void ExecuteDirectPayment(@NonNull MFDirectPaymentRequest request, @NonNull String lang, @NonNull IMFCallBack promise) {
        MFExecutePaymentRequest mfExecutePaymentRequest = request.ExecutePaymentRequest;
        MFCardInfo mfCardInfo;
        if (request.Token != null && !request.Token.equals("")) {
            mfCardInfo = new MFCardInfo(request.Token);
        } else if (request.Card != null) {
            mfCardInfo = new MFCardInfo(
                    request.Card.getNumber(), request.Card.getExpiryMonth(), request.Card.getExpiryYear(),
                    request.Card.getSecurityCode(), request.Card.getCardHolderName(),
                    false, true);
            mfCardInfo.setBypass3DS(false);
        } else {
            MFError mfError = new MFError("000", "Please provide Token or Card");
            OnError(promise, mfError);
            return;
        }

        MFSDK.INSTANCE.executeDirectPayment(
                this.activity,
                mfExecutePaymentRequest,
                mfCardInfo,
                lang,
                (String invoiceId) -> {
                    OnInvoiceCreated(invoiceId);
                    Log.d("Tag", invoiceId);
                    return Unit.INSTANCE;
                },
                (String invoiceId, MFResult<MFDirectPaymentResponse> result) -> {
                    if (result instanceof MFResult.Success) {
                        MFDirectPaymentResponse response = ((MFResult.Success<MFDirectPaymentResponse>) result).getResponse();
                        OnSuccess(promise, response);
                    } else if (result instanceof MFResult.Fail) {
                        MFError mfError = ((MFResult.Fail) result).getError();
                        OnError(promise, mfError);
                    }
                    return Unit.INSTANCE;
                });
    }

    @NonNull
    @Override
    public void cancelToken(@NonNull String token, @NonNull String lang, @NonNull IMFCallBack promise) {
        MFSDK.INSTANCE.cancelToken(token, lang, (MFResult<Boolean> result) -> {
            if (result instanceof MFResult.Success) {
                Boolean response = ((MFResult.Success<Boolean>) result).getResponse();
                OnSuccess(promise, response);
            } else if (result instanceof MFResult.Fail) {
                MFError mfError = ((MFResult.Fail) result).getError();
                OnError(promise, mfError);
            }
            return Unit.INSTANCE;
        });
    }

    @NonNull
    @Override
    public void cancelRecurringPayment(@NonNull String recurringId, @NonNull String lang, @NonNull IMFCallBack promise) {
        MFSDK.INSTANCE.cancelRecurringPayment(recurringId, lang, (MFResult<Boolean> result) -> {
            if (result instanceof MFResult.Success) {
                Boolean response = ((MFResult.Success<Boolean>) result).getResponse();
                OnSuccess(promise, response);
            } else if (result instanceof MFResult.Fail) {
                MFError mfError = ((MFResult.Fail) result).getError();
                OnError(promise, mfError);
            }
            return Unit.INSTANCE;
        });
    }

    //#endregion


    //#region CardView Methods
    @NonNull
    @Override
    public void InitSession(@NonNull MFInitiateSessionRequest initiateSessionRequest, @NonNull String lang, @NonNull IMFCallBack promise) {
        MFSDK.INSTANCE.initiateSession(initiateSessionRequest, (MFResult<MFInitiateSessionResponse> result) -> {
            if (result instanceof MFResult.Success) {
                MFInitiateSessionResponse response = ((MFResult.Success<MFInitiateSessionResponse>) result).getResponse();
                OnSuccess(promise, response);
            } else if (result instanceof MFResult.Fail) {
                MFError mfError = ((MFResult.Fail) result).getError();
                OnError(promise, mfError);
            }
            return Unit.INSTANCE;
        });
    }

    @NonNull
    @Override
    public void Load(MFInitiateSessionResponse initiateSessionResponse, boolean showNFCReadCardIcon) {
        MFPaymentCardView cardView = cardViewFactory.paymentCardView;
        if (cardView == null) {
            MFError mfError = new MFError("009", "cardView must be initialized");
            Log.d(TAG, new Gson().toJson(mfError));
            return;
        }
        LoadCardView(initiateSessionResponse, showNFCReadCardIcon, cardView);
    }

    private void LoadCardView(MFInitiateSessionResponse initiateSessionResponse, boolean showNFCReadCardIcon, MFPaymentCardView cardView) {
        cardView.load(initiateSessionResponse
                , (String bin) ->
                {
                    OnCardBinChanged(bin);
                    Log.d(TAG, "bin: " + bin);
                    return Unit.INSTANCE;
                }, (Float height) ->
                {
                    // OnCardHeightChanged(height);
                    // Log.d(TAG, "height: " + height);
                    return Unit.INSTANCE;
                }, showNFCReadCardIcon);

        if (showNFCReadCardIcon) {
            cardView.enableCardNFC(activity);
            cardViewFactory.showNFCReadCardIcon = true;
        }
    }

    @NonNull
    @Override
    public void InitiateSession(@NonNull MFInitiateSessionRequest initiateSessionRequest, boolean showNFCReadCardIcon, @NonNull IMFCallBack promise) {
        MFPaymentCardView cardView = cardViewFactory.paymentCardView;
        if (cardView == null) {
            MFError mfError = new MFError("009", "cardView must be initialized");
            OnError(promise, mfError);
            return;
        }
        MFSDK.INSTANCE.initiateSession(initiateSessionRequest, (MFResult<MFInitiateSessionResponse> result) -> {
            if (result instanceof MFResult.Success) {
                MFInitiateSessionResponse response = ((MFResult.Success<MFInitiateSessionResponse>) result).getResponse();
                LoadCardView(response, showNFCReadCardIcon, cardView);
                OnSuccess(promise, response);
            } else if (result instanceof MFResult.Fail) {
                MFError mfError = ((MFResult.Fail) result).getError();
                OnError(promise, mfError);
            }
            return Unit.INSTANCE;
        });
    }


    @Override
    public void Validate(String currency, IMFCallBack promise) {
        MFPaymentCardView cardView = (MFPaymentCardView) cardViewFactory.paymentCardView;

        cardView.validate(currency, (MFResult<String> result) -> {
            if (result instanceof MFResult.Success) {
                String response = ((MFResult.Success<String>) result).getResponse();
                OnSuccess(promise, response);
            } else if (result instanceof MFResult.Fail) {
                MFError mfError = ((MFResult.Fail) result).getError();
                OnError(promise, mfError);
            }
            return Unit.INSTANCE;
        });
    }

    public void Pay(MFExecutePaymentRequest executePaymentRequest, String lang, String currency, IMFCallBack promise) {
        MFPaymentCardView cardView = (MFPaymentCardView) cardViewFactory.paymentCardView;
        cardView.pay(
                activity,
                executePaymentRequest,
                lang,
                currency,
                (String invoiceId) -> {
                    OnInvoiceCreated(invoiceId);
                    Log.d(TAG, "invoiceId:" + invoiceId);
                    return Unit.INSTANCE;
                },
                (String invoiceId, MFResult<MFGetPaymentStatusResponse> result) -> {
                    if (result instanceof MFResult.Success) {
                        MFGetPaymentStatusResponse response = ((MFResult.Success<MFGetPaymentStatusResponse>) result).getResponse();
                        OnSuccess(promise, response);
                    } else if (result instanceof MFResult.Fail) {
                        MFError mfError = ((MFResult.Fail) result).getError();
                        OnError(promise, mfError);
                    }
                    return Unit.INSTANCE;
                });
    }

    @Override
    public void addListener(String eventName) {

    }

    @Override
    public void removeListeners(Integer count) {

    }

    //#endregion

    //#region Google Pay
    @NonNull
    @Override
    public void SetupGooglePayHelper(@NonNull String sessionId, @NonNull GooglePayRequest googlePayRequest, @NonNull IMFCallBack promise) {
        MFGooglePayButton googlePayButton = googlePayButtonFactory.mfGooglePayButton;
        if (googlePayButton == null) {
            MFError mfError = new MFError("010", "googlePayButton must be initialized");
            OnError(promise, mfError);
            return;
        }

        mfGooglePayHelper = new MFGooglePayHelper(
                activity,
                MFConstants.GooglePayRequestCODE,
                sessionId,
                googlePayRequest,
                (String invoiceId) -> {
                    OnInvoiceCreated(invoiceId);
                    Log.d("Tag", invoiceId);
                    return Unit.INSTANCE;
                },
                (String invoiceId, MFResult<MFGetPaymentStatusResponse> result) -> {
                    if (result instanceof MFResult.Success) {
                        MFGetPaymentStatusResponse response = ((MFResult.Success<MFGetPaymentStatusResponse>) result).getResponse();
                        OnSuccess(promise, response);
                    } else if (result instanceof MFResult.Fail) {
                        MFError mfError = ((MFResult.Fail) result).getError();
                        OnError(promise, mfError);
                    }
                    return Unit.INSTANCE;
                });

        mfGooglePayHelper.setGooglePayButton(googlePayButton);
        googlePayButton.setVisibility(View.VISIBLE);
    }
    //#endregion

    //#region EventEmitter Methods
    public IMFListener mfListener;

    private void OnInvoiceCreated(String invoiceId) {
        mfListener.OnInvoiceCreated(invoiceId);
    }

    private void OnCardBinChanged(String bin) {
        mfListener.OnCardBinChanged(bin);
    }

    private void OnCardHeightChanged(Float height) {
        mfListener.OnCardHeightChanged(height);
    }

    //#endregion

    //#region Helpers Methods
    private MFCountry getEnumCountry(String country) {
        if (country.equals(MFCountry.KUWAIT.getCode()))
            return MFCountry.KUWAIT;
        if (country.equals(MFCountry.SAUDI_ARABIA.getCode()))
            return MFCountry.SAUDI_ARABIA;
        if (country.equals(MFCountry.BAHRAIN.getCode()))
            return MFCountry.BAHRAIN;
        if (country.equals(MFCountry.UNITED_ARAB_EMIRATES_UAE.getCode()))
            return MFCountry.UNITED_ARAB_EMIRATES_UAE;
        if (country.equals(MFCountry.QATAR.getCode()))
            return MFCountry.QATAR;
        if (country.equals(MFCountry.OMAN.getCode()))
            return MFCountry.OMAN;
        if (country.equals(MFCountry.JORDAN.getCode()))
            return MFCountry.JORDAN;
        if (country.equals(MFCountry.EGYPT.getCode()))
            return MFCountry.EGYPT;
        return MFCountry.KUWAIT;
    }

    private MFEnvironment getEnumEnvironment(String country) {
        if (country.equals(MFEnvironment.TEST.toString()))
            return MFEnvironment.TEST;
        if (country.equals(MFEnvironment.LIVE.toString()))
            return MFEnvironment.LIVE;
        return MFEnvironment.TEST;
    }

    private void OnError(IMFCallBack promise, MFError mfError) {
        promise.error(mfError);
    }

    private <T> void OnSuccess(IMFCallBack promise, T response) {
        promise.success(response);
    }


    private <T> T HandleReadableMap(String requestMap, Class<T> classOfT) {
        return MFExtentionsKt.handleReadableMap(requestMap, classOfT);
    }


    //#endregion
}
