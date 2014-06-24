
#import <Foundation/Foundation.h>

#define kApplicationTimeoutInMinutes 20
#define kApplicationDidTimeoutNotification @"AppTimeOut"

@interface OKTimer : UIApplication

-(void)resetIdleTimer;

@end