//
//  ViewController.m
//  SampleProject
//
//  Created by Gorilla Expense on 8/25/17.
//  Copyright © 2017 Gorilla Expense. All rights reserved.
//

#import "ViewController.h"
#import "RBCollectionViewCell.h"
#import "SoapReachability.h"
//#import "BEMCheckBox.h"
//#import "SampleProject-swift.h"

#define BASE_URL @"https://www.gorillaexpense.net/GorillaPro/Mobile/Service_Mobile.svc?wsdl"
//#define Username @"qc1admin@gorillaexpense.com"
//#define Username @"qcemployee1.gorilla@gmail.com"
#define Username @"qcmanager1.gorilla@gmail.com"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *receiptBoxCollectionView;

@property (weak, nonatomic) IBOutlet UIButton *plusButton;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (weak, nonatomic) IBOutlet UIButton *createPDFButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *selectButton;

@property (nonatomic, strong) NSArray *imagesArray;

@property (nonatomic, strong) NSMutableArray* receiptsArray;

@property (nonatomic, strong) NSMutableArray* selectedItems;

@property (nonatomic, strong) NSMutableArray* receiptMutableArray;

@property (nonatomic, strong) NSDictionary* receiptDictionary;

@property (nonatomic, strong) NSMutableDictionary* thumbnailsCache;

@property (nonatomic) NSInteger selectedSegmentIndex;

@end

@implementation ViewController

typedef enum playerStateTypes
{
    NONE,
    DELETE,
    CREATE_PDF
} SelectItemMode;
SelectItemMode selectMode;

//typedef enum receiptState {
//    SYNCED,
//    ADD,
//    REMOVE
//}ReceiptState;
//ReceiptState receiptState;

NSInteger selectedReciptIndex;
bool isSelectMode = false;
TServiceWrapper  *mServiceWrapper;
NSMutableArray* _deltaReceiptImagesArray;
UIActivityIndicatorView* _activityIndicator;

- (void)viewDidLoad {
    [super viewDidLoad];
    selectMode = NONE;
//    self.imagesArray = @[@"pic_0.jpg", @"pic_1.jpg", @"pic_2.jpg", @"pic_3.jpg", @"pic_4.jpg", @"pic_5.jpg"];
    
    [[NSUserDefaults standardUserDefaults] setValue:BASE_URL forKey:@"BASE_URL"];
    
    mServiceWrapper = [[TServiceWrapper alloc] init];
    [mServiceWrapper setDelegate:self];
    [mServiceWrapper getPendingList:[NSNumber numberWithInt:69]];
    
    self.receiptBoxCollectionView.allowsMultipleSelection = YES;
    
//    [self updateReceiptArray];
    self.receiptsArray = [[NSMutableArray alloc] init];
    self.receiptMutableArray = [[NSMutableArray alloc] init];
    self.thumbnailsCache = [[NSMutableDictionary alloc] init];
    
    _deltaReceiptImagesArray = [[NSMutableArray alloc] init];
    
    [self.receiptBoxCollectionView reloadData];
    self.deleteButton.hidden = YES;
    self.selectedItems = [[NSMutableArray alloc] init];
    self.receiptDictionary = [[NSDictionary alloc] init];
    if (isSelectMode) {
        [self selectButtonClicked:self];
    }
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:_activityIndicator];
    _activityIndicator.center = CGPointMake(160, 240);
    [_activityIndicator startAnimating];
}

- (void)viewWillAppear:(BOOL)animated {    // Called when the view is about to made visible. Default does nothing
    if (isSelectMode) {
        [self selectButtonClicked:self];
    }
    [mServiceWrapper getPendingList:[NSNumber numberWithInt:69]];
    [self updateReceiptArray];
    [self.receiptBoxCollectionView reloadData];
}

-(void)pendingListDoneWithStatus:(NSMutableArray *) pendingList {
    NSLog(@"pendingList= %@", pendingList);
    if([pendingList isKindOfClass:[NSError class]]) {
        return;
    }
    self.receiptMutableArray = pendingList;
    [self.receiptBoxCollectionView reloadData];
//    [self syncLocalDBWithServer];
    [self syncDBWithServer];
}

- (void) syncDBWithServer {
    [self checkUploadReceipts];
    [self checkRemoveReceipt];
    [self addServerReceipts];
    [self updateReceiptArray];
    [self.receiptBoxCollectionView reloadData];
    [_activityIndicator stopAnimating];
}

- (void) checkUploadReceipts {
//    NSLog(@"receiptsArray -> %@", self.receiptsArray);
//    NSLog(@"receiptMutableArray -> %@", self.receiptMutableArray);
    NSPredicate *p = [NSPredicate predicateWithFormat:@"receiptState = %@", [NSString stringWithFormat:@"1"]];
    NSError *error = nil;
    NSLog(@"p= %@", p);
    NSArray *dbarray = [self dbArrayWithPredicade:p];
    
    TServiceWrapper  *mServiceWrapper = [[TServiceWrapper alloc] init];
    [mServiceWrapper setDelegate:self];
    AppDelegate* delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    for (NSManagedObject* r in dbarray) {
//        [imagesArray addObject:[r valueForKey:@"img"]];
        [mServiceWrapper uploadReceipt:[r valueForKey:@"img"] inUploadFolder:Username fileFormat:@"jpg"];
        [_deltaReceiptImagesArray addObject:[r valueForKey:@"img"]];
        [context deleteObject:r];
    }
    
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }

//    [self uploadUnsyncedReceipts:[NSMutableArray arrayWithArray:dbarray]];
}

- (void) checkRemoveReceipt {
    NSPredicate *p = [NSPredicate predicateWithFormat:@"receiptState = %@", [NSString stringWithFormat:@"2"]];
//    NSArray *matchedDicts = [self.receiptsArray filteredArrayUsingPredicate:p];
//    [self removeFromLocalDBReceipts:[NSMutableArray arrayWithArray:matchedDicts]];
    NSArray *dbarray = [self dbArrayWithPredicade:p];
    
    TServiceWrapper  *mServiceWrapper = [[TServiceWrapper alloc] init];
    [mServiceWrapper setDelegate:self];
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    for (NSManagedObject* r in dbarray) {
        NSNumber* receiptBoxId = [NSNumber numberWithInt:[[r valueForKey:@"receiptBoxID"] intValue]];
        [mServiceWrapper removeReceiptFromBox:[NSNumber numberWithInt:69] ReceiptId:receiptBoxId];
//        NSPredicate *p = [NSPredicate predicateWithFormat:@"receiptBoxID = %@", receiptBoxId];
        [context deleteObject:r];
    }
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

- (void) addServerReceipts {
    for (NSDictionary* webReceipt in self.receiptMutableArray) {
        NSString *receiptBoxId = (NSString*)[webReceipt valueForKey:@"ReceiptBoxId"];
        NSPredicate *p = [NSPredicate predicateWithFormat:@"receiptBoxID = %@", receiptBoxId];
        
        NSArray *matchedDicts = [self dbArrayWithPredicade:p];
        
        if(matchedDicts.count == 0) {
            [self saveReceipt:webReceipt];
        }
    }
}

- (void) syncLocalDBWithServer {
    
    NSMutableArray *deltaAddArray = [[NSMutableArray alloc] init];
    NSMutableArray *deltaRemoveArray = [[NSMutableArray alloc] init];

    for (NSManagedObject* receipt in self.receiptsArray) {
        if ([[receipt valueForKey:@"isSynced"] boolValue]) {
            NSLog(@"True");
        }
        NSString *receiptBoxId = [[receipt valueForKey:@"receiptBoxID"] stringValue];
        NSLog(@"receiptBoxId= %@",receiptBoxId);
        NSPredicate *p = [NSPredicate predicateWithFormat:@"ReceiptBoxId = %@", receiptBoxId];
        
        NSArray *matchedDicts = [self.receiptMutableArray filteredArrayUsingPredicate:p];
        
        if(matchedDicts.count == 0) {
            if([[receipt valueForKey:@"isSynced"] boolValue]) {
                [deltaRemoveArray addObject:receipt];
            } else {
                [deltaAddArray addObject:receipt];
            }
        }
//      NSLog(@"count= %lu", (unsigned long)matchedDicts.count);
    }
    
    for (NSDictionary* webReceipt in self.receiptMutableArray) {
        NSString *receiptBoxId = (NSString*)[webReceipt valueForKey:@"ReceiptBoxId"];
        NSPredicate *p = [NSPredicate predicateWithFormat:@"receiptBoxID = %@", receiptBoxId];

        NSArray *matchedDicts = [self dbArrayWithPredicade:p];
//        NSArray *matchedDicts = self.receiptsArray

        if(matchedDicts.count == 0) {
            [self saveReceipt:webReceipt];
        }
//      NSLog(@"count= %lu", (unsigned long)matchedDicts.count);
    }
    
    [self removeFromLocalDBReceipts:deltaRemoveArray];
    [self uploadUnsyncedReceipts:deltaAddArray];
    [self updateReceiptArray];
    [self.receiptBoxCollectionView reloadData];
}

- (void) removeFromLocalDBReceipts:(NSMutableArray*) receipts {
    if(receipts.count == 0) {
        return;
    }
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSLog(@"receipts -> %@", receipts);
    for (NSManagedObject *receipt in receipts) {
        [self.receiptsArray removeObject:receipt];
        [context deleteObject:receipt];
    }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

- (void) uploadUnsyncedReceipts:(NSMutableArray*) receipts {
    if(!(bool)[SoapReachability connectedToNetwork]){
        return;
    }
    NSLog(@"receipts= %@", receipts);
    TServiceWrapper  *mServiceWrapper = [[TServiceWrapper alloc] init];
    [mServiceWrapper setDelegate:self];
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    for (NSManagedObject* r in receipts) {
        [mServiceWrapper uploadReceipt:[r valueForKey:@"img"] inUploadFolder:Username fileFormat:@"jpg"];
        [_deltaReceiptImagesArray addObject:[r valueForKey:@"img"]];
        [self.receiptsArray removeObject:r];
        [context deleteObject:r];
    }
//    [self removeFromLocalDBReceipts:receipts];
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

-(void)uploadReceiptDoneWithInfo:(NSMutableArray*)uploadReceiptInfo {
//    NSLog(@"uploadReceiptDoneWithInfo= %@", uploadReceiptInfo);
    if([uploadReceiptInfo isKindOfClass:[NSError class]] || [uploadReceiptInfo isKindOfClass:[SoapFault class]]) {
        [self saveUnsyncReceiptsArray:_deltaReceiptImagesArray];
    } else {
        NSDictionary* uploadedReceiptInfo = (NSDictionary*)[uploadReceiptInfo objectAtIndex:0];
//        NSLog(@"uploadedReceiptInfo= %@", uploadedReceiptInfo);
        [self saveReceipt:uploadedReceiptInfo];
    }
    [self updateReceiptArray];
    [self.receiptBoxCollectionView reloadData];
}

-(void) saveUnsyncReceiptsArray:(NSMutableArray*)receipts {
    for (NSData* receiptImg in receipts) {
        [self saveUnSyncReceipt:receiptImg];
    }
    [_deltaReceiptImagesArray removeAllObjects];
}

- (void) saveUnSyncReceipt:(NSData*)receiptImg {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"ReceiptBox" inManagedObjectContext:context];

//    NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 0);
    [newDevice setValue:receiptImg forKey:@"img"];
    [newDevice setValue:[NSNumber numberWithBool:NO] forKey:@"isSynced"];
    [newDevice setValue:[NSNumber numberWithInt:1] forKey:@"receiptState"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

- (NSArray*) dbArrayWithPredicade:(NSPredicate*) predicate {
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ReceiptBox"];
    NSFetchRequest * fetctRequest = [NSFetchRequest fetchRequestWithEntityName:@"ReceiptBox"];
    [fetctRequest setIncludesPropertyValues:NO];
    [fetctRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *dbarray = [context executeFetchRequest:fetctRequest error:&error];
    
    return dbarray;
}

- (void) saveReceipt:(NSDictionary*) receipt {
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"ReceiptBox" inManagedObjectContext:context];
    NSNumber* receiptBoxId = [NSNumber numberWithInteger:[[receipt valueForKey:@"ReceiptBoxId"] integerValue]];
    [newDevice setValue:receiptBoxId forKey:@"receiptBoxID"];
    [newDevice setValue:[NSNumber numberWithInteger:[[receipt valueForKey:@"UserId"] integerValue]] forKey:@"userID"];
    [newDevice setValue:[receipt valueForKey:@"ReceiptPath"] forKey:@"receiptPath"];
    [newDevice setValue:[NSNumber numberWithInteger:[[receipt valueForKey:@"Amount"] integerValue]] forKey:@"amount"];
    [newDevice setValue:[receipt valueForKey:@"City"] forKey:@"city"];
    [newDevice setValue:[receipt valueForKey:@"EXIF"] forKey:@"exif"];
    [newDevice setValue:[receipt valueForKey:@"ExpenseCategory"] forKey:@"expenseCategory"];
    [newDevice setValue:[NSNumber numberWithInteger:[[receipt valueForKey:@"ExpenseDetailId"] integerValue]] forKey:@"expenseDetailId"];
    [newDevice setValue:[NSNumber numberWithBool:[[receipt valueForKey:@"IsAttached"] boolValue]] forKey:@"isAttached"];
//    NSLog(@"[receipt valueForKey:@IsAttached]= %@", [receipt valueForKey:@"IsAttached"]);
//    NSLog(@"[NSNumber numberWithBool:[receipt valueForKey:@IsAttached]]= %@", [NSNumber numberWithBool:[receipt valueForKey:@"IsAttached"]]);
    [newDevice setValue:[receipt valueForKey:@"MobileThumbnailReceiptPath"] forKey:@"mobileThumbnailReceiptPath"];
    [newDevice setValue:[NSNumber numberWithInteger:[[receipt valueForKey:@"ReceiptScanId"] integerValue]] forKey:@"receiptScanId"];
    [newDevice setValue:[receipt valueForKey:@"ReceiptType"] forKey:@"receiptType"];
    [newDevice setValue:[receipt valueForKey:@"ScanningStatus"] forKey:@"scanningStatus"];
    [newDevice setValue:[receipt valueForKey:@"Source"] forKey:@"source"];
    NSString* transactionDate = [receipt valueForKey:@"TransactionDate"];
//    NSLog(@"transactionDate= %@",transactionDate);
//    NSDate* date = [receipt valueForKey:@"TransactionDate"];
    NSDate* date = [NSDate date];
//    NSLog(@"date= %@",date);
    [newDevice setValue:date forKey:@"transactionDate"];
//    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
//    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    [newDevice setValue:[NSNumber numberWithInt:0] forKey:@"receiptState"];
    
    [newDevice setValue:[NSNumber numberWithInteger:[[receipt valueForKey:@"VAT1"] floatValue]] forKey:@"vat1"];
    [newDevice setValue:[NSNumber numberWithInteger:[[receipt valueForKey:@"VAT2"] floatValue]] forKey:@"vat2"];
    [newDevice setValue:[NSNumber numberWithInteger:[[receipt valueForKey:@"VAT3"] floatValue]] forKey:@"vat3"];
    [newDevice setValue:[NSNumber numberWithInteger:[[receipt valueForKey:@"VAT4"] floatValue]] forKey:@"vat4"];
    [newDevice setValue:[receipt valueForKey:@"Vendor"] forKey:@"vendor"];
    [newDevice setValue:[receipt valueForKey:@"WebThumbnailReceiptPath"] forKey:@"webThumbnailReceiptPath"];
//    NSLog(@"newDevice = %@", [newDevice valueForKey:@"mobileThumbnailReceiptPath"]);
//    [newDevice setValue:imageData forKey:@"img"];
    
//    if(self.receiptPath != nil && ![self.receiptPath isEqualToString:@""]) {
//        [newDevice setValue:self.receiptPath forKey:@"receiptPath"];
//    }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

- (void) saveThumbnailImg:(NSData*) img forReceiptId:(NSString*) receiptId {
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSPredicate *p = [NSPredicate predicateWithFormat:@"receiptBoxID = %@", receiptId];
    NSError *error = nil;
    NSLog(@"p= %@", p);
    NSArray *dbarray = [self dbArrayWithPredicade:p];
    
    if (dbarray.count > 0) {
        [[dbarray objectAtIndex:0] setValue:img forKey:@"thumbnailImage"];
    }
    
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

-(void)uploadFileDoneWithStatus:(NSDictionary *)responseStatusDetails
{
    NSLog(@"%@",responseStatusDetails);
    if(responseStatusDetails != NULL) {
//        self.receiptDictionary = responseStatusDetails;
        
//        NSMutableArray *menuItemsArray=[[NSMutableArray alloc] initWithArray:[[[[[[self.receiptDictionary valueForKey:@"xml"] valueForKey:@"Menu"] valueForKey:@"pair"] valueForKey:@"MenuCategory"] valueForKey:@"MenuItems"] valueForKey:@"menuItem"]];
        
//        self.receiptsArray = [[NSMutableArray alloc] initWithArray:[[[[[self.receiptDictionary valueForKey:@"s:Envelope"] valueForKey:@"s:Body"] valueForKey:@"GetPendingListResponse"] valueForKey:@"GetPendingListResult"] valueForKey:@"a:vw_Receiptbox"]];
        
//        NSLog(@"menu item array is %@",self.receiptsArray);
        
//        [self.receiptBoxCollectionView reloadData];
    }
    [_activityIndicator stopAnimating];
}

-(void)updateReceiptArray {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ReceiptBox"];
    self.receiptsArray = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    self.receiptsArray = [[[self.receiptsArray reverseObjectEnumerator] allObjects] mutableCopy];
//    NSLog(@"menu item array is %@",self.receiptsArray);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return self.imagesArray.count;
    NSInteger pendingCount = 0;
    NSInteger completedCount = 0;
    for (NSManagedObject* mo in self.receiptsArray) {
//        NSLog(@"[mo valueForKey:@isAttached]= %@", [mo valueForKey:@"isAttached"]);
        if ([[mo valueForKey:@"isAttached"] boolValue]) {
            completedCount++;
        } else {
            pendingCount++;
        }
    }
    if (self.selectedSegmentIndex == 0) {
        return pendingCount;
    } else {
        return completedCount;
    }
//    return self.receiptsArray.count;
//    return self.receiptDictionary.count;
//    return self.receiptMutableArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RBCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ReceiptCell" forIndexPath:indexPath];
    
    NSManagedObject *receipt = [self.receiptsArray objectAtIndex:indexPath.row];
//    NSInteger *userID = [receipt valueForKey:@"userID"];
    cell.receiptCostLable.text = [NSString stringWithFormat:@"Receipt_%@", [receipt valueForKey:@"receiptBoxID"]];
//    cell.receiptImageView.image = [UIImage imageWithData:[receipt valueForKey:@"img"]];
    cell.checkBox.hidden = !isSelectMode;
    cell.checkBox.tag = indexPath.row;
    cell.checkBox.delegate = self;

    cell.tag = indexPath.row;
    if (!isSelectMode) {
        [cell.checkBox setOn:false];
    }
    
    NSString *thumbnailCacheKey = [NSString stringWithFormat:@"cache_%ld", (long)indexPath.row];
    
//    NSLog(@"EXIF= %@", [receipt valueForKey:@"exif"]);

//    NSLog(@"indexPath.row= %ld",(long)indexPath.row);
    if ([receipt valueForKey:@"thumbnailImage"] != NULL) {
        cell.receiptImageView.image = [UIImage imageWithData:[receipt valueForKey:@"thumbnailImage"]];
    } else if (![[self.thumbnailsCache allKeys] containsObject:thumbnailCacheKey]) {
        NSString *thumbnailURL = [receipt valueForKey:@"MobileThumbnailReceiptPath"];
        if([thumbnailURL isEqualToString:@""]) {
            thumbnailURL = [receipt valueForKey:@"ReceiptPath"];
        }
        if ([thumbnailURL containsString:@"https://"]) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^(void) {
                NSURL *url = [NSURL URLWithString:thumbnailURL];
                NSData *data = [NSData dataWithContentsOfURL:url];
                UIImage *img = [UIImage imageWithData:data];
                if(img) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (cell.tag == indexPath.row) {
                            UIImage *rotatedImage;
                            if ([receipt valueForKey:@"exif"] == [NSString stringWithFormat:@"90"]) {
                                //Rotate it
                                rotatedImage = [self imageRotatedByDegrees:img deg:90];
                            } else {
                                rotatedImage = img;
                            }
                            cell.receiptImageView.image = rotatedImage;
//                            cell.receiptImageView.transform = CGAffineTransformMakeRotation(M_PI_2);
                            [self.thumbnailsCache setObject:rotatedImage forKey:thumbnailCacheKey];
                            [cell setNeedsLayout];
                            [self saveThumbnailImg:(UIImagePNGRepresentation(rotatedImage)) forReceiptId:[receipt valueForKey:@"receiptBoxID"]];
                        }
                    });
                }
            });
        } else {
            if ([receipt valueForKey:@"img"] != NULL) {
                cell.receiptImageView.image = [UIImage imageWithData:[receipt valueForKey:@"img"]];
            } else {
                cell.receiptImageView.image = nil;
            }
        }
    } else {
//        cell.receiptImageView.image = (UIImage*) [self.thumbnailsCache objectForKey:thumbnailCacheKey];
    }
    
//    NSLog(@"[receipt valueForKey:@receiptState]= %@", [receipt valueForKey:@"receiptState"]);
    if ([[receipt valueForKey:@"receiptState"] integerValue] == 1
        || [[receipt valueForKey:@"receiptState"] integerValue] == 2
        ) {
        cell.syncIcon.hidden = false;
    } else {
        cell.syncIcon.hidden = false;
    }
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
//    CGFloat screenHeight = screenRect.size.height;
    
    return CGSizeMake(screenWidth/2, (screenWidth/2)*8.0/6.0);
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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (isSelectMode) {
        RBCollectionViewCell *cell = [self.receiptBoxCollectionView cellForItemAtIndexPath:indexPath];
        [cell.checkBox setOn:!cell.checkBox.on];
        [self didTapCheckBox:cell.checkBox];
    } else {
        selectedReciptIndex = indexPath.row;
        [self performSegueWithIdentifier:@"ShowReceipt" sender:self];
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

- (void)didTapCheckBox:(BEMCheckBox*)checkBox {
    NSLog(@"CheckBox= %ld", (long)checkBox.tag);
    NSManagedObject *receipt = [self.receiptsArray objectAtIndex:checkBox.tag];
    if(checkBox.on) {
        [self.selectedItems addObject:receipt];
    } else {
        [self.selectedItems removeObject:receipt];
    }
    NSLog(@"receipt -> %@", receipt);
    if(isSelectMode) {
        if(self.selectedItems.count > 0) {
            self.deleteButton.enabled = YES;
        } else {
            self.deleteButton.enabled = NO;
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowReceipt"]) {
        ReceiptViewController *receiptVC = [segue destinationViewController];
        receiptVC.userID = selectedReciptIndex;// set your properties here
        NSManagedObject *receipt = [self.receiptsArray objectAtIndex:selectedReciptIndex];
        NSString* receiptPath = [receipt valueForKey:@"receiptPath"];
        receiptVC.receiptPath = receiptPath;
    } else if ([[segue identifier] isEqualToString:@"ArrangePDF"]) {
        ArrangeCollectionViewController *arrangeVC = [segue destinationViewController];
        arrangeVC.receiptIds = [[NSMutableArray alloc] init];
        if (arrangeVC.receiptsArray != NULL) {
            [arrangeVC.receiptsArray removeAllObjects];
            arrangeVC.receiptsArray = NULL;
        }
        arrangeVC.receiptsArray = [[NSMutableArray alloc] init];
        for (NSManagedObject* mo in self.selectedItems) {
//            NSNumber* receiptBoxId = [NSNumber numberWithInt:[[mo valueForKey:@"receiptBoxID"] intValue]];
            NSString* receipptPath = [mo valueForKey:@"receiptPath"];
            [arrangeVC.receiptIds addObject:receipptPath];
            [arrangeVC.receiptsArray addObject:mo];
        }
//        NSLog(@"arrangeVC.receiptsArray= %@", arrangeVC.receiptsArray);
    }
//    DetailViewController *detailVC = segue.destinationViewController;
//    NSIndexPath *selectedPath = [self.tableView indexPathForSelectedRow];
//    detailVC.movie = [self movieForIndexPath:selectedPath];
}

-(void)OnScanDocumentClicked {
    [self performSegueWithIdentifier:@"TakePhoto" sender:self];
}

- (void) onCreatePDFClicked {
    selectMode = CREATE_PDF;
    [self selectButtonClicked:self];
}

- (IBAction)plusButtonClicked:(id)sender {
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"My Title"
                                 message:@"Select you Choice"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* scanDocument = [UIAlertAction
                         actionWithTitle:@"Scan Document"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             //Do some thing here
                             [view dismissViewControllerAnimated:YES completion:nil];
                             [self OnScanDocumentClicked];
                         }];
    
    UIAlertAction* uploadPhotos = [UIAlertAction
                             actionWithTitle:@"Upload Photos"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    UIAlertAction* createPDF = [UIAlertAction
                                   actionWithTitle:@"Create PDF"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action)
                                   {
                                       [view dismissViewControllerAnimated:YES completion:nil];
                                       [self onCreatePDFClicked];
                                   }];
    
    UIAlertAction* cancel = [UIAlertAction
                                actionWithTitle:@"Cancel"
                                style:UIAlertActionStyleCancel
                                handler:^(UIAlertAction * action)
                                {
                                    [view dismissViewControllerAnimated:YES completion:nil];
                                    
                                }];
    
    [view addAction:scanDocument];
    [view addAction:uploadPhotos];
    [view addAction:createPDF];
    [view addAction:cancel];
    [self presentViewController:view animated:YES completion:nil];
}
- (IBAction)onCreatePDFClicked:(id)sender {
    [self performSegueWithIdentifier:@"ArrangePDF" sender:self];
}

- (void) setSelectModeButton {
    switch (selectMode) {
        case NONE:
            self.deleteButton.hidden = YES;
            self.createPDFButton.hidden = YES;
            self.plusButton.hidden = NO;
            self.selectButton.title = @"Select";
            break;
            case DELETE:
            self.createPDFButton.hidden = YES;
            self.deleteButton.hidden = NO;
            self.plusButton.hidden = YES;
            self.selectButton.title = @"Cancel";
            break;
            case CREATE_PDF:
            self.createPDFButton.hidden = NO;
            self.plusButton.hidden = YES;
            self.selectButton.title = @"Cancel";
            break;
        default:
            break;
    }
}

- (IBAction)selectButtonClicked:(id)sender {
    isSelectMode = !isSelectMode;
    
    if (!isSelectMode) {
        selectMode = NONE;
    } else {
        if (selectMode == NONE) {
            selectMode = DELETE;
        }
    }
    
    [self setSelectModeButton];
//    if(!isSelectMode) {
//        self.deleteButton.hidden = YES;
//        self.plusButton.hidden = NO;
//    } else {
//        self.deleteButton.hidden = NO;
//        self.plusButton.hidden = YES;
//    }
    
//    [self.selectedItems removeAllObjects];
    [self.receiptBoxCollectionView reloadData];
}

- (IBAction)onDeleteButtonClicked:(id)sender {
    if(self.selectedItems.count <= 0) {
        return;
    }
//    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
//    NSManagedObjectContext *context = [delegate managedObjectContext];

    for (NSManagedObject *receipt in self.selectedItems) {
//        [self.receiptsArray removeObject:receipt];
//        [context deleteObject:receipt];
        if ([[receipt valueForKey:@"receiptState"] integerValue] == [[NSNumber numberWithInt:1] integerValue]
            || [[receipt valueForKey:@"receiptState"] integerValue] == [[NSNumber numberWithInt:2] integerValue]
            ) {
            [self deleteLocalRecipt:receipt];
            [self.receiptBoxCollectionView reloadData];
            continue;
        }
        NSNumber* receiptBoxId = [NSNumber numberWithInt:[[receipt valueForKey:@"receiptBoxID"] intValue]];
        NSLog(@"receiptBoxId= %@", receiptBoxId);
        [mServiceWrapper removeReceiptFromBox:[NSNumber numberWithInt:69] ReceiptId:receiptBoxId];
    }
    
//    NSError *error = nil;
//    // Save the object to persistent store
//    if (![context save:&error]) {
//        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
//    }
    
//    isSelectMode = NO;
//    [self.selectedItems removeAllObjects];
//    [self.receiptBoxCollectionView reloadData];
    [self selectButtonClicked:self];
}

- (void) deleteLocalRecipt:(NSManagedObject*)receipt {
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    [context deleteObject:receipt];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }

}

- (void) removeReceiptDoneWithStatus:(NSMutableDictionary*)deleteReceiptInfo {
    NSLog(@"deleteReceiptInfo= %@", deleteReceiptInfo);
    NSArray *keys = [deleteReceiptInfo allKeys];
    id aKey = [keys objectAtIndex:0];
    NSLog(@"[deleteReceiptInfo objectForKey:aKey]= %@", [deleteReceiptInfo objectForKey:aKey]);
//    NSDictionary* deletedReceipt = [deleteReceiptInfo objectForKey:aKey];
    if([deleteReceiptInfo isKindOfClass:[NSError class]]
       || [deleteReceiptInfo isKindOfClass:[SoapFault class]]
       || ![[deleteReceiptInfo objectForKey:aKey] boolValue]
       ) {
        for (NSManagedObject *receipt in self.selectedItems) {
//            [receipt setValue:[NSNumber numberWithInt:2] forKey:@"receiptState"];
            NSLog(@"receipt -> %@", receipt);
            [self updateDeletedReceiptsforId:[[receipt valueForKey:@"receiptBoxID"] stringValue]];
        }
    } else {
        AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [delegate managedObjectContext];
        for (NSManagedObject *receipt in self.selectedItems) {
            [self.receiptsArray removeObject:receipt];
            [context deleteObject:receipt];
        }
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }
//    [self selectButtonClicked:self];
    [self.selectedItems removeAllObjects];
    [self.receiptBoxCollectionView reloadData];
}

- (void) updateDeletedReceiptsforId:(NSString*) receiptId {
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSPredicate *p = [NSPredicate predicateWithFormat:@"receiptBoxID = %@", receiptId];
    NSError *error = nil;
    NSLog(@"p= %@", p);
    NSArray *dbarray = [self dbArrayWithPredicade:p];
    
    if (dbarray.count > 0) {
        [[dbarray objectAtIndex:0] setValue:[NSNumber numberWithInt:2] forKey:@"receiptState"];
    }
    
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}


- (IBAction)segmentAction:(id)sender {
    UISegmentedControl *segControll = (UISegmentedControl *)sender;
    
    NSLog(@"segControll.selectedSegmentIndex= %ld", (long)segControll.selectedSegmentIndex);
    self.selectedSegmentIndex = segControll.selectedSegmentIndex;
    
    [self.receiptBoxCollectionView reloadData];
}

-(NSManagedObjectContext*)managedObjectContext {
    NSManagedObjectContext *context = nil;
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate respondsToSelector:@selector(persistentContainer)]) {
        context = delegate.persistentContainer.viewContext;
    }
    return context;
}

@end

























