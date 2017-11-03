//
//  ArrangeCollectionViewController.h
//  SampleProject
//
//  Created by Vaibhav Bangde on 9/24/17.
//  Copyright © 2017 Gorilla Expense. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArrangeCollectionViewCell.h"
#import "AppDelegate.h"
#import "PDFGenratorViewController.h"

@interface ArrangeCollectionViewController : UICollectionViewController
@property (nonatomic, strong) NSMutableArray* receiptIds;
@property (nonatomic, strong) NSMutableArray* receiptsArray;
-(ArrangeCollectionViewCell*) cellForRowAtIndexPath:(NSIndexPath*)indexPath;
@end
