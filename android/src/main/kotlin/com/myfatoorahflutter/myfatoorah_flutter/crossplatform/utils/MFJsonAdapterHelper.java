package com.myfatoorahflutter.myfatoorah_flutter.crossplatform.utils;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParseException;
import com.myfatoorah.sdk.entity.MFCardViewStyle;
import com.myfatoorah.sdk.entity.executepayment.MFExecutePaymentRequest;
import com.myfatoorah.sdk.entity.sendpayment.MFSendPaymentRequest;
import com.myfatoorahflutter.myfatoorah_flutter.crossplatform.models.MFDirectPaymentRequest;
import com.myfatoorahflutter.myfatoorah_flutter.crossplatform.models.MFPaymentWithSavedTokenRequest;

import java.lang.reflect.Type;
import java.util.Map;

public class MFJsonAdapterHelper<T> implements JsonDeserializer<T> {
    @Override
    public T deserialize(JsonElement json, Type myClassType, JsonDeserializationContext context)
            throws JsonParseException {
        JsonObject replacementJsonObject = GenerateSubClass(json);

        // TODO remove after updating native SDK
        if (myClassType == MFExecutePaymentRequest.class || myClassType == MFSendPaymentRequest.class) {
            replacementJsonObject.addProperty("CallBackUrl", MFConstants.CALL_BACK_URL);
            replacementJsonObject.addProperty("ErrorUrl", MFConstants.ERROR_URL);
        } else if (myClassType == MFDirectPaymentRequest.class) {
            JsonObject executePaymentRequest = replacementJsonObject.get("ExecutePaymentRequest").getAsJsonObject();
            executePaymentRequest.addProperty("CallBackUrl", MFConstants.CALL_BACK_URL);
            executePaymentRequest.addProperty("ErrorUrl", MFConstants.ERROR_URL);
        } else if (myClassType == MFPaymentWithSavedTokenRequest.class) {
            JsonObject executePaymentRequest = replacementJsonObject.get("ExecutePaymentRequest").getAsJsonObject();
            executePaymentRequest.addProperty("CallBackUrl", MFConstants.CALL_BACK_URL);
            executePaymentRequest.addProperty("ErrorUrl", MFConstants.ERROR_URL);
        } else if (myClassType == MFCardViewStyle.class) {
            JsonElement savedCardText = replacementJsonObject.get("SavedCardText");
            replacementJsonObject.add("Text", savedCardText);
        }
        return new Gson().fromJson(replacementJsonObject, myClassType);
    }

    private JsonObject GenerateSubClass(JsonElement json) {
        JsonObject originalJsonObject = json.getAsJsonObject();
        JsonObject replacementJsonObject = new JsonObject();
        for (Map.Entry<String, JsonElement> elementEntry : originalJsonObject.entrySet()) {
            String key = elementEntry.getKey();
            JsonElement value = originalJsonObject.get(key);
            key = key.substring(0, 1).toUpperCase() + key.substring(1);
            if (value.isJsonObject())
                value = HandleJsonObject(value);
            else if (value.isJsonArray())
                value = HandleJsonArray(value);
            replacementJsonObject.add(key, value);
        }
        return replacementJsonObject;
    }

    private JsonElement HandleJsonObject(JsonElement value) {
        return GenerateSubClass(value);
    }

    private JsonArray HandleJsonArray(JsonElement value) {
        JsonArray jsonArray = new JsonArray();
        for (JsonElement jsonElement : value.getAsJsonArray())
            jsonArray.add(GenerateSubClass(jsonElement));
        return jsonArray;
    }

//  @Override
//  public T deserialize(JsonElement json, Type myClassType, JsonDeserializationContext context)
//    throws JsonParseException {
//    JsonObject originalJsonObject = json.getAsJsonObject();
//    JsonObject replacementJsonObject = new JsonObject();
//    for (Map.Entry<String, JsonElement> elementEntry : originalJsonObject.entrySet()) {
//      String key = elementEntry.getKey();
//      JsonElement value = originalJsonObject.get(key);
//      key = key.substring(0, 1).toUpperCase() + key.substring(1);
//      replacementJsonObject.add(key, value);
//    }
//    return new Gson().fromJson(replacementJsonObject, myClassType);
//  }
}
