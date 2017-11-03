//
//  SDZUploadImageParse.m
//  expense
//
//  Created by Parveen Sharma on 3/17/15.
//
//

#import "SDZUploadImageParse.h"

@implementation SDZUploadImageParse
@synthesize imageId = _imageId;
@synthesize imagePath=_imagePath;
@synthesize expenseObj=_expenseObj;
@synthesize status=_status;
@synthesize processingResult=_processingResult;
@synthesize fault=_fault;

- (id) initWithExpense:(NSManagedObject*)expense
{
    if(self = [super init])
    {
        self.imagePath = nil;
        self.imageId = nil;
        self.status=nil;
        self.expenseObj = expense;
        self.processingResult=nil;
        self.fault=nil;
    }
    return self;
}

+ (SDZUploadImageParse*) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (SDZUploadImageParse*)[[[SDZUploadImageParse alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.imageId = [Soap getNodeValue: node withName: @"UniqueFileId"];
        self.imagePath = [Soap getNodeValue: node withName: @"ReceiptPath"];
        self.status=[Soap getNodeValue:node withName:@"UploadSucceeded"];
        self.processingResult=[Soap getNodeValue:node withName:@"GetOCRProcessingStatusResult"];
    }
    return self;
}

- (id) initWithFault: (SoapFault*) node {
    self.fault=node;
    return self;
}
@end
