//
//  ArrangeCollectionViewController.m
//  SampleProject
//
//  Created by Vaibhav Bangde on 9/24/17.
//  Copyright © 2017 Gorilla Expense. All rights reserved.
//

#import "ArrangeCollectionViewController.h"

@interface ArrangeCollectionViewController ()
@property (nonatomic, strong) NSMutableArray* imagesArray;
@property (nonatomic, strong) UICollectionViewFlowLayout* collectionViewFlowLayout;
@property (nonatomic, strong) UIView* snapshotView;
@property (nonatomic, strong) NSIndexPath* snapshotIndexPath;
@property (nonatomic) CGPoint snapshotPanPoint;
@property (nonatomic, strong) NSMutableDictionary* receiptImgCache;
@end

@implementation ArrangeCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

//-(UICollectionViewFlowLayout*) collectionViewFlowLayout {
//    return [[UICollectionViewFlowLayout alloc] init];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    self.snapshotPanPoint = CGPointMake(0, 0);
    self.imagesArray = [[NSMutableArray alloc] init];
    //self.imagesArray = @[@"pic_0.jpg", @"pic_1.jpg", @"pic_2.jpg", @"pic_3.jpg", @"pic_4.jpg", @"pic_5.jpg"];
//    self.imagesArray = [NSMutableArray arrayWithObjects:@"pic_0.jpg", @"pic_1.jpg", @"pic_2.jpg", @"pic_3.jpg", @"pic_4.jpg", @"pic_5.jpg", @"pic_6.jpg", @"pic_7.jpg", @"pic_8.jpg", @"pic_9.jpg", nil];
    self.collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.receiptImgCache = [[NSMutableDictionary alloc] init];
    [self setTitle:@"Arrange"];
    [self setEdgesForExtendedLayout:UIRectEdgeAll];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    
    [self configureUI];
//    [self initialiseImages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSaveButtonClicked:(id)sender {
    [self performSegueWithIdentifier:@"CreatePDF" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"CreatePDF"]) {
        PDFGenratorViewController *receiptVC = [segue destinationViewController];
        
//        receiptVC.receiptArray = [[NSMutableArray alloc] initWithObjects:self.imagesArray, nil];
//        [receiptVC.receiptArray addObjectsFromArray:self.imagesArray];
        receiptVC.receiptArray = [self.imagesArray mutableCopy];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)initialiseImages {
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    for (NSNumber* receiptBoxId in self.receiptIds) {
        NSPredicate *p = [NSPredicate predicateWithFormat:@"receiptBoxID = %@", [receiptBoxId stringValue]];
        NSFetchRequest * fetctRequest = [NSFetchRequest fetchRequestWithEntityName:@"ReceiptBox"];
        [fetctRequest setIncludesPropertyValues:NO];
        [fetctRequest setPredicate:p];
        NSError *error = nil;
        NSArray *dbarray = [context executeFetchRequest:fetctRequest error:&error];
        if (dbarray.count > 0) {
            NSManagedObject* receipt = [dbarray objectAtIndex:0];
            UIImage* img = [UIImage imageWithData:[[receipt valueForKey:@"img"] data]];
            UIImage* rotatedImage;
            if ([receipt valueForKey:@"exif"] == [NSString stringWithFormat:@"90"]) {
               rotatedImage = [self imageRotatedByDegrees:img deg:90];
            } else {
                rotatedImage = img;
            }
            //        [self.imagesArray addObject:img];
            [self.imagesArray addObject:img];
        }
    }
}

- (UIImage *)imageRotatedByDegrees:(UIImage*)oldImage deg:(CGFloat)degrees{
    //Calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,oldImage.size.width, oldImage.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(degrees * M_PI / 180);
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    //Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    //Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //Rotate the image context
    CGContextRotateCTM(bitmap, (degrees * M_PI / 180));
    
    //Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-oldImage.size.width / 2, -oldImage.size.height / 2, oldImage.size.width, oldImage.size.height), [oldImage CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void)configureUI {
    self.collectionViewFlowLayout.minimumInteritemSpacing = 0;
    self.collectionViewFlowLayout.minimumLineSpacing = 0;
    self.collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    [self.collectionView registerNib:ArrangeCollectionViewCell.self forCellWithReuseIdentifier:@"ArrangeCollectionViewCell"];
//    [self.collectionView registerClass:[ArrangeCollectionViewCell class] forCellWithReuseIdentifier:@"ArrangeCollectionViewCell"];
    self.collectionView.backgroundColor = UIColor.whiteColor;
    self.collectionView.backgroundView.alpha = 0.2;
    
    UILongPressGestureRecognizer* gestureRecognizer = [[UILongPressGestureRecognizer alloc] init];
    [gestureRecognizer addTarget:self action:@selector(longPressRecognized:)];
    [self.collectionView addGestureRecognizer:gestureRecognizer];
}

- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha toImage:(UIImage *)initialImage
{
    UIGraphicsBeginImageContextWithOptions(initialImage.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, initialImage.size.width, initialImage.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, initialImage.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

NSIndexPath* selectedCellPath;

-(void) longPressRecognized:(UILongPressGestureRecognizer*) recognizer {
    CGPoint location = [recognizer locationInView:self.collectionView];
    NSIndexPath* indexPath = [self.collectionView indexPathForItemAtPoint:location];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            if (indexPath == NULL) {
                return;
            }
            selectedCellPath = indexPath;
            ArrangeCollectionViewCell *cell = [self collectionView:self.collectionView cellForItemAtIndexPath:indexPath];   //[self cellForRowAtIndexPath:indexPath];
            self.snapshotView = [cell snapshotViewAfterScreenUpdates:true];
            self.snapshotView.center = CGPointMake(location.x, location.y);
            [self.collectionView addSubview:self.snapshotView];
            cell.CoverView.hidden = NO;
            cell.CoverView.backgroundColor = self.collectionView.backgroundColor;
            NSLog(@"cell.contentView.alpha= %f", cell.contentView.alpha);
            NSLog(@"cell.imageView.alpha= %f", cell.imageView.alpha);
            [UIView animateWithDuration:0.2 animations:^{
                self.snapshotView.transform = CGAffineTransformMakeScale(1.1, 1.1);
                self.snapshotView.alpha = 0.9;
            }];
            
            self.snapshotPanPoint = location;
            self.snapshotIndexPath = indexPath;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
//            if (self.snapshotPanPoint == nil) {
//                return;
//            }
            CGPoint translation = CGPointMake(location.x - self.snapshotPanPoint.x, location.y - self.snapshotPanPoint.y);
            self.snapshotView.center = CGPointMake(self.snapshotView.center.x + translation.x, self.snapshotView.center.y + translation.y);
            self.snapshotPanPoint = location;
            
            if (indexPath == NULL) {
                return;
            }
            
//            [self.imagesArray exchangeObjectAtIndex:self.snapshotIndexPath.item withObjectAtIndex:indexPath.item];
            [self moveObjectsOfArray:self.imagesArray AtIndex:self.snapshotIndexPath.item toIndex:indexPath.item];
            [self moveObjectsOfArray:self.receiptsArray AtIndex:self.snapshotIndexPath.item toIndex:indexPath.item];
            [self.collectionView moveItemAtIndexPath:self.snapshotIndexPath toIndexPath:indexPath];
            self.snapshotIndexPath = indexPath;
        }
            break;
            
        default:
        {
            if (indexPath == NULL) {
                return;
            }
            ArrangeCollectionViewCell *cell = [self cellForRowAtIndexPath:indexPath];
            [UIView animateWithDuration:0.2 animations:^{
                self.snapshotView.transform = CGAffineTransformMakeScale(1.1, 1.1);
                self.snapshotView.alpha = 0.9;
            } completion:^(BOOL finished) {
//                cell.alpha = 1.0;
//                cell.contentView.alpha = 1.0;
                cell.imageView.alpha = 1.0;
//                cell.hideFlag = false;
                [self.snapshotView removeFromSuperview];
                self.snapshotView = nil;
            }];
            self.snapshotIndexPath = nil;
//            self.snapshotPanPoint = nil;
        }
            break;
    }
}

- (ArrangeCollectionViewCell*) cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    return [self collectionView:self.collectionView cellForItemAtIndexPath:indexPath];
}

- (void) moveObjectsOfArray:(NSMutableArray*)receipts AtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex{
    if (fromIndex == toIndex) return;
    if (fromIndex >= receipts.count) return; //there is no object to move, return
    if (toIndex >= receipts.count) toIndex = receipts.count - 1; //toIndex too large, assume a move to end
    id movingObject = [receipts objectAtIndex:fromIndex];
    
    if (fromIndex < toIndex){
        for (int i = (int)fromIndex; i <= toIndex; i++){
            [receipts replaceObjectAtIndex:i withObject:(i == toIndex) ? movingObject : [receipts objectAtIndex:i + 1]];
        }
    } else {
        id cObject;
        id prevObject;
        for (int i = (int)toIndex; i <= fromIndex; i++){
            cObject = [receipts objectAtIndex:i];
            [receipts replaceObjectAtIndex:i withObject:(i == toIndex) ? movingObject : prevObject];
            prevObject = cObject;
        }
    }
}

//- (UIImage*) getImageForIndexPath:(NSIndexPath*) indexpath {
//    UIImage* img;
//    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
//    NSManagedObjectContext *context = [delegate managedObjectContext];
//
//
//    return img;
//}

//- (UIImage*) getRotatedImageForIndexPath:(NSIndexPath*)indexPath {
//    UIImage* img;
//    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
//    NSManagedObjectContext *context = [delegate managedObjectContext];
//    
//    
//    
//    return img;
//}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of items
//    return self.imagesArray.count;
    return self.receiptIds.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ArrangeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ArrangeCollectionViewCell" forIndexPath:indexPath];
    // Configure the cell
//    [cell configureUI];
//    NSString* imgName = [self.imagesArray objectAtIndex:indexPath.row];
//    cell.imageView.image = [UIImage imageNamed:imgName];
//    cell.cellImageView.image = [UIImage imageNamed:imgName];
//    cell.backgroundColor = UIColor.darkGrayColor;
//    cell.backgroundColor = UIColor.clearColor;
//    cell.contentView.alpha = 0.0;
    cell.tag = indexPath.row;
    NSString *thumbnailCacheKey = [NSString stringWithFormat:@"cache_%ld", (long)indexPath.row];
    NSManagedObject* receipt = [self.receiptsArray objectAtIndex:indexPath.row];
//    NSLog(@"indexPath.row= %ld",(long)indexPath.row);
    if (![[self.receiptImgCache allKeys] containsObject:thumbnailCacheKey]) {
        NSString *thumbnailURL = [self.receiptIds objectAtIndex:indexPath.row];
        if (![thumbnailURL containsString:@"https://"]) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^(void) {
                NSURL *url = [NSURL URLWithString:thumbnailURL];
                NSData *data = [NSData dataWithContentsOfURL:url];
                UIImage *img = [UIImage imageWithData:data];
                if(img) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (cell.tag == indexPath.row) {
                            UIImage* rotatedImage;
//                            NSLog(@"receipt -> %@", receipt);
//                            NSLog(@"[receipt valueForKey:@exif] -> %@", [receipt valueForKey:@"exif"]);
                            if ([receipt valueForKey:@"exif"] == [NSString stringWithFormat:@"90"]) {
                                rotatedImage = [self imageRotatedByDegrees:img deg:90];
                            } else {
                                rotatedImage = img;
                            }
                            cell.imageView.image = rotatedImage;
                            [self.receiptImgCache setObject:rotatedImage forKey:thumbnailCacheKey];
                            [self.imagesArray addObject:rotatedImage];
                            [cell setNeedsLayout];
                        }
                    });
                }
            });
        } else {
//            cell.imageView.image = nil;
            UIImage* rotatedImage;
            if ([receipt valueForKey:@"exif"] == [NSString stringWithFormat:@"90"]) {
//                rotatedImage = [self imageRotatedByDegrees:[UIImage imageWithData:[receipt valueForKey:@"img"]] deg:90];
                rotatedImage = [UIImage imageWithData:[receipt valueForKey:@"img"]];
            } else {
                rotatedImage = [UIImage imageWithData:[receipt valueForKey:@"img"]];
            }
            cell.imageView.image = rotatedImage;
            [self.receiptImgCache setObject:rotatedImage forKey:thumbnailCacheKey];
            [self.imagesArray addObject:rotatedImage];
            [cell setNeedsLayout];
        }
    } else {
        cell.imageView.image = (UIImage*) [self.receiptImgCache objectForKey:thumbnailCacheKey];
    }
//    cell.imageView.image = [self.imagesArray objectAtIndex:indexPath.row];
    
    if (indexPath == self.snapshotIndexPath || indexPath == selectedCellPath) {
        cell.contentView.alpha = 1;
    }
//    NSLog(@"CellForItemAtIndexPath= %@", cell);
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGRect screenRect = [[UIScreen mainScreen] bounds]; //cell    ArrangeCollectionViewCell *    0x7fd891c18c30    0x00007fd891c18c30
    CGFloat screenWidth = screenRect.size.width;
    //    CGFloat screenHeight = screenRect.size.height;
//    ArrangeCollectionViewCell *cell = [self collectionView:collectionView cellForItemAtIndexPath:indexPath];
//    if (cell.hideFlag) {
//    if (indexPath == selectedCellPath) {
//        return CGSizeZero;
//    }
    CGFloat totalInteritemSpacing = (1 * self.collectionViewFlowLayout.minimumInteritemSpacing);
    CGFloat totalSectionInset = self.collectionViewFlowLayout.sectionInset.left + self.collectionViewFlowLayout.sectionInset.right;
//    CGFloat size = (self.collectionView.bounds.size.width - (totalSectionInset + totalInteritemSpacing)) / 2;
    CGFloat size = (screenWidth - (totalSectionInset + totalInteritemSpacing)) / 2;
    
//    return CGSizeMake(screenWidth/2, screenWidth/2);
    return CGSizeMake(size, size);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
