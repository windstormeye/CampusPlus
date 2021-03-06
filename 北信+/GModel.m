
#import "GModel.h"
#import "AppDelegate.h"

#define tokenKey @"tokenKey"
@implementation GModel

+(NSString *)getDeviceUUID{
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return uuid;
}

+(void)setToken:(NSString *)token{
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:tokenKey];
}

+(NSString *)getToken{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:tokenKey];
    if (!token) {
        token = @"a11112222";
    }
    return token;
}

+(UIViewController *)currentViewController {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    while (vc.presentedViewController) {
        vc = vc.presentedViewController;
        
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = [(UINavigationController *)vc visibleViewController];
        } else if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = [(UITabBarController *)vc selectedViewController];
        }
    }
    return vc;
}



@end
