package com.myfatoorahflutter.myfatoorah_flutter;

import android.content.Context;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.myfatoorah.sdk.views.embeddedpayment.googlepay.MFGooglePayButton;

import java.util.Map;

import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class GooglePayButtonFactory extends PlatformViewFactory {
    public MFGooglePayButton mfGooglePayButton;

    GooglePayButtonFactory() {
        super(StandardMessageCodec.INSTANCE);
    }

    @NonNull
    @Override
    public PlatformView create(@NonNull Context context, int id, @Nullable Object args) {
        final Map<String, Object> creationParams = (Map<String, Object>) args;
        return new GooglePayButton(context, id, creationParams);
    }

    class GooglePayButton implements PlatformView {
        GooglePayButton(@NonNull Context context, int id, @Nullable Map<String, Object> creationParams) {
            mfGooglePayButton = new MFGooglePayButton(context, null);
        }

        @NonNull
        @Override
        public View getView() {
            return mfGooglePayButton;
        }

        @Override
        public void dispose() {
        }
    }
}