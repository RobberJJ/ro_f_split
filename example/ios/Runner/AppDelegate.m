#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "RoFPlatformViewFactory.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
    RoFPlatformViewFactory * roFPlatformViewFactory = [[RoFPlatformViewFactory alloc] init];
  [[self registrarForPlugin:@"RoFSplit"] registerViewFactory:roFPlatformViewFactory withId:@"MyUiKitView"];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
