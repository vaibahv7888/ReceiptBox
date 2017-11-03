//
//  ArrangeCollectionViewCell.m
//  SampleProject
//
//  Created by Vaibhav Bangde on 9/24/17.
//  Copyright © 2017 Gorilla Expense. All rights reserved.
//

#import "ArrangeCollectionViewCell.h"

@implementation ArrangeCollectionViewCell

-(ArrangeCollectionViewCell*)initWithFrame:(CGRect)frame {
    ArrangeCollectionViewCell* cell = [super initWithFrame:frame];
    [self configureUI];
    return cell;
}

- (void) configureUI {
//    self.imageView.clipsToBounds = true;
//    self.imageView.layer.cornerRadius = 5.0;
//    [self.imageView setContentMode:UIViewContentModeScaleToFill];
//    self.imageView.translatesAutoresizingMaskIntoConstraints = false;
//    self.hideFlag = false;
    if (self.cellImageView == NULL) {
        self.cellImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    self.cellImageView.clipsToBounds = true;
    self.cellImageView.layer.cornerRadius = 5.0;
    [self.cellImageView setContentMode:UIViewContentModeScaleToFill];
    self.cellImageView.translatesAutoresizingMaskIntoConstraints = false;

    [self.contentView addSubview:self.cellImageView];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:[NSDictionary dictionaryWithObject:self.cellImageView forKey:@"imageView"]]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:[NSDictionary dictionaryWithObject:self.cellImageView forKey:@"imageView"]]];
    
}

- (UIView *)snapshotViewAfterScreenUpdates:(BOOL)afterUpdates {
    UIView* snapshot = [super snapshotViewAfterScreenUpdates:afterUpdates];
    
    if (snapshot!=NULL) {
        [snapshot.layer setMasksToBounds:NO];
        [snapshot.layer setShadowOffset:CGSizeMake(-5.0, 0.0)];
        [snapshot.layer setShadowRadius:5.0];
        [snapshot.layer setShadowOpacity:0.4];
        snapshot.center = self.contentView.center;
    }
    return snapshot;
}

@end
