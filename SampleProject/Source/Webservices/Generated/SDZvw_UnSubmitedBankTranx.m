//
//  SDZvw_UnSubmitedBankTranx.m
//  expense
//
//  Created by praveen chellenkula on 14/09/13.
//
//

#import "SDZvw_UnSubmitedBankTranx.h"

@implementation SDZvw_UnSubmitedBankTranx

@synthesize Active = _Active;
@synthesize Amount = _Amount;
@synthesize City = _City;
@synthesize CoWorkers = _CoWorkers;
@synthesize Comment = _Comment;
@synthesize ConvertedAmount = _ConvertedAmount;
@synthesize CountryId   = _CountryId;
@synthesize CurrencyId  = _CurrencyId;
@synthesize CurrencyRate  = _CurrencyRate;
@synthesize ExpenseDate = _ExpenseDate;
@synthesize ExpenseDetailId = _ExpenseDetailId;
@synthesize ExpenseId = _ExpenseId;
@synthesize ExpenseTypeId = _ExpenseTypeId;
@synthesize IsReceipt = _IsReceipt;
@synthesize MethodId = _MethodId;
@synthesize NotReimbursable = NotReimbursable;
@synthesize OtherAmount1 = _OtherAmount1;
@synthesize OtherAmount2 = _OtherAmount2;
@synthesize OtherAmount3 = _OtherAmount3;
@synthesize OtherAmount4 = _OtherAmount4;
@synthesize OtherComments = _OtherComments;
@synthesize ReceiptPath = _ReceiptPath;
@synthesize StateId = _StateId;
@synthesize TransactionName = _TransactionName;
@synthesize TransactionSource = _TransactionSource;
@synthesize UserId = _UserId;
@synthesize VendorId = _VendorId;
@synthesize VendorName = _VendorName;
@synthesize BusinessPurpose=_BusinessPurpose;
@synthesize companyID=_CompanyID;
@synthesize businessID=_BusinessID;
@synthesize deptID=_DeptID;
@synthesize customerID=_CustomerID;
@synthesize projectID=_ProjectID;
@synthesize projTaskID=_ProjTaskID;
@synthesize billingID=_BillingID;
@synthesize isInvalid=_isInvalid;
@synthesize splitDetailID;
@synthesize ExpenseTypeCat;
@synthesize businessActivityId;
@synthesize referenceId;
@synthesize staffMemberId;
@synthesize approverId;

@synthesize referenceType;
- (id) init
{
    if(self = [super init])
    {
        self.Activity = nil;
        self.City = nil;
        self.CoWorkers = nil;
        self.Comment = nil;
        self.TransactionName = nil;
        self.TransactionSource = nil;
        self.ReceiptPath = nil;
        self.OtherComments = nil;
        self.VendorName = nil;
        self.BusinessPurpose=nil;
    }
    return self;
}

+ (SDZvw_UnSubmitedBankTranx *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (SDZvw_UnSubmitedBankTranx*)[[[SDZvw_UnSubmitedBankTranx alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.Active = [[Soap getNodeValue: node withName: @"Active"] boolValue];
        self.Amount = [NSDecimalNumber decimalNumberWithString:[Soap getNodeValue: node withName: @"Amount"] ];
        self.City = [Soap getNodeValue: node withName: @"City"];
        self.CoWorkers = [Soap getNodeValue: node withName: @"CoWorkers"];
        self.Comment = [Soap getNodeValue: node withName: @"Comment"];
        self.BusinessPurpose = [Soap getNodeValue: node withName: @"BusinessPurpose"];

        
        self.ConvertedAmount = [NSDecimalNumber decimalNumberWithString:[Soap getNodeValue: node withName: @"ConvertedAmount"]];
        self.CountryId = [[Soap getNodeValue: node withName: @"CountryId"] intValue];
        self.CurrencyId = [[Soap getNodeValue: node withName: @"CurrencyId"] intValue];
        self.CurrencyRate = [NSDecimalNumber decimalNumberWithString:[Soap getNodeValue: node withName: @"CurrencyRate"]];
        
        NSDate *date;
        if([Soap getNodeValue: node withName: @"ExpenseDate"]){
            date = [NSDate dateFromInternetDateTimeString : [Soap getNodeValue: node withName: @"ExpenseDate"] formatHint : 0];
        
            self.ExpenseDate = date;
        }
        
        self.ExpenseDetailId = [[Soap getNodeValue: node withName: @"ExpenseDetailId"] intValue];
        self.IsReceipt = [[Soap getNodeValue: node withName: @"IsReceipt"] intValue];
        self.MethodId = [[Soap getNodeValue: node withName: @"MethodId"] intValue];
        
        self.NotReimbursable = [[Soap getNodeValue: node withName: @"NotReimbursable"] boolValue];
         // [Soap getNodeValue: node withName: @"NotReimbursable"];
        self.OtherAmount1 = [NSDecimalNumber decimalNumberWithString:[Soap getNodeValue: node withName: @"OtherAmount1"]];
        self.OtherAmount2 = [NSDecimalNumber decimalNumberWithString:[Soap getNodeValue: node withName: @"OtherAmount2"]];
        self.OtherAmount3 = [NSDecimalNumber decimalNumberWithString:[Soap getNodeValue: node withName: @"OtherAmount3"]];
        
        self.OtherAmount4 = [NSDecimalNumber decimalNumberWithString:[Soap getNodeValue: node withName: @"OtherAmount4"]];
        self.OtherComments = [Soap getNodeValue: node withName: @"OtherComments"];
        self.ReceiptPath = [Soap getNodeValue: node withName: @"ReceiptPath"];
        self.StateId = [[Soap getNodeValue: node withName: @"StateId"] intValue];
        
        self.TransactionName = [Soap getNodeValue: node withName: @"TransactionName"];
        self.TransactionSource = [Soap getNodeValue: node withName: @"TransactionSource"];
        self.UserId = [[Soap getNodeValue: node withName: @"UserId"] intValue];
        self.VendorId = [[Soap getNodeValue: node withName: @"VendorId"] intValue];
        self.ExpenseTypeId = [[Soap getNodeValue: node withName: @"ExpenseTypeId"] intValue];
        self.VendorName = [Soap getNodeValue: node withName: @"VendorName"];

        self.companyID = [[Soap getNodeValue: node withName: @"CompanyId"] intValue];
        self.businessID = [[Soap getNodeValue: node withName: @"BusinessUnitId"] intValue];
        self.deptID = [[Soap getNodeValue: node withName: @"CostCenterId"] intValue];
        self.customerID = [[Soap getNodeValue: node withName: @"CustomerId"] intValue];
        self.projectID = [[Soap getNodeValue: node withName: @"ProjectId"] intValue];
        self.projTaskID = [[Soap getNodeValue: node withName: @"ProjectTaskId"] intValue];
        self.billingID = [[Soap getNodeValue: node withName: @"BillingCodeId"] intValue];
        
        self.businessActivityId = [[Soap getNodeValue: node withName: @"BusinessActivityId"] intValue];
        self.referenceId = [[Soap getNodeValue: node withName: @"ReferenceId"] intValue];
        self.staffMemberId = [[Soap getNodeValue: node withName: @"StaffMemberId"] intValue];
        self.approverId = [[Soap getNodeValue: node withName: @"ApproverId"] intValue];

        self.isInvalid = [[Soap getNodeValue: node withName: @"IsInvalid"] boolValue];

        self.referenceType=([Soap getNodeValue: node withName: @"ReferenceType"]!=nil)?[Soap getNodeValue: node withName: @"ReferenceType"]:nil;
        self.splitDetailID = [[Soap getNodeValue: node withName: @"ReferenceExpenseDetailId"] intValue];
        self.ExpenseTypeCat = [Soap getNodeValue:node withName:@"ExpenseTypeCategory"];
    }
    return self;
}

- (NSMutableString*) serialize
{
    return [self serialize: @"vw_UnSubmitedBankTrnx"];
}

- (NSMutableString*) serialize: (NSString*) nodeName
{
    NSMutableString* s = [[NSMutableString alloc] init];
    [s appendFormat: @"<%@", nodeName];
    [s appendString: [self serializeAttributes]];
    [s appendString: @">"];
    [s appendString: [self serializeElements]];
    [s appendFormat: @"</%@>", nodeName];
    return [s autorelease];
}

- (NSMutableString*) serializeElements
{
    NSMutableString* s = [super serializeElements];
    [s appendFormat: @"<Active>%@</Active>", (self.Active)?@"true":@"false"];

    
    if (self.CoWorkers != nil) [s appendFormat: @"<CoWorkers>%@</CoWorkers>", [[self.CoWorkers stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
    
    if (self.Comment != nil) [s appendFormat: @"<Comment>%@</Comment>", [[self.Comment stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
    
     if (self.OtherComments != nil) [s appendFormat: @"<OtherComments>%@</OtherComments>", [[self.OtherComments stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
    
     if (self.ReceiptPath != nil) [s appendFormat: @"<ReceiptPath>%@</ReceiptPath>", [[self.ReceiptPath stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
    
     if (self.TransactionName != nil) [s appendFormat: @"<TransactionName>%@</TransactionName>", [[self.TransactionName stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
    
     if (self.TransactionSource != nil) [s appendFormat: @"<TransactionSource>%@</TransactionSource>", [[self.TransactionSource stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
    
     if (self.VendorName != nil) [s appendFormat: @"<VendorName>%@</VendorName>", [[self.VendorName stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
    
    
    [s appendFormat: @"<Amount>%@</Amount>", [NSString stringWithFormat: @"%f", [self.Amount floatValue]]];
    [s appendFormat: @"<ConvertedAmount>%@</ConvertedAmount>", [NSString stringWithFormat: @"%f", [self.ConvertedAmount floatValue]]];
    [s appendFormat: @"<CurrencyRate>%@</CurrencyRate>", [NSString stringWithFormat: @"%f", [self.CurrencyRate floatValue]]];
    [s appendFormat: @"<OtherAmount1>%@</OtherAmount1>", [NSString stringWithFormat: @"%f", [self.OtherAmount1 floatValue]]];
    [s appendFormat: @"<OtherAmount2>%@</OtherAmount2>", [NSString stringWithFormat: @"%f", [self.OtherAmount2 floatValue]]];
    [s appendFormat: @"<OtherAmount3>%@</OtherAmount3>", [NSString stringWithFormat: @"%f", [self.OtherAmount3 floatValue]]];
    [s appendFormat: @"<OtherAmount4>%@</OtherAmount4>", [NSString stringWithFormat: @"%f", [self.OtherAmount4 floatValue]]];
    
    [s appendFormat: @"<CountryId>%@</CountryId>", [NSString stringWithFormat: @"%i", self.CountryId]];
    [s appendFormat: @"<CurrencyId>%@</CurrencyId>", [NSString stringWithFormat: @"%i", self.CurrencyId]];
    [s appendFormat: @"<ExpenseDetailId>%@</ExpenseDetailId>", [NSString stringWithFormat: @"%i", self.ExpenseDetailId]];
    

    
    [s appendFormat: @"<ExpenseId>%@</ExpenseId>", [NSString stringWithFormat: @"%i", self.ExpenseId]];
    [s appendFormat: @"<ExpenseTypeId>%@</ExpenseTypeId>", [NSString stringWithFormat: @"%i", self.ExpenseTypeId]];
    [s appendFormat: @"<IsReceipt>%@</IsReceipt>", [NSString stringWithFormat: @"%i", self.IsReceipt]];
    
    [s appendFormat: @"<MethodId>%@</MethodId>", [NSString stringWithFormat: @"%i", self.MethodId]];
    [s appendFormat: @"<StateId>%@</StateId>", [NSString stringWithFormat: @"%i", self.StateId]];
    [s appendFormat: @"<UserId>%@</UserId>", [NSString stringWithFormat: @"%i", self.UserId]];
    [s appendFormat: @"<VendorId>%@</VendorId>", [NSString stringWithFormat: @"%i", self.VendorId]];
    [s appendFormat: @"<UserId>%@</UserId>", [NSString stringWithFormat: @"%i", self.UserId]];
    
 
    [s appendFormat: @"<NotReimbursable>%@</NotReimbursable>", (self.NotReimbursable)?@"true":@"false"];
    
    return s;
}

- (NSMutableString*) serializeAttributes
{
    NSMutableString* s = [super serializeAttributes];
    
    return s;
}

-(BOOL)isEqual:(id)object{
    if(object != nil && [object isKindOfClass:[SDZvw_UnSubmitedBankTranx class]]) {
        return [[self serialize] isEqualToString:[object serialize]];
    }
    return NO;
}

-(NSUInteger)hash{
    return [Soap generateHash:self];
    
}

- (void) dealloc{
    [super dealloc];
    
}

@end
