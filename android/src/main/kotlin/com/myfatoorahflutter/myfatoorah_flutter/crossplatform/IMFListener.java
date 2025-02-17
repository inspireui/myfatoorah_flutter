package com.myfatoorahflutter.myfatoorah_flutter.crossplatform;

public interface IMFListener {
    void OnInvoiceCreated(String invoiceId);

    void OnCardBinChanged(String bin);

    void OnCardHeightChanged(Float height);
}
