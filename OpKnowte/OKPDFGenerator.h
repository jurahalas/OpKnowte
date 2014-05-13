//
//  OKPDFGenerator.h
//  OpKnowte
//
//  Created by Artem Frolow on 5/13/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kBorderInset            60.0
#define kBorderWidth            1.0
#define kMarginInset            10.0

//Line drawing
#define kLineWidth              1.0
@interface OKPDFGenerator : NSObject{
    CGSize pageSize;
    NSString *printingString;
    UIImage * demoImage;
}

-(void)genratePdfFile:(NSString *)str withPath:(NSString *)fileName size:(int)count;
+(void)deletePdfFile:(NSString *)fileName;

@end
