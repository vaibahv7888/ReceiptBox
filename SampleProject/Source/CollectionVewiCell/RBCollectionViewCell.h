//
//  RBCollectionViewCell.h
//  SampleProject
//
//  Created by Vaibhav Bangde on 9/3/17.
//  Copyright © 2017 Gorilla Expense. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMCheckBox.h"

@interface RBCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *receiptImageView;
@property (weak, nonatomic) IBOutlet UILabel *receiptCostLable;
@property (weak, nonatomic) IBOutlet BEMCheckBox *checkBox;
@property (weak, nonatomic) IBOutlet UIImageView *syncIcon;

@end
