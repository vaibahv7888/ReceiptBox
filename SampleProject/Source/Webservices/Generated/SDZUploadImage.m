//
//  SDZUploadImage.m
//  expense
//
//  Created by Parveen Sharma on 3/5/15.
//
//

#import "SDZUploadImage.h"

@implementation SDZUploadImage

@synthesize Amount = _Amount;
@synthesize Date=_Date;
@synthesize Vendor=_Vendor;
@synthesize ExpenseObj=_ExpenseObj;
@synthesize fault=_fault;

- (id) initWithExpense:(NSManagedObject*) expense;
{
    if(self = [super init])
    {
        self.Amount = nil;
        self.Date = nil;
        self.Vendor = nil;
        self.ExpenseObj=expense;
        self.fault=nil;
    }
    return self;
}

+ (SDZUploadImage*) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (SDZUploadImage*)[[[SDZUploadImage alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        NSDateFormatter *format=[[NSDateFormatter alloc]init];
        [format setDateFormat:@"YYYY-MM-dd"];
        NSString *str=[Soap getNodeValue: node withName: @"Date"];
        NSArray *array=[str componentsSeparatedByString:@"T"];
        NSDate *date=[format dateFromString:[array objectAtIndex:0]];
        self.Date = date;
        self.Amount = [NSDecimalNumber decimalNumberWithString:[Soap getNodeValue: node withName: @"Amount"]];
        self.Vendor=[Soap getNodeValue: node withName: @"Vendor"];
        self.Tax=[Soap getNodeValue: node withName: @"Tax"];
        self.State=[Soap getNodeValue: node withName: @"State"];
        self.City=[Soap getNodeValue: node withName: @"Location"];
        if(self.City==nil)
        {
            self.City=[Soap getNodeValue: node withName: @"City"];
        }
        self.Country=[Soap getNodeValue: node withName: @"Country"];
    }
    return self;
}

- (id) initWithFault: (SoapFault*) node {
    self.fault=node;
    return self;
}

@end
