
#import <Foundation/Foundation.h>

#define kApplicationTimeoutInMinutes 10
#define kApplicationDidTimeoutNotification @"AppTimeOut"

@interface OKTimer : UIApplication

-(void)resetIdleTimer;

@end