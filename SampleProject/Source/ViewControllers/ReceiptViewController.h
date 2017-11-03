//
//  ReceiptViewController.h
//  SampleProject
//
//  Created by Vaibhav Bangde on 9/5/17.
//  Copyright © 2017 Gorilla Expense. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "TServiceWrapper.h"

@interface ReceiptViewController : UIViewController <TServiceWrapperDelegate>

@property (nonatomic) NSInteger userID;
@property (nonatomic, strong) NSString* receiptPath;
@property (strong, nonatomic) NSManagedObject *receipt;

@end
