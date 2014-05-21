//
//  OKBottomTabBarView.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/10/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OKBaseVCDelegate <NSObject>

-(void) goToSettingsVC;
-(void) goToDashboard;
-(void) goToInfoVC;
-(BOOL) navBar;
@end

@interface OKBottomTabBarView : UIView
@property (nonatomic, weak) id<OKBaseVCDelegate>delegate;
-(void) drawBottomTabBar;
@end
