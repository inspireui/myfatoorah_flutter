import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:device_info/device_info.dart';
import 'package:myfatoorah_flutter/utils/AppConstants.dart';

class SourceInfo {
  BuildContext? context;

  SourceInfo(BuildContext context) {
    this.context = context;
  }

  Future<String> getData() async {
    String data = "";

    try {
      data = await getCallerType() +
          "-" +
          getCallerOS() +
          "-" +
          await getCallerOSVersion() +
          "-" +
          getPlatform() +
          "-" +
          getPluginVersion();
    } catch (_) {
      data = "";
    }
    print("SourceInfo: " + data);
    return data;
  }

  String getPluginVersion() {
    return "2.1.14";
  }

  String getAPIVersion() {
    return "ApiVersion=" + AppConstants.mAPIVersion;
  }

  String getPlatform() {
    return "flutter";
  }

  String getIntegrationType() {
    return "IntegrationType=mobile_plugin";
  }

  String getCallerOS() {
    return Platform.operatingSystem.toString();
  }

  Future<String> getCallerOSVersion() async {
    String mOSVersion = "";

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        mOSVersion = androidInfo.version.release;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        mOSVersion = iosInfo.systemVersion;
      }
    } catch (_) {
      mOSVersion = "";
    }

    return mOSVersion;
  }

  Future<String> getCallerType() async {
    String type = "";

    if (Platform.isAndroid) {
      if (WidgetsBinding.instance == null) {
        type = "";
      } else {
        final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
        type = data.size.shortestSide < 600 ? 'phone' : 'tablet';
      }
    } else if (Platform.isIOS) {
      try {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        String machine = iosInfo.utsname.machine;
        if (iosInfo.isPhysicalDevice) {
          if (machine.toLowerCase().contains("iphone"))
            type = "phone";
          else if (machine.toLowerCase().contains("ipad"))
            type = "ipad";
          else
            type = machine.toLowerCase();
        } else
          type = "simulator";
      } catch (_) {
        type = "";
      }
    }

    return type;
  }

  Future<String> getCallerId() async {
    String id = "";

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        id = androidInfo.androidId;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        id = iosInfo.identifierForVendor;
      }
    } catch (_) {}

    return "CallerID=" + id;
  }
}
