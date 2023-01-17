#import "CyrelUpdaterPlugin.h"
#if __has_include(<cyrel_updater/cyrel_updater-Swift.h>)
#import <cyrel_updater/cyrel_updater-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "cyrel_updater-Swift.h"
#endif

@implementation CyrelUpdaterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCyrelUpdaterPlugin registerWithRegistrar:registrar];
}
@end
