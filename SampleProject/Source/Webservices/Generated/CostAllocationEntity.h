//
//  CostAllocationEntity.h
//  expense
//
//  Created by mac on 07/01/16.
//
//

#import "SDZEntityObject.h"

@interface CostAllocationEntity : SDZEntityObject
@property (nonatomic,strong) NSString *AmountOrPercentage;
@property (nonatomic,strong) NSString *BusinessUnitId;
@property (nonatomic,strong) NSString *CompanyId;
@property (nonatomic,strong) NSString *CostAccountingId;
@property (nonatomic,strong) NSString *CostAllocationGroup;
@property (nonatomic,strong) NSString *CostCenterId;
@property (nonatomic,strong) NSString *ExpenseDetailId;
@property (nonatomic,strong) NSString *ExpenseId;
@property (nonatomic,strong) NSString *HCPCostAllocationXML;
@property (nonatomic,strong) NSString *OtherValues;
@end
