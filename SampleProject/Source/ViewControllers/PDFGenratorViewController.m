//
//  PDFGenratorViewController.m
//  SampleProject
//
//  Created by Vaibhav Bangde on 10/5/17.
//  Copyright © 2017 Gorilla Expense. All rights reserved.
//

#import "PDFGenratorViewController.h"

#define Username @"qcmanager1.gorilla@gmail.com"

@interface PDFGenratorViewController ()
{
    NSString* pdfFileName;
    UIActivityIndicatorView* activityIndicator;
    bool isPhotoTaken;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
- (void) generatePdfWithFilePath: (NSString *)thefilePath;
- (void) drawPageNumber:(NSInteger)pageNum;
- (void) drawBorder;
- (void) drawText;
- (void) drawLine;
- (void) drawHeader;
- (void) drawImage;
@end

@implementation PDFGenratorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isPhotoTaken = false;
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self createPDF];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.saveButton.enabled = NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Private Methods
- (void) drawBorder
{
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    UIColor *borderColor = [UIColor brownColor];
    
    CGRect rectFrame = CGRectMake(kBorderInset, kBorderInset, pageSize.width-kBorderInset*2, pageSize.height-kBorderInset*2);
    
    CGContextSetStrokeColorWithColor(currentContext, borderColor.CGColor);
    CGContextSetLineWidth(currentContext, kBorderWidth);
    CGContextStrokeRect(currentContext, rectFrame);
}

- (void)drawPageNumber:(NSInteger)pageNumber
{
    NSString* pageNumberString = [NSString stringWithFormat:@"Page %ld", (long)pageNumber];
    UIFont* theFont = [UIFont systemFontOfSize:12];
    
    CGSize pageNumberStringSize = [pageNumberString sizeWithFont:theFont
                                               constrainedToSize:pageSize
                                                   lineBreakMode:UILineBreakModeWordWrap];
    
    CGRect stringRenderingRect = CGRectMake(kBorderInset,
                                            pageSize.height - 17.0,
                                            pageSize.width - 2*kBorderInset,
                                            pageNumberStringSize.height);
    
    [pageNumberString drawInRect:stringRenderingRect withFont:theFont lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentCenter];
}

- (void) drawHeader
{
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(currentContext, 0.3, 0.7, 0.2, 1.0);
    
    NSString *textToDraw = @"Pdf Demo - iOSLearner.com";
    
    UIFont *font = [UIFont systemFontOfSize:24.0];
    
    CGSize stringSize = [textToDraw sizeWithFont:font constrainedToSize:CGSizeMake(pageSize.width - 2*kBorderInset-2*kMarginInset, pageSize.height - 2*kBorderInset - 2*kMarginInset) lineBreakMode:UILineBreakModeWordWrap];
    
    CGRect renderingRect = CGRectMake(kBorderInset + kMarginInset, kBorderInset + kMarginInset, pageSize.width - 2*kBorderInset - 2*kMarginInset, stringSize.height);
    
    [textToDraw drawInRect:renderingRect withFont:font lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentLeft];
}

- (void) drawText
{
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(currentContext, 0.0, 0.0, 0.0, 1.0);
    
    NSString *textToDraw = @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.";
    
    UIFont *font = [UIFont systemFontOfSize:14.0];
    
    CGSize stringSize = [textToDraw sizeWithFont:font
                               constrainedToSize:CGSizeMake(pageSize.width - 2*kBorderInset-2*kMarginInset, pageSize.height - 2*kBorderInset - 2*kMarginInset)
                                   lineBreakMode:UILineBreakModeWordWrap];
    
    CGRect renderingRect = CGRectMake(kBorderInset + kMarginInset, kBorderInset + kMarginInset + 50.0, pageSize.width - 2*kBorderInset - 2*kMarginInset, stringSize.height);
    
    [textToDraw drawInRect:renderingRect
                  withFont:font
             lineBreakMode:UILineBreakModeWordWrap
                 alignment:UITextAlignmentLeft];
    
}

- (void) drawLine
{
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(currentContext, kLineWidth);
    
    CGContextSetStrokeColorWithColor(currentContext, [UIColor blueColor].CGColor);
    
    CGPoint startPoint = CGPointMake(kMarginInset + kBorderInset, kMarginInset + kBorderInset + 40.0);
    CGPoint endPoint = CGPointMake(pageSize.width - 2*kMarginInset -2*kBorderInset, kMarginInset + kBorderInset + 40.0);
    
    CGContextBeginPath(currentContext);
    CGContextMoveToPoint(currentContext, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(currentContext, endPoint.x, endPoint.y);
    
    CGContextClosePath(currentContext);
    CGContextDrawPath(currentContext, kCGPathFillStroke);
}

- (void) drawImageForPage:(NSInteger) pageNumber
{
    UIImage * demoImage = (UIImage*)[self.receiptArray objectAtIndex:pageNumber];      //[UIImage imageNamed:@"Sample.jpg"];      //[UIImage imageWithContentsOfFile:@"Sample.jpg"];
//    [demoImage drawInRect:CGRectMake( (pageSize.width - demoImage.size.width/2)/2, 0, demoImage.size.width/2, demoImage.size.height/2)];
    [demoImage drawInRect:CGRectMake( 30, 30, pageSize.width - 60, pageSize.height - 60)];
}

- (void) generatePdfWithFilePath: (NSString *)thefilePath
{
    UIGraphicsBeginPDFContextToFile(thefilePath, CGRectZero, nil);
    
    NSInteger currentPage = 0;
    BOOL done = NO;
    do
    {
        //Start a new page.
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, pageSize.width, pageSize.height), nil);
        
        //Draw a page number at the bottom of each page.
//        currentPage++;
        [self drawPageNumber:(currentPage+1)];
        
        //Draw a border for each page.
        [self drawBorder];
        
        //Draw text fo our header.
//        [self drawHeader];
        
        //Draw a line below the header.
//        [self drawLine];
        
        //Draw some text for the page.
//        [self drawText];
        
        //Draw an image
        [self drawImageForPage:currentPage];
        done = YES;
        currentPage++;
    }
    while (currentPage < self.receiptArray.count);
//    while (!done);
    
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();
    [self showPDFforPath:thefilePath];
}

#pragma mark - View lifecycle

- (void) showPDFforPath:(NSString*) filePath {
    UIWebView* yourWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //    NSString*  filePath= [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"pdf"]];
    /// or you can even read docs file as : pathForResource:@"sample" ofType:@"docx"]
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [yourWebView setUserInteractionEnabled:YES];
    [yourWebView setDelegate:self];
    yourWebView.scalesPageToFit = YES;
    [yourWebView loadRequest:requestObj];
    [self.view addSubview:yourWebView];
    self.saveButton.enabled = YES;
}

- (IBAction)generatePdfButtonPressed:(id)sender {
    isPhotoTaken = true;
    [self uploadReceipt:[NSData dataWithContentsOfFile:pdfFileName]];
    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:activityIndicator];
    activityIndicator.center = self.view.center;
    [activityIndicator startAnimating];
}

- (void) createPDF {
    pageSize = CGSizeMake(612, 792);
    NSString *fileName = @"Demo1.pdf";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    pdfFileName = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    [self generatePdfWithFilePath:pdfFileName];
}

- (void)uploadReceipt:(NSData*)imageData {
    //    UIImage *image =[UIImage imageWithData:imageData];
    //    NSData *data = UIImageJPEGRepresentation(image, 0);
    TServiceWrapper  *mServiceWrapper = [[TServiceWrapper alloc] init];
    [mServiceWrapper setDelegate:self];
    [mServiceWrapper uploadReceipt:imageData inUploadFolder:Username fileFormat:@"pdf"];
    //    [mServiceWrapper getPendingList:[NSNumber numberWithInt:65]];
}

-(void)uploadReceiptDoneWithInfo:(NSMutableArray*)uploadReceiptInfo {
//    NSLog(@"uploadReceiptDoneWithInfo= %@", uploadReceiptInfo);
//    NSDictionary* uploadedReceiptInfo = (NSDictionary*)[uploadReceiptInfo objectAtIndex:0];
//    NSLog(@"uploadedReceiptInfo= %@", uploadedReceiptInfo);
//    [self saveReceipt:uploadedReceiptInfo];
    self.navigationController.navigationBarHidden = NO;
    if([uploadReceiptInfo isKindOfClass:[NSError class]] || [uploadReceiptInfo isKindOfClass:[SoapFault class]]) {
        if (isPhotoTaken) {
            isPhotoTaken = false;
//            [self showToastMessage];
            [self ShowAlert:@"Unable to uload PDF"];
        }
    } else {
        NSDictionary* uploadedReceiptInfo = (NSDictionary*)[uploadReceiptInfo objectAtIndex:0];
        NSLog(@"uploadedReceiptInfo= %@", uploadedReceiptInfo);
        [self saveReceipt:uploadedReceiptInfo];
    }
    [activityIndicator stopAnimating];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//- (void)showToastMessage {
//    NSString *message = @"Unable to uload PDF";
//    UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
//                                                    message:message
//                                                   delegate:nil
//                                          cancelButtonTitle:nil
//                                          otherButtonTitles:nil, nil];
//    [toast show];
//    int duration = 3; // in seconds
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        [toast dismissWithClickedButtonIndex:0 animated:YES];
//    });
//}

- (void) ShowAlert:(NSString *)Message {
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:nil
                                                                  message:@""
                                                           preferredStyle:UIAlertControllerStyleAlert];
    UIView *firstSubview = alert.view.subviews.firstObject;
    UIView *alertContentView = firstSubview.subviews.firstObject;
    for (UIView *subSubView in alertContentView.subviews) {
        subSubView.backgroundColor = [UIColor colorWithRed:141/255.0f green:0/255.0f blue:254/255.0f alpha:1.0f];
    }
    NSMutableAttributedString *AS = [[NSMutableAttributedString alloc] initWithString:Message];
    [AS addAttribute: NSForegroundColorAttributeName value: [UIColor whiteColor] range: NSMakeRange(0,AS.length)];
    [alert setValue:AS forKey:@"attributedTitle"];
    [self presentViewController:alert animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:^{
            [activityIndicator stopAnimating];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    });
}

- (void)saveReceipt:(NSDictionary*)receipt {
//    NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 0);

//    NSManagedObjectContext *context = [self managedObjectContext];
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    // Create a new managed object
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
    [newDevice setValue:[NSNumber numberWithBool:[receipt valueForKey:@"IsAttached"]] forKey:@"isAttached"];
    [newDevice setValue:[receipt valueForKey:@"MobileThumbnailReceiptPath"] forKey:@"mobileThumbnailReceiptPath"];
    [newDevice setValue:[NSNumber numberWithInteger:[[receipt valueForKey:@"ReceiptScanId"] integerValue]] forKey:@"receiptScanId"];
    [newDevice setValue:[receipt valueForKey:@"ReceiptType"] forKey:@"receiptType"];
    [newDevice setValue:[receipt valueForKey:@"ScanningStatus"] forKey:@"scanningStatus"];
    [newDevice setValue:[receipt valueForKey:@"Source"] forKey:@"source"];
    NSString* transactionDate = [receipt valueForKey:@"TransactionDate"];
    NSLog(@"transactionDate= %@",transactionDate);
    //    NSDate* date = [receipt valueForKey:@"TransactionDate"];
    //    [newDevice setValue:date forKey:@"transactionDate"];
    [newDevice setValue:[NSNumber numberWithInteger:[[receipt valueForKey:@"VAT1"] floatValue]] forKey:@"vat1"];
    [newDevice setValue:[NSNumber numberWithInteger:[[receipt valueForKey:@"VAT2"] floatValue]] forKey:@"vat2"];
    [newDevice setValue:[NSNumber numberWithInteger:[[receipt valueForKey:@"VAT3"] floatValue]] forKey:@"vat3"];
    [newDevice setValue:[NSNumber numberWithInteger:[[receipt valueForKey:@"VAT4"] floatValue]] forKey:@"vat4"];
    [newDevice setValue:[receipt valueForKey:@"Vendor"] forKey:@"vendor"];
    [newDevice setValue:[receipt valueForKey:@"WebThumbnailReceiptPath"] forKey:@"webThumbnailReceiptPath"];
    
//    [newDevice setValue:imageData forKey:@"img"];
    
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
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

