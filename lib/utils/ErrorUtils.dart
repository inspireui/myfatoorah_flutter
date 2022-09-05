import 'dart:convert';

import 'package:myfatoorah_flutter/model/MFError.dart';
import 'package:myfatoorah_flutter/model/MyBaseResponse.dart';

import 'ErrorsEnum.dart';

import 'package:myfatoorah_flutter/model/directpayment/MFCardInfo.dart'
    as CardInfo;

MFError getErrorMsg(int statusCode, String body) {
  if (statusCode == ErrorHelper.getValue(ErrorsEnum.CONFIG_API_KEY_ERROR).code)
    return ErrorHelper.getValue(ErrorsEnum.CONFIG_API_KEY_ERROR);
  else if (statusCode ==
      ErrorHelper.getValue(ErrorsEnum.CONFIG_BASE_URL_ERROR).code)
    return ErrorHelper.getValue(ErrorsEnum.CONFIG_BASE_URL_ERROR);
  else if (statusCode ==
      ErrorHelper.getValue(ErrorsEnum.INTERNET_CONNECTION_ERROR).code)
    return ErrorHelper.getValue(ErrorsEnum.INTERNET_CONNECTION_ERROR);
  else if (statusCode == ErrorHelper.getValue(ErrorsEnum.SERVER_ERROR).code)
    return ErrorHelper.getValue(ErrorsEnum.SERVER_ERROR);
  else if (statusCode ==
      ErrorHelper.getValue(ErrorsEnum.UN_AUTHORIZED_ERROR).code)
    return ErrorHelper.getValue(ErrorsEnum.UN_AUTHORIZED_ERROR);
  else if (statusCode == ErrorHelper.getValue(ErrorsEnum.NOT_FOUND_ERROR).code)
    return ErrorHelper.getValue(ErrorsEnum.NOT_FOUND_ERROR);
  else {
    try {
      var error = MyBaseResponse.fromJson(json.decode(body));
      return MFError(ErrorHelper.getValue(ErrorsEnum.BAD_REQUEST_ERROR).code,
          parseErrorMessage(error));
    } on Exception {
      return ErrorHelper.getValue(ErrorsEnum.UN_KNOWN_ERROR);
    }
  }
}

String? parseErrorMessage(MyBaseResponse error) {
  var message = "";
  if (error.message != null) message = error.message!;

  if (error.validationErrors != null && error.validationErrors!.isNotEmpty) {
    message += "\n";
    for (int i = 0; i < error.validationErrors!.length; i++) {
      var obj = error.validationErrors![i];
      if (obj.name != null && obj.error != null)
        message += obj.name! + " --> " + obj.error! + "\n";
    }
  }
  return message;
}

String? validateCardInfo(CardInfo.Card card) {
  if (card.number!.isEmpty || card.number!.length > 19)
    return ErrorHelper.getValue(ErrorsEnum.INVALID_CARD_NUMBER_ERROR).message;
  else if (card.expiryMonth!.isEmpty || card.expiryMonth!.length > 2)
    return ErrorHelper.getValue(ErrorsEnum.INVALID_CARD_EXPIRY_MONTH_ERROR)
        .message;
  else if (card.expiryYear!.isEmpty || card.expiryYear!.length > 2)
    return ErrorHelper.getValue(ErrorsEnum.INVALID_CARD_EXPIRY_YEAR_ERROR)
        .message;
  else if (card.securityCode!.isEmpty ||
      card.securityCode!.length < 3 ||
      card.securityCode!.length > 4)
    return ErrorHelper.getValue(ErrorsEnum.INVALID_CARD_SECURITY_CODE_ERROR)
        .message;
  else if (card.cardHolderName!.isEmpty ||
      new RegExp("^[a-zA-Z0-9]*\$")
              .hasMatch(card.cardHolderName!.replaceAll(" ", "")) ==
          false)
    return ErrorHelper.getValue(ErrorsEnum.INVALID_CARD_HOLDER_NAME_ERROR)
        .message;
  return "";
}
