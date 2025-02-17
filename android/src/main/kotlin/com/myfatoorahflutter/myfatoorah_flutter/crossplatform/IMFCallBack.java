package com.myfatoorahflutter.myfatoorah_flutter.crossplatform;

import com.myfatoorah.sdk.entity.MFError;

public interface IMFCallBack<T> {
    void success(T result);

    void error(MFError error);
}
