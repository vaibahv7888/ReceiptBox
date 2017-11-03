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
//    if(self.userID != NULL)
    {
//        self.navigationController.navigationBar.hidden = YES;
//        self.automaticallyAdjustsScrollViewInsets = NO;
        AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [delegate managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ReceiptBox"];
        NSMutableArray *receiptArray = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
        receiptArray = [[[receiptArray reverseObjectEnumerator] allObjects] mutableCopy];
        self.receipt = [receiptArray objectAtIndex:self.userID];
        
        self.imageView.image = [UIImage imageWithData:[self.receipt valueForKey:@"thumbnailImage"]];
        
        if ([self.receiptPath containsString:@".pdf"]) {
            [self showPDFforPath:self.receiptPath];
        } else {
            [self loadImage];
        }
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) removeReceiptDoneWithStatus:(NSMutableDictionary*)deleteReceiptInfo {
    if([deleteReceiptInfo isKindOfClass:[NSError class]] || [deleteReceiptInfo isKindOfClass:[SoapFault class]]) {
        
    } else {
        AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = [delegate managedObjectContext];
        
        [context deleteObject:self.receipt];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }
}

- (void) loadImage {
    if ([self.receipt valueForKey:@"img"] != NULL) {
        self.imageView.image = [UIImage imageWithData:[self.receipt valueForKey:@"img"]];
    } else if ([self.receiptPath containsString:@"https://"]) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^(void) {
            NSURL *url = [NSURL URLWithString:self.receiptPath];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *img = [UIImage imageWithData:data];
            if(img) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([self.receipt valueForKey:@"exif"] == [NSString stringWithFormat:@"90"]) {
                        self.imageView.image = [self imageRotatedByDegrees:img deg:90];
                    } else {
                        self.imageView.image = img;
                    }
                    [self saveThumbnailImg:UIImagePNGRepresentation(self.imageView.image) forReceiptId:[self.receipt valueForKey:@"receiptBoxID"]];
                });
            }
        });
    }
}

- (void) saveThumbnailImg:(NSData*) img forReceiptId:(NSString*) receiptId {
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSPredicate *p = [NSPredicate predicateWithFormat:@"receiptBoxID = %@", receiptId];
    NSError *error = nil;
    NSLog(@"p= %@", p);
//    NSArray *dbarray = [self dbArrayWithPredicade:p];
    
    NSFetchRequest * fetctRequest = [NSFetchRequest fetchRequestWithEntityName:@"ReceiptBox"];
    [fetctRequest setIncludesPropertyValues:NO];
    [fetctRequest setPredicate:p];
//    NSError *error = nil;
    NSArray *dbarray = [context executeFetchRequest:fetctRequest error:&error];
    
    if (dbarray.count > 0) {
        [[dbarray objectAtIndex:0] setValue:img forKey:@"img"];
    }
    
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
