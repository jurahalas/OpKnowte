
#import <Foundation/Foundation.h>

#define kApplicationTimeoutInMinutes 0.1
#define kApplicationDidTimeoutNotification @"AppTimeOut"

@interface OKTimer : UIApplication

-(void)resetIdleTimer;

@end