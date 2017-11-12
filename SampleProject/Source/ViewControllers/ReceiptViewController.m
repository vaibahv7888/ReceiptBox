//
//  ReceiptViewController.m
//  SampleProject
//
//  Created by Vaibhav Bangde on 9/5/17.
//  Copyright © 2017 Gorilla Expense. All rights reserved.
//

#import "ReceiptViewController.h"

@interface ReceiptViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSString* receiptPath;

@end

@implementation ReceiptViewController

TServiceWrapper* m_ServiceWrapper;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    m_ServiceWrapper = [[TServiceWrapper alloc] init];
    [m_ServiceWrapper setDelegate:self];
    [self loadReceiptImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadReceiptImage {
    self.receiptPath = [self.receipt valueForKey:@"receiptPath"];
    self.imageView.image = [UIImage imageWithData:[self.receipt valueForKey:@"thumbnailImage"]];
        
    if ([self.receiptPath containsString:@".pdf"]) {
        [self showPDFforPath:self.receiptPath];
    } else {
        [self showImage];
    }
}

- (void) showPDFforPath:(NSString*) filePath {
    UIWebView* yourWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //    NSString*  filePath= [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"pdf"]];
    /// or you can even read docs file as : pathForResource:@"sample" ofType:@"docx"]
    NSLog(@"filePath= %@", filePath);
//    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURL *url = [NSURL URLWithString:filePath];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [yourWebView setUserInteractionEnabled:YES];
    [yourWebView setDelegate:self];
    yourWebView.scalesPageToFit = YES;
    [yourWebView loadRequest:requestObj];
    [self.view addSubview:yourWebView];
}

- (IBAction)onDeleteButtonClicked:(id)sender {
    
    NSNumber* receiptBoxId = [NSNumber numberWithInt:[[self.receipt valueForKey:@"receiptBoxID"] intValue]];
    NSLog(@"DELETING -> receiptBoxId= %@", receiptBoxId);
    
    [m_ServiceWrapper removeReceiptFromBox:[NSNumber numberWithInt:69] ReceiptId:receiptBoxId];
    
//    self.navigationController.navigationBar.hidden = NO;
//    [self.navigationController popViewControllerAnimated:YES];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
}

- (void) removeReceiptDoneWithStatus:(NSMutableDictionary*)deleteReceiptInfo {
    if([deleteReceiptInfo isKindOfClass:[NSError class]] || [deleteReceiptInfo isKindOfClass:[SoapFault class]]) {
        
    } else {
        [self.managedObjectContext deleteObject:self.receipt];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)removeReceiptDoneWithInfo:(NSString*)deleteStatus {
    if([deleteStatus isKindOfClass:[NSError class]] || [deleteStatus isKindOfClass:[SoapFault class]]) {
        NSLog(@"ERROR While DELETING -> %@", deleteStatus);
    } else {
        [self.managedObjectContext deleteObject:self.receipt];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) showImage {
    if ([self.receipt valueForKey:@"img"] != NULL) {
        if ([[self.receipt valueForKey:@"exif"] isEqualToString:@"90"]) {
            self.imageView.image = [self imageRotatedByDegrees:[UIImage imageWithData:[self.receipt valueForKey:@"img"]] deg:90];
        } else {
            self.imageView.image = [UIImage imageWithData:[self.receipt valueForKey:@"img"]];
        }
    } else {
        if ([self.receiptPath containsString:@"https://"]) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^(void) {
                NSURL *url = [NSURL URLWithString:self.receiptPath];
                NSData *data = [NSData dataWithContentsOfURL:url];
                UIImage *img = [UIImage imageWithData:data];
                if(img) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if ([self.receipt valueForKey:@"exif"] == [NSString stringWithFormat:@"90"]) {
                            self.imageView.image = [self imageRotatedByDegrees:img deg:90];
//                            [self updateDBReceiptsFor:[NSString stringWithFormat:@"%@",[self.receipt valueForKey:@"receiptBoxID"]] withValue:@"0" forKey:@"exif"];
                        } else {
                            self.imageView.image = img;
                        }
                        [self updateDBReceiptsFor:[NSString stringWithFormat:@"%@",[self.receipt valueForKey:@"receiptBoxID"]] withValue:UIImagePNGRepresentation(img) forKey:@"img"];
                    });
                }
            });
        }
    }
}

- (void) updateDBReceiptsFor:(NSString*) receiptId withValue:(id) value forKey:(NSString*) key {
    NSPredicate *p = [NSPredicate predicateWithFormat:@"receiptBoxID = %@", receiptId];
    NSError *error = nil;
    //    NSLog(@"p= %@", p);
    NSArray *dbarray = [self dbArrayWithPredicade:p];
    
    if (dbarray.count > 0) {
        [[dbarray objectAtIndex:0] setValue:value forKey:key];
    }
    
    // Save the object to persistent store
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

- (NSArray*) dbArrayWithPredicade:(NSPredicate*) predicate {
    NSFetchRequest * fetctRequest = [NSFetchRequest fetchRequestWithEntityName:@"ReceiptBox"];
    [fetctRequest setIncludesPropertyValues:NO];
    [fetctRequest setPredicate:predicate];
    NSError *error = nil;
    NSArray *dbarray = [self.managedObjectContext executeFetchRequest:fetctRequest error:&error];
    
    return dbarray;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
