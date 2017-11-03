//
//  ViewController.h
//  SampleProject
//
//  Created by Gorilla Expense on 8/25/17.
//  Copyright © 2017 Gorilla Expense. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TServiceWrapper.h"
#import "AppDelegate.h"
#import "ReceiptViewController.h"
#import "BEMCheckBox.h"
#import "ArrangeCollectionViewController.h"

@interface ViewController : UIViewController <TServiceWrapperDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, BEMCheckBoxDelegate>

@property(nonatomic, strong)NSManagedObjectContext* managedObjectContext;

@end

