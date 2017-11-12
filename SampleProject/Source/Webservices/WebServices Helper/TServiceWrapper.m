// TServiceWrapper.m

#import "TServiceWrapper.h"
#import "SDZFileTransferRequestBuf.h"
#import "SDZUploadImage.h"
#import "SDZUploadImageParse.h"

@interface TServiceWrapper ()

@end

@implementation TServiceWrapper

@synthesize loginStatus = mLoginStatus;
@synthesize delegate;

#pragma mark -
#pragma mark Initialization & Dealloc
#pragma mark

// --------------------------------------------------------------------------------
// init:

- (id)init
{
    id	this;
    
    // Call super
    this = [super init];
    if ( this != nil )
    {
        // Do other initialization here
        mService = [[SDZService_Mobile service] retain];
        mService.logging = YES;
        
        
        mAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     //   mModel = mAppDelegate.dataModel;
//        mLoginStatus = 0;
        //mService.username = @"username";
        //mService.password = @"password";
    }
    
    // Return
    return this;
    
}

// --------------------------------------------------------------------------------
// uploadFile:data

- (void)uploadFile:(NSData *)data inUploadFolder:(NSString *)UploadFolder fileFormat:(NSString *)fileFormat
{
    //[mService UploadFile:self action:@selector(UploadFileHandler:) Data:data  ];
    [mService UploadFile:self action:@selector(UploadFileHandler:) Data:data UploadFolder:UploadFolder fileFormat:(NSString *)fileFormat];
    
//    mAppDelegate.expenseReceiptPath = nil;
    
}

- (void)uploadReceipt:(NSData *)data inUploadFolder:(NSString *)UploadFolder fileFormat:(NSString *)fileFormat {
    [mService UploadReceipt:self action:@selector(uploadReceiptHandler:) Data:data UploadFolder:UploadFolder fileFormat:fileFormat];
}

- (void)getPendingList:(NSNumber*) UserID {
    [mService getPendingList:self action:@selector(pendingListHandler:) UserId:UserID];
}

- (void) removeReceiptFromBox: (NSNumber *) UserId ReceiptId: (NSNumber *) ReceiptId {
    [mService removeReceiptFromBox:self action:@selector(RemoveFileHandler:) UserId:UserId ReceiptId:ReceiptId];
}
// --------------------------------------------------------------------------------
// UploadFileHandler:value
// Handle the response from UploadFile.

- (void) UploadFileHandler: (NSString *) value
{
    NSMutableDictionary *responseDetails = [[NSMutableDictionary alloc] initWithCapacity:3];
    
    
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        NSLog(@"%@", value);
        [responseDetails setObject:[NSNumber numberWithBool:NO] forKey:@"IsFileUploadDone"];
        if([self.delegate respondsToSelector:@selector(uploadFileDoneWithStatus:)])
        {
            [self.delegate uploadFileDoneWithStatus : responseDetails];
        }
        
        return;
    }
    
    // Handle faults
    if([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"%@", value);
        [responseDetails setObject:[NSNumber numberWithBool:NO] forKey:@"IsFileUploadDone"];
        if([self.delegate respondsToSelector:@selector(uploadFileDoneWithStatus:)])
        {
            [self.delegate uploadFileDoneWithStatus : responseDetails];
        }
        return;
    }
    
    
    // Do something with the NSString* result
    NSString* result = (NSString*)value;
    
    if (result != nil && ![result isEqualToString:@"Error"])
    {
//        mAppDelegate.fileUploadState = YES;
//        mAppDelegate.expenseReceiptPath = result;
//        [responseDetails setObject:[NSNumber numberWithBool:YES] forKey:@"IsFileUploadDone"];
//        [responseDetails setObject:result forKey:@"ReceiptPath"];
        [responseDetails setObject:[NSNumber numberWithBool:YES] forKey:@"IsFileUploadDone"];
        [responseDetails setObject:result forKey:@"ReceiptPath"];
    }
    else{
//        mAppDelegate.expenseReceiptPath = nil;
//        [responseDetails setObject:[NSNumber numberWithBool:NO] forKey:@"IsFileUploadDone"];
        [responseDetails setObject:[NSNumber numberWithBool:NO] forKey:@"IsFileUploadDone"];
    }
    
    //NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    //[notificationCenter postNotificationName:@"UploadFileNotification" object:nil];
    if([self.delegate respondsToSelector:@selector(uploadFileDoneWithStatus:)])
    {

        [self.delegate uploadFileDoneWithStatus : responseDetails];
    
    }
}

- (void) pendingListHandler: (NSMutableArray*) pendingList {
    NSMutableDictionary *responseDetails = [[NSMutableDictionary alloc] initWithCapacity:3];
    
    // Handle errors
    if([pendingList isKindOfClass:[NSError class]]) {
        NSLog(@"%@", pendingList);
        [responseDetails setObject:[NSNumber numberWithBool:NO] forKey:@"IsFileUploadDone"];
        if([self.delegate respondsToSelector:@selector(uploadFileDoneWithStatus:)])
        {
            [self.delegate uploadFileDoneWithStatus : responseDetails];
        }
        
        return;
    }

//    // Handle faults
    if([pendingList isKindOfClass:[SoapFault class]]) {
        NSLog(@"%@", pendingList);
        [responseDetails setObject:[NSNumber numberWithBool:NO] forKey:@"IsFileUploadDone"];
        if([self.delegate respondsToSelector:@selector(uploadFileDoneWithStatus:)])
        {
            [self.delegate uploadFileDoneWithStatus : responseDetails];
        }
        return;
    }

//    NSError *error=nil;
    
//    NSDictionary *dictionary=[XMLReader dictionaryForXMLString:value error:&error];
    
    if([self.delegate respondsToSelector:@selector(pendingListDoneWithStatus:)])
    {
        
        [self.delegate pendingListDoneWithStatus : pendingList];
        
    }
}

- (void) uploadReceiptHandler:(NSMutableArray*) uploadReceiptInfo {
    if([self.delegate respondsToSelector:@selector(uploadReceiptDoneWithInfo:)]) {
        [self.delegate uploadReceiptDoneWithInfo:uploadReceiptInfo];
    }
}

- (void) RemoveFileHandler: (NSString *) value
{
    // Do something with the NSString* result
    NSString* result = (NSString*)value;
    if ([self.delegate respondsToSelector:@selector(removeReceiptDoneWithInfo:)]) {
        [self.delegate removeReceiptDoneWithInfo:result];
    }
}

// --------------------------------------------------------------------------------
// dealloc

- (void)dealloc
{
    [mService release];
    
    // Call super
    [super dealloc];
}




@end
