//
//  UserDefaultSyncEntity.m
//  expense
//
//  Created by Parveen Sharma on 10/27/15.
//
//

#import "UserDefaultSyncEntity.h"

@implementation UserDefaultSyncEntity

@synthesize BillingCode;
@synthesize BusinessPurpose;
@synthesize BusinessUnit;
@synthesize City;
@synthesize Comments;
@synthesize Company;
@synthesize CostCenter;
@synthesize Country;
@synthesize Currency;
@synthesize CurrencyRate;
@synthesize Customer;
@synthesize OtherCoworker;
@synthesize OtherDetails;
@synthesize PayMethod;
@synthesize Project;
@synthesize ProjectTask;
@synthesize State;
@synthesize Vendor;
@synthesize TimeType;
@synthesize Desc;
@synthesize Misc1;
@synthesize Misc2;
@synthesize Misc3;
@synthesize BusinessActivity;
@synthesize Reference;
@synthesize StaffMember;
@synthesize Approver;

- (id) init
{
    if(self = [super init])
    {
        
    }
    return self;
}

+ (UserDefaultSyncEntity *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (UserDefaultSyncEntity*)[[UserDefaultSyncEntity alloc] initWithNode: node] ;
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.BillingCode = [Soap getNodeValue: node withName: @"BillingCode"];
        self.BusinessPurpose = [Soap getNodeValue: node withName: @"BusinessPurpose"];
        self.BusinessUnit = [Soap getNodeValue: node withName: @"BusinessUnit"];
        self.City = [Soap getNodeValue: node withName: @"City"];
        self.Comments = [Soap getNodeValue: node withName: @"Comments"];
        self.Company = [Soap getNodeValue: node withName: @"Company"];
        self.CostCenter = [Soap getNodeValue: node withName: @"CostCenter"];
        self.Country = [Soap getNodeValue: node withName: @"Country"];
        self.Currency = [Soap getNodeValue: node withName: @"Currency"];
        self.CurrencyRate = [[Soap getNodeValue: node withName: @"CurrencyRate"] floatValue] ;
        self.Customer = [Soap getNodeValue: node withName: @"Customer"];
        self.OtherCoworker = [Soap getNodeValue: node withName: @"OtherCoworker"];
        self.OtherDetails = [Soap getNodeValue: node withName: @"OtherDetails"];
        self.PayMethod = [Soap getNodeValue: node withName: @"PayMethod"];
        self.Project = [Soap getNodeValue: node withName: @"Project"];
        self.ProjectTask = [Soap getNodeValue: node withName: @"ProjectTask"];
        self.State = [Soap getNodeValue: node withName: @"State"];
        self.Vendor = [Soap getNodeValue: node withName: @"Vendor"];
        self.TimeType = [Soap getNodeValue: node withName: @"TimeType"];
        self.Desc = [Soap getNodeValue: node withName: @"Description"];
        self.Misc1 = [Soap getNodeValue: node withName: @"MiscField1"];
        self.Misc2 = [Soap getNodeValue: node withName: @"MiscField2"];
        self.Misc3 = [Soap getNodeValue: node withName: @"MiscField3"];
        self.BusinessActivity = [Soap getNodeValue: node withName: @"BusinessActivity"];
        self.Reference = [Soap getNodeValue: node withName: @"Reference"];
        self.StaffMember = [Soap getNodeValue: node withName: @"StaffMember"];
        self.Approver = [Soap getNodeValue: node withName: @"Approver"];

    }
    return self;
}


@end
