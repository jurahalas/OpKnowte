//
//  OKPDFGenerator.m
//  OpKnowte
//
//  Created by Artem Frolow on 5/13/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKPDFGenerator.h"
@interface OKPDFGenerator (Private)
- (void) generatePdfWithFilePath: (NSString *)thefilePath;
- (void)drawPageNumber:(NSInteger)pageNum;
- (void) drawBorder;
- (void) drawText;
- (void) drawLine;
- (void) drawHeader;
- (void) drawImage;
@end
@implementation OKPDFGenerator
#pragma mark - Private Methods
- (void) drawBorder
{
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    UIColor *borderColor = [UIColor blackColor];
    
    CGRect rectFrame = CGRectMake(kBorderInset, kBorderInset, pageSize.width-kBorderInset*2, pageSize.height-kBorderInset*2);
    
    CGContextSetStrokeColorWithColor(currentContext, borderColor.CGColor);
    CGContextSetLineWidth(currentContext, kBorderWidth);
    CGContextStrokeRect(currentContext, rectFrame);
}

- (void)drawPageNumber:(NSInteger)pageNumber
{
    NSString* pageNumberString = [NSString stringWithFormat:@"Page %d", pageNumber];
    UIFont* theFont = [UIFont systemFontOfSize:12];
    
    CGSize pageNumberStringSize = [pageNumberString sizeWithFont:theFont
                                               constrainedToSize:pageSize
                                                   lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect stringRenderingRect = CGRectMake(kBorderInset,
                                            pageSize.height - 40.0,
                                            pageSize.width - 2*kBorderInset,
                                            pageNumberStringSize.height);
    
    [pageNumberString drawInRect:stringRenderingRect withFont:theFont lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
}

- (void) drawHeader
{
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(currentContext, 0.3, 0.7, 0.2, 1.0);
    
    NSString *textToDraw = @"Pdf Demo - iOSLearner.com";
    
    UIFont *font = [UIFont systemFontOfSize:24.0];
    
    CGSize stringSize = [textToDraw sizeWithFont:font constrainedToSize:CGSizeMake(pageSize.width - 2*kBorderInset-2*kMarginInset, pageSize.height - 2*kBorderInset - 2*kMarginInset) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect renderingRect = CGRectMake(kBorderInset + kMarginInset, kBorderInset + kMarginInset, pageSize.width - 2*kBorderInset - 2*kMarginInset, stringSize.height);
    
    [textToDraw drawInRect:renderingRect withFont:font lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
}

- (void) drawText
{
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(currentContext, 0.0, 0.0, 0.0, 1.0);
    
    NSString *textToDraw = [NSString stringWithFormat:@"%@",printingString];
    
    UIFont *font = [UIFont fontWithName:@"Courier New" size:10];
    
    CGSize stringSize = [textToDraw sizeWithFont:font
                               constrainedToSize:CGSizeMake(pageSize.width - 2*kBorderInset-2*kMarginInset, pageSize.height - 2*kBorderInset - 2*kMarginInset)
                                   lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect renderingRect = CGRectMake(kBorderInset + kMarginInset, kBorderInset + kMarginInset + demoImage.size.height, pageSize.width - 2*kBorderInset - 2*kMarginInset, stringSize.height);
    NSLog(@"%.2f",demoImage.size.height);
    
    [textToDraw drawInRect:renderingRect
                  withFont:font
             lineBreakMode:NSLineBreakByWordWrapping
                 alignment:NSTextAlignmentLeft];
    
}

- (void) drawLine
{
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(currentContext, kLineWidth);
    
    CGContextSetStrokeColorWithColor(currentContext, [UIColor blueColor].CGColor);
    
    CGPoint startPoint = CGPointMake(kMarginInset + kBorderInset, kMarginInset + kBorderInset + 40.0);
    CGPoint endPoint = CGPointMake(pageSize.width - 2*kMarginInset -2*kBorderInset, kMarginInset + kBorderInset + 40.0);
    
    CGContextBeginPath(currentContext);
    CGContextMoveToPoint(currentContext, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(currentContext, endPoint.x, endPoint.y);
    
    CGContextClosePath(currentContext);
    CGContextDrawPath(currentContext, kCGPathFillStroke);
}

- (void) drawImage
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *str =[NSString stringWithFormat:@"AppImageThumb.png"];
    
    NSString *myFilePath = [documentsDirectoryPath stringByAppendingPathComponent:str];
    demoImage = [UIImage imageWithContentsOfFile:myFilePath];
    [demoImage drawInRect:CGRectMake( (pageSize.width - demoImage.size.width/2)/2, 70, demoImage.size.width/2, demoImage.size.height/2)];
    NSLog(@"%.2f",demoImage.size.height);
}

- (void) generatePdfWithFilePath: (NSString *)thefilePath
{
    UIGraphicsBeginPDFContextToFile(thefilePath, CGRectZero, nil);
    
    NSInteger currentPage = 0;
    BOOL done = NO;
    do
    {
        //Start a new page.
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, pageSize.width, pageSize.height), nil);
        
        //Draw a page number at the bottom of each page.
        currentPage++;
        [self drawPageNumber:currentPage];
        
        //Draw a border for each page.
        [self drawBorder];
        
        //Draw text fo our header.
        // [self drawHeader];
        
        //Draw a line below the header.
        //[self drawLine];
        //Draw an image
        [self drawImage];
        
        //Draw some text for the page.
        [self drawText];
        
        done = YES;
    }
    while (!done);
    
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();
}


-(void)genratePdfFile:(NSString *)str withPath:(NSString *)fileName size:(int)count{
    //NSLog(@"%@",str);
    printingString = str;
    UIFont *font = [UIFont fontWithName:@"PTSans-NarrowBold" size:15];
    [str sizeWithFont:font];
    
    //NSString* stringToFind = @"\n";
    //NSArray *listItems = [str componentsSeparatedByString:stringToFind];
    //int count = [listItems count] - 1;
    
    // if (count > 1) {
    //   pageSize = CGSizeMake(400, count*175);
    //}else{
    pageSize = CGSizeMake(400, (count*250)-((count-1)*145));
    //}
    
    
    //NSString *fileName = @"opNote.pdf";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pdfFilePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    NSLog(@"%@",pdfFilePath);
    
    [self generatePdfWithFilePath:pdfFilePath];
}

+(void)deletePdfFile:(NSString *)fileName{
    
    NSLog(@"%@",fileName);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //if ([fileManager fileExistsAtPath:fileName]) {
    [fileManager removeItemAtPath:fileName error:nil];
    NSLog(@"*********DELETE ACTION DONE*********");
    //}
    
}
@end
