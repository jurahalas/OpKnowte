//
//  GentatePDFFile.h
//  POS
//
//  Created by mac on 12/4/12.
//  Copyright (c) 2012 EMSystems. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kBorderInset            60.0
#define kBorderWidth            1.0
#define kMarginInset            10.0

//Line drawing
#define kLineWidth              1.0
@interface GentatePDFFile : NSObject{
    CGSize pageSize;
    NSString *printingString;
    UIImage * demoImage;
}

-(void)genratePdfFile:(NSString *)str withPath:(NSString *)fileName size:(int)count;
+(void)deletePdfFile:(NSString *)fileName;

@end
