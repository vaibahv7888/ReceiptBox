// TServiceWrapper.h

#import "SDZService_Mobile.h"
#import "AppDelegate.h"
#import "SDZUploadImage.h"
#import "SDZUploadImageParse.h"
#import "ARrayHCPDetails.h"
#import "SDZReportDetailEntity.h"
#import "XMLReader.h"

@protocol TServiceWrapperDelegate <NSObject>

@optional
// Expense Upload Delegates
-(void)uploadFileDoneWithStatus : (NSDictionary *)responseStatusDetails;
-(void)pendingListDoneWithStatus : (NSMutableArray *) pendingList;
-(void)uploadReceiptDoneWithInfo:(NSMutableArray*)uploadReceiptInfo;
-(void)removeReceiptDoneWithStatus:(NSMutableDictionary*)deleteStatus;
@end


@interface TServiceWrapper : NSObject <SoapDelegate>
{

	SDZService_Mobile	*mService;
	AppDelegate		*mAppDelegate;
	NSInteger			mLoginStatus;
    id <TServiceWrapperDelegate> delegate;
}

@property NSInteger loginStatus;
@property (nonatomic, retain) id <TServiceWrapperDelegate> delegate;

//- (void)uploadFile:(NSData *)data inUploadFolder:(NSString *)UploadFolder;
- (void) uploadFile:(NSData *)data inUploadFolder:(NSString *)UploadFolder fileFormat:(NSString *)fileFormat;
- (void) getPendingList:(NSNumber*) UserID;
- (void) removeReceiptFromBox: (NSNumber *) UserId ReceiptId: (NSNumber *) ReceiptId;
- (void) uploadReceipt:(NSData *)data inUploadFolder:(NSString *)UploadFolder fileFormat:(NSString *)fileFormat;

@end
