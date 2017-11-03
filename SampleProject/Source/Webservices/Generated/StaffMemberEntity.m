//
//  StaffMemberEntity.m
//  expense
//
//  Created by mac on 21/09/16.
//
//

#import "StaffMemberEntity.h"

@implementation StaffMemberEntity

@synthesize APGLCode;
@synthesize Active;
@synthesize BusinessUnitId;
@synthesize CashAdvanceGLCode;
@synthesize CompanyId;
@synthesize CostCenterId;
@synthesize CreatedByUserId;
@synthesize CreatedTimestamp;
@synthesize CurrencyId;
@synthesize CustomDateFormat;
@synthesize ERPId;
@synthesize Email;
@synthesize EmailNotify;
@synthesize FirstName;
@synthesize LastName;
@synthesize MilageRate;
@synthesize OutOfOfficeEndDate;
@synthesize OutOfOfficeStartDate;
@synthesize PDFTemplate;
@synthesize Password;
@synthesize PerDeim;
@synthesize PhoneNumber;
@synthesize ResponsibilityID;
@synthesize RoleId;
@synthesize UnitOfTravel;
@synthesize UpdatedByUserId;
@synthesize UpdatedTimestamp;
@synthesize UserGroup;
@synthesize UserId;
@synthesize VendorNumber;
@synthesize aspnet_userId;

- (id) init
{
    if(self = [super init])
    {
    }
    return self;
}

+ (StaffMemberEntity *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (StaffMemberEntity*)[[StaffMemberEntity alloc] initWithNode: node] ;
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        
        self.APGLCode = [Soap getNodeValue: node withName: @"APGLCode"];
        self.Active = [[Soap getNodeValue: node withName: @"Active"] boolValue];
        self.BusinessUnitId = [[Soap getNodeValue: node withName: @"BusinessUnitId"] intValue];
        self.CashAdvanceGLCode = [Soap getNodeValue: node withName: @"CashAdvanceGLCode"];
        self.CompanyId = [[Soap getNodeValue: node withName: @"CompanyId"] intValue];
        self.CostCenterId = [[Soap getNodeValue: node withName: @"CostCenterId"] intValue];
        self.CreatedByUserId = [[Soap getNodeValue: node withName: @"CreatedByUserId"] intValue];
        self.CreatedTimestamp = [Soap getNodeValue: node withName: @"CreatedTimestamp"];
        self.CurrencyId = [[Soap getNodeValue: node withName: @"CurrencyId"] intValue];
        self.CustomDateFormat = [Soap getNodeValue: node withName: @"CustomDateFormat"];
        self.ERPId = [[Soap getNodeValue: node withName: @"ERPId"] intValue];
        self.Email = [Soap getNodeValue: node withName: @"Email"];
        self.EmailNotify = [Soap getNodeValue: node withName: @"EmailNotify"];
        self.FirstName = [Soap getNodeValue: node withName: @"FirstName"];
        self.LastName = [Soap getNodeValue: node withName: @"LastName"];
        self.MilageRate = [[Soap getNodeValue: node withName: @"MilageRate"] floatValue];
        
        NSDateFormatter *format=[[NSDateFormatter alloc]init];
        [format setDateFormat:@"YYYY-MM-dd"];
        NSString *str=[Soap getNodeValue: node withName: @"OutOfOfficeEndDate"];
        NSArray *array=[str componentsSeparatedByString:@"T"];
        NSDate *date=[format dateFromString:[array objectAtIndex:0]];
        self.OutOfOfficeEndDate = date ;

        NSString *str1=[Soap getNodeValue: node withName: @"OutOfOfficeStartDate"];
        NSArray *array1=[str1 componentsSeparatedByString:@"T"];
        NSDate *date1=[format dateFromString:[array1 objectAtIndex:0]];

        self.OutOfOfficeStartDate = date1;
        self.PDFTemplate = [Soap getNodeValue: node withName: @"PDFTemplate"];
        self.Password = [Soap getNodeValue: node withName: @"Password"];
        self.PerDeim = [Soap getNodeValue: node withName: @"PerDeim"];
        self.PhoneNumber = [Soap getNodeValue: node withName: @"PhoneNumber"];
        self.ResponsibilityID = [Soap getNodeValue: node withName: @"ResponsibilityID"];
        self.RoleId = [[Soap getNodeValue: node withName: @"RoleId"] intValue];
        self.UnitOfTravel = [Soap getNodeValue: node withName: @"UnitOfTravel"];
        self.UpdatedByUserId = [[Soap getNodeValue: node withName: @"UpdatedByUserId"] intValue];
        self.UpdatedTimestamp = [Soap getNodeValue: node withName: @"UpdatedTimestamp"];
        self.UserGroup = [Soap getNodeValue: node withName: @"UserGroup"];
        self.UserId = [[Soap getNodeValue: node withName: @"UserId"] intValue];
        self.VendorNumber = [Soap getNodeValue: node withName: @"VendorNumber"];
        self.aspnet_userId = [Soap getNodeValue: node withName: @"aspnet_userId"];
    }
    return self;
}

@end
