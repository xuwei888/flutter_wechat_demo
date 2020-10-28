#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    
    FlutterViewController *flutterVc = (FlutterViewController *)self.window.rootViewController;
    self.methodChannel = [FlutterMethodChannel methodChannelWithName:@"mine_page" binaryMessenger:flutterVc];
    UIImagePickerController *imp = [[UIImagePickerController alloc] init];
    imp.delegate = self;
    [self.methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if([call.method isEqualToString:@"picture"])
        {
            NSLog(@"内容是%@",call.arguments);
//            result([[FlutterError alloc] init]);
            [flutterVc presentViewController:imp animated:YES completion:^{

            }];
            
            
        }
    }];
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@",info);
//    UIImagePickerControllerImageURL = "file:///Users/apple/Library/Developer/CoreSimulator/Devices/56CB9520-0478-4D38-A083-CF1BD502186C/data/Containers/Data/Application/13BCD351-67F4-4A29-8044-5469EB6984DF/tmp/C49A323E-01C9-435B-9F73-4A6DB3DA3377.jpeg";


    NSString *picUrl = [NSString stringWithFormat:@"%@",info[@"UIImagePickerControllerImageURL"]];
    //    UIImagePickerControllerReferenceURL = "assets-library://asset/asset.JPG?id=9F983DBA-EC35-42B8-8773-B597CF782EDD&ext=JPG";
    [self.methodChannel invokeMethod:@"imgPath" arguments:picUrl];
    
}


@end
