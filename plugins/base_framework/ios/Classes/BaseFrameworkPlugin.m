#import "BaseFrameworkPlugin.h"
#if __has_include(<base_framework/base_framework-Swift.h>)
#import <base_framework/base_framework-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "base_framework-Swift.h"
#endif

@implementation BaseFrameworkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBaseFrameworkPlugin registerWithRegistrar:registrar];
}
@end
