package com.myfatoorahflutter.myfatoorah_flutter.crossplatform.utils

import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.myfatoorah.sdk.entity.MFBoxShadow
import com.myfatoorah.sdk.entity.MFCardViewError
import com.myfatoorah.sdk.entity.MFCardViewInput
import com.myfatoorah.sdk.entity.MFCardViewLabel
import com.myfatoorah.sdk.entity.MFCardViewPlaceHolder
import com.myfatoorah.sdk.entity.MFCardViewStyle
import com.myfatoorah.sdk.entity.MFCardViewText
import com.myfatoorah.sdk.entity.MFDeleteAlert
import com.myfatoorah.sdk.entity.MFSavedCardText

fun <T> handleReadableMap(requestJson: String, classOfT: Class<T>): T {
    val gson = GsonBuilder().registerTypeAdapter(classOfT, MFJsonAdapterHelper<T>()).create()
    return gson.fromJson(requestJson, classOfT)
}

fun toJson(_object: Any?): String? {
    return Gson().toJson(_object)
}

fun MFCardViewStyle.setDefault() {
    var defaultStyle = MFCardViewStyle()
    if (this.cardHeight == null) this.cardHeight = defaultStyle.cardHeight
    if (this.tokenHeight == null) this.tokenHeight = defaultStyle.tokenHeight
    if (this.hideCardIcons == null) this.hideCardIcons = defaultStyle.hideCardIcons
    if (this.direction == null) this.direction = defaultStyle.direction
    if (this.input == null) {
        this.input = defaultStyle.input
    } else {
        this.input?.setDefault()
    }
    if (this.text == null) {
        this.text = defaultStyle.text
    } else {
        this.text?.setDefault()
    }
    if (this.label == null) {
        this.label = defaultStyle.label
    } else {
        this.label?.setDefault()
    }
    if (this.error == null) {
        this.error = defaultStyle.error
    } else {
        this.error?.setDefault()
    }
    if (this.backgroundColor == null) this.backgroundColor = defaultStyle.backgroundColor
}

fun MFCardViewInput.setDefault() {
    val defaultInput = MFCardViewInput()
    if (this.color == null) this.color = defaultInput.color
    if (this.fontSize == null) this.fontSize = defaultInput.fontSize
    if (this.fontFamily == null) this.fontFamily = defaultInput.fontFamily
    if (this.inputHeight == null) this.inputHeight = defaultInput.inputHeight
    if (this.inputMargin == null) this.inputMargin = defaultInput.inputMargin
    if (this.borderColor == null) this.borderColor = defaultInput.borderColor
    if (this.borderWidth == null) this.borderWidth = defaultInput.borderWidth
    if (this.borderRadius == null) this.borderRadius = defaultInput.borderRadius
    if (this.outerRadius == null) this.outerRadius = defaultInput.outerRadius
    if (this.boxShadow == null) {
        this.boxShadow = defaultInput.boxShadow
    } else {
        this.boxShadow?.setDefault()
    }
    if (this.placeHolder == null) {
        this.placeHolder = defaultInput.placeHolder
    } else {
        this.placeHolder?.setDefault()
    }
}

fun MFSavedCardText.setDefault() {
    val defaultText = MFSavedCardText()
    if (this.saveCardText == null) this.saveCardText = defaultText.saveCardText
    if (this.addCardText == null) this.addCardText = defaultText.addCardText
    if (this.deleteAlertText == null) {
        this.deleteAlertText = defaultText.deleteAlertText
    } else {
        this.deleteAlertText?.setDefault()
    }
}

fun MFCardViewLabel.setDefault() {
    val defaultLabel = MFCardViewLabel()
    if (this.display == null) this.display = defaultLabel.display
    if (this.color == null) this.color = defaultLabel.color
    if (this.fontSize == null) this.fontSize = defaultLabel.fontSize
    if (this.fontFamily == null) this.fontFamily = defaultLabel.fontFamily
    if (this.fontWeight == null) this.fontWeight = defaultLabel.fontWeight
    if (this.text == null) {
        this.text = defaultLabel.text
    } else {
        this.text?.setDefault()
    }
}

fun MFCardViewError.setDefault() {
    val defaultError = MFCardViewError()
    if (this.borderColor == null) this.borderColor = defaultError.borderColor
    if (this.borderRadius == null) this.borderRadius = defaultError.borderRadius
    if (this.boxShadow == null) {
        this.boxShadow = defaultError.boxShadow
    } else {
        this.boxShadow?.setDefault()
    }
}

fun MFCardViewText.setDefault() {
    val defaultText = MFCardViewText()
    if (this.holderName == null) this.holderName = defaultText.holderName
    if (this.cardNumber == null) this.cardNumber = defaultText.cardNumber
    if (this.expiryDate == null) this.expiryDate = defaultText.expiryDate
    if (this.securityCode == null) this.securityCode = defaultText.securityCode
}

fun MFBoxShadow.setDefault() {
    val defaultShadow = MFBoxShadow()
    if (this.hOffset == null) this.hOffset = defaultShadow.hOffset
    if (this.vOffset == null) this.vOffset = defaultShadow.vOffset
    if (this.blur == null) this.blur = defaultShadow.blur
    if (this.spread == null) this.spread = defaultShadow.spread
    if (this.color == null) this.color = defaultShadow.color
}

fun MFCardViewPlaceHolder.setDefault() {
    val defaultPlaceHolder = MFCardViewPlaceHolder()
    if (this.holderName == null) this.holderName = defaultPlaceHolder.holderName
    if (this.cardNumber == null) this.cardNumber = defaultPlaceHolder.cardNumber
    if (this.expiryDate == null) this.expiryDate = defaultPlaceHolder.expiryDate
    if (this.securityCode == null) this.securityCode = defaultPlaceHolder.securityCode
}

fun MFDeleteAlert.setDefault() {
    val defaultAlert = MFDeleteAlert()
    if (this.title == null) this.title = defaultAlert.title
    if (this.message == null) this.message = defaultAlert.message
    if (this.confirm == null) this.confirm = defaultAlert.confirm
    if (this.cancel == null) this.cancel = defaultAlert.cancel
}