#import "MyfatoorahFlutterPlugin.h"
#if __has_include(<myfatoorah_flutter/myfatoorah_flutter-Swift.h>)
#import <myfatoorah_flutter/myfatoorah_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "myfatoorah_flutter-Swift.h"
#endif

@implementation MyfatoorahFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMyfatoorahFlutterPlugin registerWithRegistrar:registrar];
}
@end
