    /*
	SDZService_Mobile.m
	The implementation classes and methods for the Service_Mobile web service.
	Generated by SudzC.com
*/

#import "SDZService_Mobile.h"
				
#import "Soap.h"
	
#import "SDZStructuralObject.h"
#import "SDZArrayOfvw_ExpenseType.h"
#import "SDZArrayOfvw_state.h"
#import "SDZArrayOfvw_country.h"
#import "SDZArrayOfvw_currency.h"
#import "SDZArrayOfvw_vendor.h"
#import "SDZArrayOfvw_payMethod.h"
#import "SDZEntityObject.h"
#import "SDZArrayOfEntityKeyMember.h"
#import "SDZEntityKeyMember.h"
#import "SDZvw_vendor.h"
#import "SDZArrayOfstring.h"

#import "SDZEntityKey.h"
#import "SDZvw_ExpenseType.h"
#import "SDZvw_state.h"
#import "SDZvw_country.h"
#import "SDZvw_currency.h"
#import "SDZvw_payMethod.h"
#import "SDZArrayOfvw_ConfigInfo.h"
#import "SDZArrayOfvw_ApplicationConfigLables.h"

#import "SDZvw_jobList.h"
#import "SDZArrayOfvw_jobList.h"
#import "SDZFileTransferRequestBuf.h"
#import "SDZFileReceivedInfoBuf.h"
#import "SDZUploadImage.h"
#import "SDZUploadImageParse.h"
#import "SDZ_Arr_CustomerProjectMapping.h"
#import "SDZ_ArrayJobTasks.h"
#import "SDZArrayBillingCode.h"
#import "SDZ_TaxRateArray.h"
#import "Arr_MapProjectExpense.h"
#import "TimeSheetArray.h"
#import "timeSheetConfigLabelArray.h"
#import "timeTypeArray.h"
#import "TimesheetDetailArray.h"
#import "SDZ_CityWithPerDiemArray.h"
#import "SDZ_ViolationArray.h"
#import "SDZ_ExpTypeMappingViolationArray.h"
#import "UnApprovedReportsArray.h"
#import "UserDefaultSyncEntity.h"
#import "AppDelegate.h"
#import "MileageRAteArray.h"
#import "ARrayHCPDetails.h"
#import "StateLicenceArray.h"
#import "DesignationArray.h"
#import "ReportsListArray.h"
#import "reportDetailEntity.h"
#import "SDZReportDetailEntity.h"
#import "StaffMemberArray.h"
#import "ApproverArray.h"
#import "BusinessActivityArray.h"
#import "ReferenceArray.h"

/* Implementation of the service */
				
@implementation SDZService_Mobile

	- (id) init
	{
		if(self = [super init])
		{
            NSString *baseServiceUrl = [[NSUserDefaults standardUserDefaults]valueForKey:@"BASE_URL"];
            //NSLog(@"Base URL %@",[[NSUserDefaults standardUserDefaults]valueForKey:@"BASE_URL"]);
            
            NSString *finalBaseServiceUrl =  [baseServiceUrl stringByAppendingString: @"/Service_Mobile.svc"];// [NSString stringWithFormat:@"http://%@",baseServiceUrl];
            //NSLog(@"Base URL %@",finalBaseServiceUrl);

			//self.serviceUrl = @"https://www.gorillaexpense.info/GorillaMobileService/Service_Mobile.svc";
            //http://64.34.170.104/gorillamobileservice/service_mobile.svc
            self.serviceUrl = finalBaseServiceUrl;
			//self.serviceUrl = @"http://64.34.170.104/GorillaMobileService/Service_Mobile.svc";
			self.namespace = @"http://www.gorillaexpense.net/mobile";
			self.headers = [super headers];
			self.logging = YES;
		}
		return self;
	}
	
	- (id) initWithUsername: (NSString*) username andPassword: (NSString*) password {
		if(self = [super initWithUsername:username andPassword:password]) {
		}
		return self;
	}
	
	+ (SDZService_Mobile*) service {
		return [SDZService_Mobile serviceWithUsername:nil andPassword:nil];
	}
	
	+ (SDZService_Mobile*) serviceWithUsername: (NSString*) username andPassword: (NSString*) password {
		return [[[SDZService_Mobile alloc] initWithUsername:username andPassword:password] autorelease];
	}

		
/* Returns NSString*.  */
- (SoapRequest*) UploadFileDefault: (id <SoapDelegate>) handler sourceStream: (NSData*) sourceStream
{
	return [self UploadFileDefault: handler action: nil sourceStream: sourceStream];
}

- (SoapRequest*) UploadFileDefault: (id) _target action: (SEL) _action sourceStream: (NSData*) sourceStream
{
	NSMutableArray* _params = [[NSMutableArray alloc] initWithCapacity:20];
	
	[_params addObject: [[[SoapParameter alloc] initWithValue: sourceStream forName: @"sourceStream"] autorelease]];
	NSString* _envelope = [Soap createEnvelope: @"UploadFileDefault" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
	SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://www.gorillaexpense.net/mobile/Service_Mobile/UploadFileDefault" postData: _envelope deserializeTo: @"NSString"];
	[_request send];
	return _request;
}


/* Returns SDZFileReceivedInfoBuf*.  */
- (SoapRequest*) UploadFileBuffered: (id <SoapDelegate>) handler request: (SDZFileTransferRequestBuf*) request
{
	return [self UploadFileBuffered: handler action: nil request: request];
}

- (SoapRequest*) UploadFileBuffered: (id) _target action: (SEL) _action request: (SDZFileTransferRequestBuf*) request
{
	NSMutableArray* _params = [NSMutableArray array];
	
	[_params addObject: [[[SoapParameter alloc] initWithValue: request forName: @"request"] autorelease]];
	NSString* _envelope = [Soap createEnvelope: @"UploadFileBuffered" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
	SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://www.gorillaexpense.net/mobile/Service_Mobile/UploadFileBuffered" postData: _envelope deserializeTo: [[SDZFileReceivedInfoBuf alloc] autorelease]];
	[_request send];
	return _request;
}



/* Returns BOOL.  */
- (SoapRequest*) UploadFile: (id <SoapDelegate>) handler Data: (NSData*) Data UploadFolder:(NSString *)UploadFolder fileFormat:(NSString *)fileFormat
	{
		return [self UploadFile: handler action: nil Data: Data UploadFolder:UploadFolder fileFormat:fileFormat];
	}

- (SoapRequest*) UploadFile: (id) _target action: (SEL) _action Data: (NSData*) Data UploadFolder: (NSString *)UploadFolder fileFormat:(NSString *)fileFormat
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: Data forName: @"Data"] autorelease]];
		
	    // setting soap headers.
		if ( UploadFolder != nil ) 
		{
			[self.headers setObject:UploadFolder forKey:@"UploadFolder"];
		}
			
		NSCalendar *cal = [NSCalendar currentCalendar];
		NSCalendarUnit flags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ;
		NSDateComponents *inComponents = [cal components:flags fromDate:[NSDate date]];
		NSString *timestamp = [NSString stringWithFormat:@"%i",
							   abs( (int)( [inComponents day] * 24 * 3600 + [inComponents month] * 30 * 24 * 3600 + [inComponents year] * 360 * 24 * 3600 +
							   [inComponents hour] * 3600 + [inComponents minute] * 60 + [inComponents second] ) * 1000 )];
            if(fileFormat){
                timestamp = [timestamp stringByAppendingPathExtension:fileFormat];            
            }
            else{
                timestamp = [timestamp stringByAppendingString:@".jpg"];
            }
		[self.headers setObject:timestamp forKey:@"FileName"];
			
			
		//NSString* _envelope = [Soap createEnvelope: @"UploadFileStreamed" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		NSString* _envelope = [Soap createEnvelope: @"FileTransferRequest" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://www.gorillaexpense.net/mobile/Service_Mobile/UploadFileStreamed" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
			NSLog(@"Request==%@",_request);
		return _request;
	}

-(SoapRequest*) removeReceiptFromBox: (id) _target action: (SEL) _action UserId: (NSNumber *) UserId ReceiptId: (NSNumber *) ReceiptId{
    NSMutableArray* _params = [NSMutableArray array];
    //    int _userId = UserId.intValue;
    [_params addObject:[[[SoapParameter alloc] initWithValue:UserId forName:@"UserId"] autorelease]];
    [_params addObject:[[[SoapParameter alloc] initWithValue:ReceiptId forName:@"ReceiptId"] autorelease]];
    
    //    [self.headers setObject:UserId forKey:@"UserId"];
    
    NSString* _envelope = [Soap createEnvelope:@"RemoveReceiptFromBox" forNamespace:self.namespace withParameters:_params withHeaders:self.headers];
    
    SoapRequest* _request = [SoapRequest create:_target action:_action service:self soapAction:@"http://www.gorillaexpense.net/mobile/Service_Mobile/RemoveReceiptFromBox" postData:_envelope deserializeTo:@"NSString"];
    [_request send];
    NSLog(@"Request==%@",_request);
    return _request;
}

-(SoapRequest*) getPendingList: (id) _target action: (SEL) _action UserId: (NSNumber *) UserId {
    
    NSMutableArray* _params = [NSMutableArray array];
//    int _userId = UserId.intValue;
    [_params addObject:[[[SoapParameter alloc] initWithValue:UserId forName:@"UserId"] autorelease]];
    
//    [self.headers setObject:UserId forKey:@"UserId"];
    
    NSString* _envelope = [Soap createEnvelope:@"GetPendingList" forNamespace:self.namespace withParameters:_params withHeaders:self.headers];
    
    SoapRequest* _request = [SoapRequest create:_target action:_action service:self soapAction:@"http://www.gorillaexpense.net/mobile/Service_Mobile/GetPendingList" postData:_envelope deserializeTo:@"NSString"];
    [_request send];
    NSLog(@"Request==%@",_request);
    return _request;
}

- (SoapRequest*) UploadReceipt: (id) _target action: (SEL) _action Data: (NSData*) Data UploadFolder: (NSString *)UploadFolder fileFormat:(NSString *)fileFormat
{
    NSMutableArray* _params = [NSMutableArray array];
    
    [_params addObject: [[[SoapParameter alloc] initWithValue: Data forName: @"Data"] autorelease]];
    
    // setting soap headers.
    if ( UploadFolder != nil )
    {
        [self.headers setObject:UploadFolder forKey:@"UploadFolder"];
    }
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSCalendarUnit flags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ;
    NSDateComponents *inComponents = [cal components:flags fromDate:[NSDate date]];
    NSString *timestamp = [NSString stringWithFormat:@"%i",
                           abs( (int)( [inComponents day] * 24 * 3600 + [inComponents month] * 30 * 24 * 3600 + [inComponents year] * 360 * 24 * 3600 +
                                      [inComponents hour] * 3600 + [inComponents minute] * 60 + [inComponents second] ) * 1000 )];
    if(fileFormat){
        timestamp = [timestamp stringByAppendingPathExtension:fileFormat];
    }
    else{
        timestamp = [timestamp stringByAppendingString:@".jpg"];
    }
    [self.headers setObject:timestamp forKey:@"FileName"];
    
    
    //NSString* _envelope = [Soap createEnvelope: @"UploadFileStreamed" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
    NSString* _envelope = [Soap createEnvelope: @"FileTransferRequest" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
    SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://www.gorillaexpense.net/mobile/Service_Mobile/UploadReceiptInBox" postData: _envelope deserializeTo: @"NSString"];
    [_request send];
    NSLog(@"Request==%@",_request);
    return _request;
}


@end