
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GModel : NSObject

+(NSString *)getDeviceUUID;

+(void)setToken:(NSString *)token;

+(NSString *)getToken;

+(UIViewController *)currentViewController;

@end
