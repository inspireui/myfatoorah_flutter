package com.myfatoorahflutter.myfatoorah_flutter;

import androidx.annotation.NonNull;

import android.app.Activity;
import android.content.Context;
import android.view.View;
import android.webkit.WebView;
import android.widget.LinearLayout;

import androidx.annotation.Nullable;

import com.myfatoorah.sdk.views.embeddedpayment.MFPaymentCardView;

import java.util.Map;

import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

import com.myfatoorah.sdk.entity.MFCardViewStyle;
import com.myfatoorahflutter.myfatoorah_flutter.crossplatform.utils.MFExtentionsKt;

public class CardViewFactory extends PlatformViewFactory {
    public MFPaymentCardView paymentCardView;
    public boolean showNFCReadCardIcon = false;

    CardViewFactory() {
        super(StandardMessageCodec.INSTANCE);
    }

    @NonNull
    @Override
    public PlatformView create(@NonNull Context context, int id, @Nullable Object args) {
        final Map<String, Object> creationParams = (Map<String, Object>) args;
        return new CardView(context, id, creationParams);
    }

    class CardView implements PlatformView {
        CardView(@NonNull Context context, int id, @Nullable Map<String, Object> creationParams) {
            paymentCardView = new MFPaymentCardView(context);
            WebView webView = paymentCardView.findViewById(com.myfatoorah.sdk.R.id.webView_cardView);
            ((View) webView.getParent()).setLayoutParams(new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT));
            webView.setLayoutParams(new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT));

            String cardViewStyleJson = creationParams != null ? (String) creationParams.get("cardViewStyle") : null;
            if (cardViewStyleJson != null && !cardViewStyleJson.isEmpty()) {
                MFCardViewStyle cardViewStyle = MFExtentionsKt.handleReadableMap(cardViewStyleJson, MFCardViewStyle.class);
                MFExtentionsKt.setDefault(cardViewStyle);
                paymentCardView.setCardStyle(cardViewStyle);
            } else {
                paymentCardView.setCardStyle(new MFCardViewStyle());
            }
        }

        @NonNull
        @Override
        public View getView() {
            return paymentCardView;
        }

        @Override
        public void dispose() {
        }
    }

    public void EnableNFC(Activity activity) {
        if (paymentCardView != null && showNFCReadCardIcon)
            paymentCardView.enableCardNFC(activity);
    }

    public void DisableNFC() {
        if (paymentCardView != null && showNFCReadCardIcon)
            paymentCardView.disableCardNFC();
    }
}