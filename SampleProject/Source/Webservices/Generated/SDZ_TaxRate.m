//
//  SDZ_TaxRate.m
//  expense
//
//  Created by Parveen Sharma on 4/30/15.
//
//

#import "SDZ_TaxRate.h"

@implementation SDZ_TaxRate

@synthesize isActive        =_isActive;
@synthesize isEnableVat1    =_isEnableVat1;
@synthesize isEnableVat2    =_isEnableVat2;
@synthesize isEnableVat3    =_isEnableVat3;
@synthesize isEnableVat4    =_isEnableVat4;
@synthesize ExpenseTypeID   =_ExpenseTypeID;
@synthesize State           =_State;
@synthesize StateID         =_StateID;
@synthesize TaxRateID       =_TaxRateID;
@synthesize Vat1Rate        =_Vat1Rate;
@synthesize Vat2Rate        =_Vat2Rate;
@synthesize Vat3Rate        =_Vat3Rate;
@synthesize Vat4Rate        =_Vat4Rate;
@synthesize dateValidFrom   =_dateValidFrom;
@synthesize dateValidTo     =_dateValidTo;

- (id) init
{
    if(self = [super init])
    {
        self.isActive=nil;
        self.isEnableVat1=nil;
        self.isEnableVat2=nil;
        self.isEnableVat3=nil;
        self.isEnableVat4=nil;
        self.ExpenseTypeID=nil;
        self.State=nil;
        self.StateID=nil;
        self.TaxRateID=nil;
        self.Vat1Rate=0.00;
        self.Vat2Rate=0.00;
        self.Vat3Rate=0.00;
        self.Vat4Rate=0.00;
        self.dateValidFrom=nil;
        self.dateValidTo=nil;
    }
    return self;
}

+ (SDZ_TaxRate*) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (SDZ_TaxRate*)[[[SDZ_TaxRate alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.isActive = [[Soap getNodeValue: node withName: @"Active"] boolValue];
        self.isEnableVat1 = [[Soap getNodeValue: node withName: @"EnableVAT1Rate"] boolValue];
        self.isEnableVat2 = [[Soap getNodeValue: node withName: @"EnableVAT2Rate"] boolValue];
        self.isEnableVat3 = [[Soap getNodeValue: node withName: @"EnableVAT3Rate"] boolValue];
        self.isEnableVat4 = [[Soap getNodeValue: node withName: @"EnableVAT4Rate"] boolValue];
        self.ExpenseTypeID = [[Soap getNodeValue: node withName: @"ExpenseTypeID"] intValue];
        self.State = [Soap getNodeValue: node withName: @"State"];
        self.StateID = [[Soap getNodeValue: node withName: @"StateID"] intValue];
        self.TaxRateID = [[Soap getNodeValue: node withName: @"TaxRateDataId"] intValue];
        self.Vat1Rate = [[Soap getNodeValue: node withName: @"VAT1Rate"] floatValue];
        self.Vat2Rate = [[Soap getNodeValue: node withName: @"VAT2Rate"] floatValue];
        self.Vat3Rate = [[Soap getNodeValue: node withName: @"VAT3Rate"] floatValue];
        self.Vat4Rate = [[Soap getNodeValue: node withName: @"VAT4Rate"] floatValue];
        NSDateFormatter *format=[[NSDateFormatter alloc]init];
        [format setDateFormat:@"YYYY-MM-dd"];
        NSString *str=[Soap getNodeValue: node withName: @"ValidFrom"];
        NSArray *array=[str componentsSeparatedByString:@"T"];
        NSDate *date=[format dateFromString:[array objectAtIndex:0]];
        self.dateValidFrom = date;
        NSString *str1=[Soap getNodeValue: node withName: @"ValidTo"];
        NSArray *array1=[str1 componentsSeparatedByString:@"T"];
        NSDate *date1=[format dateFromString:[array1 objectAtIndex:0]];
        self.dateValidTo = date1;
    }
    return self;
}
@end
