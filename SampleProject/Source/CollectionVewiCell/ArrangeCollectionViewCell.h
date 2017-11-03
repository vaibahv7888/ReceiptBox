//
//  ArrangeCollectionViewCell.h
//  SampleProject
//
//  Created by Vaibhav Bangde on 9/24/17.
//  Copyright © 2017 Gorilla Expense. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArrangeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *CoverView;
@property (nonatomic) BOOL hideFlag;
@property (nonatomic) UIImageView* cellImageView;

- (UIView *)snapshotViewAfterScreenUpdates:(BOOL)afterUpdates;
- (void) configureUI;
@end
