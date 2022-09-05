import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:myfatoorah_flutter/ConfigManager.dart';
import 'package:myfatoorah_flutter/utils/ErrorsEnum.dart';

import 'AppConstants.dart';
import 'MFEnvironment.dart';

Future<Response> callAPI(String? api,
    {String apiLang = "",
    Object? request,
    Uri? uri,
    bool isGetAPI = false}) async {
  try {
    if (AppConstants.apiKey.isEmpty)
      return http.Response(
          "", ErrorHelper.getValue(ErrorsEnum.CONFIG_API_KEY_ERROR).code!);
//    else if (AppConstants.baseUrl.isEmpty)
//      return http.Response(
//          "", ErrorHelper.getValue(ErrorsEnum.CONFIG_BASE_URL_ERROR).code!);

    var mURI;
    if (api != null) {
      if (api.startsWith("http"))
        mURI = Uri.parse(api);
      else if (ConfigManager.getBaseURL() != null)
        mURI = Uri.parse(ConfigManager.getBaseURL() + api);
    } else
      mURI = uri;

    http.Response response;

    if (isGetAPI)
      response = await http.get(mURI);
    else
      response = await http.post(mURI,
          headers: {
            HttpHeaders.contentTypeHeader: ContentType.json.toString(),
            HttpHeaders.authorizationHeader: AppConstants.apiKey,
            HttpHeaders.acceptLanguageHeader: apiLang
          },
          body: request);

    if (ConfigManager.mUserConfig!.environment == MFEnvironment.TEST) {
      print("Http -> url: " + response.request.toString());
      print("Http -> statusCode: " + response.statusCode.toString());
      print("Http -> body: " + response.body);
    }

    return response;
  } on SocketException {
    return http.Response(
        "", ErrorHelper.getValue(ErrorsEnum.INTERNET_CONNECTION_ERROR).code!);
  }
}
