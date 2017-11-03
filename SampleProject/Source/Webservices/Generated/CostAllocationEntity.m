//
//  CostAllocationEntity.m
//  expense
//
//  Created by mac on 07/01/16.
//
//

#import "CostAllocationEntity.h"

@implementation CostAllocationEntity
@synthesize AmountOrPercentage;
@synthesize BusinessUnitId;
@synthesize CompanyId;
@synthesize CostAccountingId;
@synthesize CostAllocationGroup;
@synthesize CostCenterId;
@synthesize ExpenseDetailId;
@synthesize ExpenseId;
@synthesize HCPCostAllocationXML;
@synthesize OtherValues;

- (id) init
{
    if(self = [super init])
    {
    }
    return self;
}

+ (CostAllocationEntity *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (CostAllocationEntity*)[[CostAllocationEntity alloc] initWithNode: node] ;
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.AmountOrPercentage = [Soap getNodeValue: node withName: @"AmountOrPercentage"];
        self.BusinessUnitId = [Soap getNodeValue: node withName: @"BusinessUnitId"];
        self.CompanyId = [Soap getNodeValue: node withName: @"CompanyId"];
        self.CostAccountingId = [Soap getNodeValue: node withName: @"CostAccountingId"];
        self.CostAllocationGroup = [Soap getNodeValue: node withName: @"CostAllocationGroup"];
        self.CostCenterId = [Soap getNodeValue: node withName: @"CostCenterId"];
        self.ExpenseDetailId = [Soap getNodeValue: node withName: @"ExpenseDetailId"];
        self.ExpenseId = [Soap getNodeValue: node withName: @"ExpenseId"];
        self.HCPCostAllocationXML = ([Soap getNodeValue: node withName: @"HCPCostAllocationXML"]==nil)?@"":[Soap getNodeValue: node withName: @"HCPCostAllocationXML"];
        self.OtherValues = ([Soap getNodeValue: node withName: @"OtherValues"]==nil)?@"":[Soap getNodeValue: node withName: @"OtherValues"];
        
    }
    return self;
}

@end
