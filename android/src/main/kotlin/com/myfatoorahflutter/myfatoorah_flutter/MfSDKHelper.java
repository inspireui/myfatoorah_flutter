package com.myfatoorahflutter.myfatoorah_flutter;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.myfatoorah.sdk.entity.MFError;
import com.myfatoorah.sdk.entity.executepayment.MFExecutePaymentRequest;
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
import com.myfatoorahflutter.myfatoorah_flutter.crossplatform.IMFCallBack;
import com.myfatoorahflutter.myfatoorah_flutter.crossplatform.IMyfatoorahModule;
import com.myfatoorahflutter.myfatoorah_flutter.crossplatform.models.MFDirectPaymentRequest;
import com.myfatoorahflutter.myfatoorah_flutter.crossplatform.models.MFGooglePayRequest;
import com.myfatoorahflutter.myfatoorah_flutter.crossplatform.models.MFPaymentWithSavedTokenRequest;
import com.myfatoorahflutter.myfatoorah_flutter.crossplatform.utils.MFConstants;
import com.myfatoorahflutter.myfatoorah_flutter.crossplatform.utils.MFExtentionsKt;

import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;
import java.util.ArrayList;

import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.StandardMessageCodec;

@SuppressWarnings({"unused", "unchecked", "CodeBlock2Expr", "RedundantSuppression", "serial"})
public class MfSDKHelper {
    @NonNull
    protected static ArrayList<Object> wrapError(@NonNull MFError error) {
        ArrayList<Object> errorList = new ArrayList<>(3);
        errorList.add(error.getCode());
        errorList.add(error.getMessage());
        errorList.add("MF ERROR");
        return errorList;
    }

    private static class MFSDKHelperCodec extends StandardMessageCodec {
        public static final MFSDKHelperCodec INSTANCE = new MFSDKHelperCodec();

        private MFSDKHelperCodec() {
        }

        @Override
        protected Object readValueOfType(byte type, @NonNull ByteBuffer buffer) {
            switch (type) {
                case (byte) MFConstants.BufferType.MFPaymentWithSavedTokenRequest:
                    return MFExtentionsKt.handleReadableMap((String) readValue(buffer), MFPaymentWithSavedTokenRequest.class);
                case (byte) MFConstants.BufferType.MFDirectPaymentRequest:
                    return MFExtentionsKt.handleReadableMap((String) readValue(buffer), MFDirectPaymentRequest.class);
                case (byte) MFConstants.BufferType.MFExecutePaymentRequest:
                    return MFExtentionsKt.handleReadableMap((String) readValue(buffer), MFExecutePaymentRequest.class);
                case (byte) MFConstants.BufferType.MFGetPaymentStatusRequest:
                    return MFExtentionsKt.handleReadableMap((String) readValue(buffer), MFGetPaymentStatusRequest.class);
                case (byte) MFConstants.BufferType.MFInitiatePaymentRequest:
                    return MFExtentionsKt.handleReadableMap((String) readValue(buffer), MFInitiatePaymentRequest.class);
                case (byte) MFConstants.BufferType.MFInitiateSessionRequest:
                    return MFExtentionsKt.handleReadableMap((String) readValue(buffer), MFInitiateSessionRequest.class);
                case (byte) MFConstants.BufferType.MFInitiateSessionResponse:
                    return MFExtentionsKt.handleReadableMap((String) readValue(buffer), MFInitiateSessionResponse.class);
                case (byte) MFConstants.BufferType.MFSendPaymentRequest:
                    return MFExtentionsKt.handleReadableMap((String) readValue(buffer), MFSendPaymentRequest.class);
                case (byte) MFConstants.BufferType.MFGooglePayRequest:
                    return MFExtentionsKt.handleReadableMap((String) readValue(buffer), MFGooglePayRequest.class);
                default:
                    return super.readValueOfType(type, buffer);
            }
        }

        @Override
        protected void writeValue(@NonNull ByteArrayOutputStream stream, Object value) {
            if (value instanceof MFDirectPaymentResponse) {
                stream.write(MFConstants.BufferType.MFDirectPaymentResponse);
                writeValue(stream, MFExtentionsKt.toJson(value));
            } else if (value instanceof MFGetPaymentStatusResponse) {
                stream.write(MFConstants.BufferType.MFGetPaymentStatusResponse);
                writeValue(stream, MFExtentionsKt.toJson(value));
            } else if (value instanceof MFInitiatePaymentResponse) {
                stream.write(MFConstants.BufferType.MFInitiatePaymentResponse);
                writeValue(stream, MFExtentionsKt.toJson(value));
            } else if (value instanceof MFInitiateSessionResponse) {
                stream.write(MFConstants.BufferType.MFInitiateSessionResponse);
                writeValue(stream, MFExtentionsKt.toJson(value));
            } else if (value instanceof MFSendPaymentResponse) {
                stream.write(MFConstants.BufferType.MFSendPaymentResponse);
                writeValue(stream, MFExtentionsKt.toJson(value));
            } else if (value instanceof MFError) {
                stream.write(MFConstants.BufferType.MFError);
                writeValue(stream, MFExtentionsKt.toJson(value));
            } else {
                super.writeValue(stream, value);
            }
        }
    }

    /**
     * Generated interface that represents a handler of messages from Flutter.
     */
    public interface MFSDKHelper extends IMyfatoorahModule {
        /**
         * The codec used by MFSDKHelper.
         */
        static @NonNull MessageCodec<Object> getCodec() {
            return MFSDKHelperCodec.INSTANCE;
        }

        /**
         * Sets up an instance of `MFSDKHelper` to handle messages through the `binaryMessenger`.
         */
        static void setup(@NonNull BinaryMessenger binaryMessenger, @Nullable MFSDKHelper api) {
            {
                BasicMessageChannel<Object> channel =
                        new BasicMessageChannel<>(binaryMessenger, MFConstants.ChannelName.initiatePayment, getCodec());
                if (api != null) {
                    channel.setMessageHandler(
                            (message, reply) -> {
                                ArrayList<Object> args = (ArrayList<Object>) message;
                                MFInitiatePaymentRequest initiatePaymentRequest = (MFInitiatePaymentRequest) args.get(0);
                                String lang = (String) args.get(1);
                                api.InitiatePayment(initiatePaymentRequest, lang, resultCallback(reply));
                            });
                } else {
                    channel.setMessageHandler(null);
                }
            }
            {
                BasicMessageChannel<Object> channel =
                        new BasicMessageChannel<>(binaryMessenger, MFConstants.ChannelName.loadConfig, getCodec());
                if (api != null) {
                    channel.setMessageHandler(
                            (message, reply) -> {
                                ArrayList<Object> args = (ArrayList<Object>) message;
                                String apiKey = (String) args.get(0);
                                String country = (String) args.get(1);
                                String environment = (String) args.get(2);
                                api.loadConfig(apiKey, country, environment, resultCallback(reply));
                            });
                } else {
                    channel.setMessageHandler(null);
                }
            }
            {
                BasicMessageChannel<Object> channel =
                        new BasicMessageChannel<>(binaryMessenger, MFConstants.ChannelName.setUpActionBar, getCodec());
                if (api != null) {
                    channel.setMessageHandler(
                            (message, reply) -> {
                                ArrayList<Object> args = (ArrayList<Object>) message;
                                String toolBarTitle = (String) args.get(0);
                                Number toolBarTitleColor = (Number) args.get(1);
                                Number toolBarBackgroundColor = (Number) args.get(2);
                                Boolean isShowToolBar = (Boolean) args.get(3);
                                api.setUpActionBar(toolBarTitle, (toolBarTitleColor == null) ? null : toolBarTitleColor.intValue(), (toolBarBackgroundColor == null) ? null : toolBarBackgroundColor.intValue(), isShowToolBar, resultCallback(reply));
                            });
                } else {
                    channel.setMessageHandler(null);
                }
            }
            {
                BasicMessageChannel<Object> channel =
                        new BasicMessageChannel<>(binaryMessenger, MFConstants.ChannelName.sendPayment, getCodec());
                if (api != null) {
                    channel.setMessageHandler(
                            (message, reply) -> {
                                ArrayList<Object> args = (ArrayList<Object>) message;
                                MFSendPaymentRequest sendPaymentRequest = (MFSendPaymentRequest) args.get(0);
                                String lang = (String) args.get(1);
                                api.SendPayment(sendPaymentRequest, lang, resultCallback(reply));
                            });
                } else {
                    channel.setMessageHandler(null);
                }
            }
            {
                BasicMessageChannel<Object> channel =
                        new BasicMessageChannel<>(binaryMessenger, MFConstants.ChannelName.getPaymentStatus, getCodec());
                if (api != null) {
                    channel.setMessageHandler(
                            (message, reply) -> {
                                ArrayList<Object> args = (ArrayList<Object>) message;
                                MFGetPaymentStatusRequest getPaymentStatusRequest = (MFGetPaymentStatusRequest) args.get(0);
                                String lang = (String) args.get(1);
                                api.GetPaymentStatus(getPaymentStatusRequest, lang, resultCallback(reply));
                            });
                } else {
                    channel.setMessageHandler(null);
                }
            }
            {
                BasicMessageChannel<Object> channel =
                        new BasicMessageChannel<>(binaryMessenger, MFConstants.ChannelName.executePayment, getCodec());
                if (api != null) {
                    channel.setMessageHandler(
                            (message, reply) -> {
                                ArrayList<Object> args = (ArrayList<Object>) message;
                                MFExecutePaymentRequest executePaymentRequest = (MFExecutePaymentRequest) args.get(0);
                                String lang = (String) args.get(1);
                                api.ExecutePayment(executePaymentRequest, lang, resultCallback(reply));
                            });
                } else {
                    channel.setMessageHandler(null);
                }
            }
            {
                BasicMessageChannel<Object> channel =
                        new BasicMessageChannel<>(binaryMessenger, MFConstants.ChannelName.executePaymentWithSavedToken, getCodec());
                if (api != null) {
                    channel.setMessageHandler(
                            (message, reply) -> {
                                ArrayList<Object> args = (ArrayList<Object>) message;
                                MFPaymentWithSavedTokenRequest savedTokenRequest = (MFPaymentWithSavedTokenRequest) args.get(0);
                                String lang = (String) args.get(1);
                                api.ExecutePaymentWithSavedToken(savedTokenRequest, lang, resultCallback(reply));
                            });
                } else {
                    channel.setMessageHandler(null);
                }
            }
            {
                BasicMessageChannel<Object> channel =
                        new BasicMessageChannel<>(binaryMessenger, MFConstants.ChannelName.executeDirectPayment, getCodec());
                if (api != null) {
                    channel.setMessageHandler(
                            (message, reply) -> {
                                ArrayList<Object> args = (ArrayList<Object>) message;
                                MFDirectPaymentRequest directPaymentRequest = (MFDirectPaymentRequest) args.get(0);
                                String lang = (String) args.get(1);
                                api.ExecuteDirectPayment(directPaymentRequest, lang, resultCallback(reply));
                            });
                } else {
                    channel.setMessageHandler(null);
                }
            }
            {
                BasicMessageChannel<Object> channel =
                        new BasicMessageChannel<>(binaryMessenger, MFConstants.ChannelName.cancelToken, getCodec());
                if (api != null) {
                    channel.setMessageHandler(
                            (message, reply) -> {
                                ArrayList<Object> args = (ArrayList<Object>) message;
                                String token = (String) args.get(0);
                                String lang = (String) args.get(1);
                                api.cancelToken(token, lang, resultCallback(reply));
                            });
                } else {
                    channel.setMessageHandler(null);
                }
            }
            {
                BasicMessageChannel<Object> channel =
                        new BasicMessageChannel<>(binaryMessenger, MFConstants.ChannelName.cancelRecurringPayment, getCodec());
                if (api != null) {
                    channel.setMessageHandler(
                            (message, reply) -> {
                                ArrayList<Object> args = (ArrayList<Object>) message;
                                String recurringId = (String) args.get(0);
                                String lang = (String) args.get(1);
                                api.cancelRecurringPayment(recurringId, lang, resultCallback(reply));
                            });
                } else {
                    channel.setMessageHandler(null);
                }
            }
            {
                BasicMessageChannel<Object> channel =
                        new BasicMessageChannel<>(binaryMessenger, MFConstants.ChannelName.initSession, getCodec());
                if (api != null) {
                    channel.setMessageHandler(
                            (message, reply) -> {
                                ArrayList<Object> args = (ArrayList<Object>) message;
                                MFInitiateSessionRequest initiateSessionRequest = (MFInitiateSessionRequest) args.get(0);
                                String lang = (String) args.get(1);
                                api.InitSession(initiateSessionRequest, lang, resultCallback(reply));
                            });
                } else {
                    channel.setMessageHandler(null);
                }
            }
            {
                BasicMessageChannel<Object> channel =
                        new BasicMessageChannel<>(binaryMessenger, MFConstants.ChannelName.load, getCodec());
                if (api != null) {
                    channel.setMessageHandler(
                            (message, reply) -> {
                                ArrayList<Object> args = (ArrayList<Object>) message;
                                MFInitiateSessionResponse initiateSessionResponse = (MFInitiateSessionResponse) args.get(0);
                                boolean showNFCReadCardIcon = (args != null && !args.isEmpty()) ? (Boolean) args.get(1) : false;
                                api.Load(initiateSessionResponse, showNFCReadCardIcon);
                            });
                } else {
                    channel.setMessageHandler(null);
                }
            }
            {
                BasicMessageChannel<Object> channel =
                        new BasicMessageChannel<>(binaryMessenger, MFConstants.ChannelName.initiateSession, getCodec());
                if (api != null) {
                    channel.setMessageHandler(
                            (message, reply) -> {
                                ArrayList<Object> args = (ArrayList<Object>) message;
                                MFInitiateSessionRequest initiateSessionRequest = (MFInitiateSessionRequest) args.get(0);
                                boolean showNFCReadCardIcon = (args != null && !args.isEmpty()) ? (Boolean) args.get(1) : false;
                                api.InitiateSession(initiateSessionRequest, showNFCReadCardIcon, resultCallback(reply));
                            });
                } else {
                    channel.setMessageHandler(null);
                }
            }
            {
                BasicMessageChannel<Object> channel =
                        new BasicMessageChannel<>(binaryMessenger, MFConstants.ChannelName.validate, getCodec());
                if (api != null) {
                    channel.setMessageHandler(
                            (message, reply) -> {
                                ArrayList<Object> args = (ArrayList<Object>) message;
                                String currency = (args != null && !args.isEmpty()) ? (String) args.get(0) : "";
                                api.Validate(currency, resultCallback(reply));
                            });
                } else {
                    channel.setMessageHandler(null);
                }
            }
            {
                BasicMessageChannel<Object> channel =
                        new BasicMessageChannel<>(binaryMessenger, MFConstants.ChannelName.pay, getCodec());
                if (api != null) {
                    channel.setMessageHandler(
                            (message, reply) -> {
                                ArrayList<Object> args = (ArrayList<Object>) message;
                                MFExecutePaymentRequest executePaymentRequest = (MFExecutePaymentRequest) args.get(0);
                                String lang = (String) args.get(1);
                                String currency = (args != null && args.size() > 2) ? (String) args.get(2) : "";
                                api.Pay(executePaymentRequest, lang, currency, resultCallback(reply));
                            });
                } else {
                    channel.setMessageHandler(null);
                }
            }
            {
                BasicMessageChannel<Object> channel =
                        new BasicMessageChannel<>(binaryMessenger, MFConstants.ChannelName.googlePayPayment, getCodec());
                if (api != null) {
                    channel.setMessageHandler(
                            (message, reply) -> {
                                ArrayList<Object> args = (ArrayList<Object>) message;
                                String sessionId = (String) args.get(0);
                                MFGooglePayRequest request = (MFGooglePayRequest) args.get(1);
                                GooglePayRequest googlePayRequest = new GooglePayRequest(
                                        request.TotalPrice,
                                        request.MerchantId,
                                        request.MerchantName,
                                        request.CountryCode,
                                        request.CurrencyIso
                                );
                                api.SetupGooglePayHelper(sessionId, googlePayRequest, resultCallback(reply));
                            });
                } else {
                    channel.setMessageHandler(null);
                }
            }
        }


        static <T> IMFCallBack<T> resultCallback(BasicMessageChannel.Reply<Object> reply) {
            return new IMFCallBack<T>() {
                public void success(T result) {
                    ArrayList<Object> wrapped = new ArrayList<>();
                    wrapped.add(0, result);
                    reply.reply(wrapped);
                }

                public void error(MFError error) {
                    ArrayList<Object> wrappedError = wrapError(error);
                    reply.reply(wrappedError);
                }
            };
        }
    }
}
