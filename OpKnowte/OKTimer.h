
#import <Foundation/Foundation.h>

#define kApplicationTimeoutInMinutes 5
#define kApplicationDidTimeoutNotification @"AppTimeOut"

@interface OKTimer : UIApplication

-(void)resetIdleTimer;

@end