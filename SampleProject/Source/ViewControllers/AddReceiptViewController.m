//
//  AddReceiptViewController.m
//  SampleProject
//
//  Created by Vaibhav Bangde on 9/3/17.
//  Copyright © 2017 Gorilla Expense. All rights reserved.
//

#import "AddReceiptViewController.h"
//#import "CGImageSourceRef.h"
#import <ImageIO/CGImageProperties.h>
#import <ImageIO/CGImageSource.h>
#import "SoapReachability.h"

//#define Username @"qc1admin@gorillaexpense.com"
//#define Username @"qcemployee1.gorilla@gmail.com"
#define Username @"qcmanager1.gorilla@gmail.com"

@interface AddReceiptViewController ()

@property (strong, nonatomic) NSString *receiptPath;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)takePhotoClicked:(id)sender;
- (IBAction)selectPhotoClicked:(id)sender;

@end

@implementation AddReceiptViewController

NSNumber *userID = 0;
UIActivityIndicatorView* activityIndicator;
bool isPhotoTaken = false;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        [myAlertView show];
    }
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [self takePhotoClicked:self];
    
//    NSLog(@"Is Connected to Network= %@", [SoapReachability connectedToNetwork]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)takePhotoClicked:(id)sender {
    isPhotoTaken = true;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
//    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    picker.cameraOverlayView = self.view;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)selectPhotoClicked:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
//    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    NSData *imageData = UIImageJPEGRepresentation(chosenImage, 0);
    
//    [self saveReceipt:imageData];
    [self uploadReceipt:imageData];
    
//    [self getExifDataFromImage:chosenImage];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)saveReceipt:(NSDictionary*)receipt {
    NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 0);

    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"ReceiptBox" inManagedObjectContext:context];
    NSNumber* receiptBoxId = [NSNumber numberWithInteger:[[receipt valueForKey:@"ReceiptBoxId"] integerValue]];
    NSLog(@"receiptBoxId -> %@", receiptBoxId);
    [newDevice setValue:receiptBoxId forKey:@"receiptBoxID"];
    [newDevice setValue:[NSNumber numberWithInteger:[[receipt valueForKey:@"UserId"] integerValue]] forKey:@"userID"];
    [newDevice setValue:[receipt valueForKey:@"ReceiptPath"] forKey:@"receiptPath"];
    [newDevice setValue:[NSNumber numberWithInteger:[[receipt valueForKey:@"Amount"] integerValue]] forKey:@"amount"];
    [newDevice setValue:[receipt valueForKey:@"City"] forKey:@"city"];
    [newDevice setValue:[receipt valueForKey:@"EXIF"] forKey:@"exif"];
    [newDevice setValue:[receipt valueForKey:@"ExpenseCategory"] forKey:@"expenseCategory"];
    [newDevice setValue:[NSNumber numberWithInteger:[[receipt valueForKey:@"ExpenseDetailId"] integerValue]] forKey:@"expenseDetailId"];
//    NSLog(@"[[receipt valueForKey:@IsAttached] stringValue]= %@", [receipt valueForKey:@"IsAttached"]);
    if ([receipt valueForKey:@"IsAttached"] == [NSString stringWithFormat:@""]) {
        [newDevice setValue:[NSNumber numberWithBool:NO] forKey:@"isAttached"];
    } else {
        [newDevice setValue:[NSNumber numberWithBool:[receipt valueForKey:@"IsAttached"]] forKey:@"isAttached"];
    }
    
    [newDevice setValue:[receipt valueForKey:@"MobileThumbnailReceiptPath"] forKey:@"mobileThumbnailReceiptPath"];
    [newDevice setValue:[NSNumber numberWithInteger:[[receipt valueForKey:@"ReceiptScanId"] integerValue]] forKey:@"receiptScanId"];
    [newDevice setValue:[receipt valueForKey:@"ReceiptType"] forKey:@"receiptType"];
    [newDevice setValue:[receipt valueForKey:@"ScanningStatus"] forKey:@"scanningStatus"];
    [newDevice setValue:[receipt valueForKey:@"Source"] forKey:@"source"];
    NSString* transactionDate = [receipt valueForKey:@"TransactionDate"];
    NSLog(@"transactionDate= %@",transactionDate);
    NSDate* date = [NSDate date];
    //    NSDate* date = [receipt valueForKey:@"TransactionDate"];
    [newDevice setValue:date forKey:@"transactionDate"];
    
    [newDevice setValue:[NSNumber numberWithInt:0] forKey:@"receiptState"];
    
    [newDevice setValue:[NSNumber numberWithInteger:[[receipt valueForKey:@"VAT1"] floatValue]] forKey:@"vat1"];
    [newDevice setValue:[NSNumber numberWithInteger:[[receipt valueForKey:@"VAT2"] floatValue]] forKey:@"vat2"];
    [newDevice setValue:[NSNumber numberWithInteger:[[receipt valueForKey:@"VAT3"] floatValue]] forKey:@"vat3"];
    [newDevice setValue:[NSNumber numberWithInteger:[[receipt valueForKey:@"VAT4"] floatValue]] forKey:@"vat4"];
    [newDevice setValue:[receipt valueForKey:@"Vendor"] forKey:@"vendor"];
    [newDevice setValue:[receipt valueForKey:@"WebThumbnailReceiptPath"] forKey:@"webThumbnailReceiptPath"];
    
    if ([receipt valueForKey:@"EXIF"] == [NSString stringWithFormat:@"90"]) {
        UIImage* img = [self imageRotatedByDegrees:[UIImage imageWithData:imageData] deg:90];
        [newDevice setValue:UIImagePNGRepresentation(img) forKey:@"img"];
    } else {
        [newDevice setValue:imageData forKey:@"img"];
    }
    [newDevice setValue:[NSNumber numberWithBool:YES] forKey:@"isSynced"];
    
//    NSLog(@"newDevice= %@", newDevice);
    
//    int value = [[self getCurrentUserId] intValue];
//    userID = [NSNumber numberWithInt:value+1];
//
//    [self saveCurrentUserId:userID];
//    [newDevice setValue:userID forKey:@"userID"];
//    [newDevice setValue:userID forKey:@"receiptBoxID"];
//    [newDevice setValue:imageData forKey:@"img"];
//    [newDevice setValue:[NSNumber numberWithBool:YES] forKey:@"isSynced"];
//
//    if(self.receiptPath != nil && ![self.receiptPath isEqualToString:@""]) {
//        [newDevice setValue:self.receiptPath forKey:@"receiptPath"];
//    }
    
//    [newDevice setValue:self.nameTextField.text forKey:@"name"];
//    [newDevice setValue:self.versionTextField.text forKey:@"version"];
//    [newDevice setValue:self.companyTextField.text forKey:@"company"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
//    [self dismissViewControllerAnimated:YES completion:nil];
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

- (void) saveUnSyncReceipt {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"ReceiptBox" inManagedObjectContext:context];
    
    NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 0);
    [newDevice setValue:imageData forKey:@"img"];
    [newDevice setValue:[NSNumber numberWithBool:NO] forKey:@"isSynced"];
    [newDevice setValue:[NSNumber numberWithInt:1] forKey:@"receiptState"];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

- (void)uploadReceipt:(NSData*)imageData {
    TServiceWrapper  *mServiceWrapper = [[TServiceWrapper alloc] init];
    [mServiceWrapper setDelegate:self];
    [mServiceWrapper uploadReceipt:imageData inUploadFolder:Username fileFormat:@"jpg"];
//    [self.navigationController popToRootViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:activityIndicator];
    activityIndicator.center = self.view.center;
    [activityIndicator startAnimating];
}

-(void)uploadFileDoneWithStatus:(NSDictionary *)responseStatusDetails
{
    NSLog(@"%@", responseStatusDetails);
    if ([responseStatusDetails objectForKey:@"IsFileUploadDone"]) {
        self.receiptPath = [responseStatusDetails objectForKey:@"ReceiptPath"];
//        NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 0);
//        [self saveReceipt:imageData];
    }
}

-(void)uploadReceiptDoneWithInfo:(NSMutableArray*)uploadReceiptInfo {
    NSLog(@"uploadReceiptDoneWithInfo= %@", uploadReceiptInfo);
    if([uploadReceiptInfo isKindOfClass:[NSError class]] || [uploadReceiptInfo isKindOfClass:[SoapFault class]]) {
        if (isPhotoTaken) {
            isPhotoTaken = false;
            [self saveUnSyncReceipt];
        }
    } else {
        NSDictionary* uploadedReceiptInfo = (NSDictionary*)[uploadReceiptInfo objectAtIndex:0];
        NSLog(@"uploadedReceiptInfo= %@", uploadedReceiptInfo);
        [self saveReceipt:uploadedReceiptInfo];
    }
    [activityIndicator stopAnimating];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(NSNumber*)getCurrentUserId {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSNumber *currentUserId = [userDefaults valueForKey:@"CurrentReciptId"];
    
    return currentUserId;
}

-(void) saveCurrentUserId:(NSNumber*) currentUserId {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setInteger:currentUserId.intValue forKey:@"CurrentReciptId"];
    
}

-(NSManagedObjectContext*)managedObjectContext {
    NSManagedObjectContext *context = nil;
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    //    if ([delegate performSelector:@selector(managedObjectContext)]) {
    //        context = [delegate managedObjectContext];
    //    }
    if ([delegate respondsToSelector:@selector(persistentContainer)]) {
        context = delegate.persistentContainer.viewContext;
    }
    return context;
}

-(void)getExifDataFromImage:(UIImage *)currentImage
{
    
    NSData* pngData =  UIImageJPEGRepresentation(currentImage, 1.0);
    
    CGImageSourceRef mySourceRef = CGImageSourceCreateWithData((CFDataRef)pngData, NULL);
    
    //CGImageSourceRef mySourceRef = CGImageSourceCreateWithURL((__bridge CFURLRef)myURL, NULL);
    if (mySourceRef != NULL)
    {
        NSDictionary *myMetadata = (__bridge NSDictionary *)CGImageSourceCopyPropertiesAtIndex(mySourceRef,0,NULL);
        NSDictionary *exifDic = [myMetadata objectForKey:(NSString *)kCGImagePropertyExifDictionary];
        NSDictionary *tiffDic = [myMetadata objectForKey:(NSString *)kCGImagePropertyTIFFDictionary];
        NSLog(@"exifDic properties: %@", myMetadata); //all data
//        float rawShutterSpeed = [[exifDic objectForKey:(NSString *)kCGImagePropertyExifExposureTime] floatValue];
//        int decShutterSpeed = (1 / rawShutterSpeed);
//        NSLog(@"Camera %@",[tiffDic objectForKey:(NSString *)kCGImagePropertyTIFFModel]);
//        NSLog(@"Focal Length %@mm",[exifDic objectForKey:(NSString *)kCGImagePropertyExifFocalLength]);
//        NSLog(@"Shutter Speed %@", [NSString stringWithFormat:@"1/%d", decShutterSpeed]);
//        NSLog(@"Aperture f/%@",[exifDic objectForKey:(NSString *)kCGImagePropertyExifFNumber]);
        
        
        NSNumber *ExifISOSpeed  = [[exifDic objectForKey:(NSString*)kCGImagePropertyExifISOSpeedRatings] objectAtIndex:0];
        NSLog(@"ISO %ld",[ExifISOSpeed integerValue]);
        NSLog(@"Taken %@",[exifDic objectForKey:(NSString*)kCGImagePropertyExifDateTimeDigitized]);
        
    }
    
}

//Reachability *reachabilityInfo;
//[[NSNotificationCenter defaultCenter] addObserver:self
//                                         selector:@selector(myReachabilityDidChangedMethod)
//                                             name:kReachabilityChangedNotification
//                                           object:reachabilityInfo];

-(void)myReachabilityDidChangedMethod:(SCNetworkReachabilityFlags)flags {
    
}

@end
