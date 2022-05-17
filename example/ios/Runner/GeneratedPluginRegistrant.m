//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<device_info/FLTDeviceInfoPlugin.h>)
#import <device_info/FLTDeviceInfoPlugin.h>
#else
@import device_info;
#endif

#if __has_include(<myfatoorah_flutter/MyfatoorahFlutterPlugin.h>)
#import <myfatoorah_flutter/MyfatoorahFlutterPlugin.h>
#else
@import myfatoorah_flutter;
#endif

#if __has_include(<webview_flutter_wkwebview/FLTWebViewFlutterPlugin.h>)
#import <webview_flutter_wkwebview/FLTWebViewFlutterPlugin.h>
#else
@import webview_flutter_wkwebview;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FLTDeviceInfoPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTDeviceInfoPlugin"]];
  [MyfatoorahFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"MyfatoorahFlutterPlugin"]];
  [FLTWebViewFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTWebViewFlutterPlugin"]];
}

@end
