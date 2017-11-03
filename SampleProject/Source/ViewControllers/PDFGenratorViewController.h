//
//  PDFGenratorViewController.h
//  SampleProject
//
//  Created by Vaibhav Bangde on 10/5/17.
//  Copyright © 2017 Gorilla Expense. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ViewController.h"
#import "TServiceWrapper.h"

#define kBorderInset            20.0
#define kBorderWidth            1.0
#define kMarginInset            10.0

//Line drawing
#define kLineWidth              1.0

@interface PDFGenratorViewController : UIViewController <TServiceWrapperDelegate> {
    CGSize pageSize;
}
@property (nonatomic, strong) NSMutableArray* receiptArray;

@end
