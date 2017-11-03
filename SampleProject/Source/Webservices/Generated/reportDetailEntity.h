//
//  reportDetailEntity.h
//  expense
//
//  Created by mac on 05/01/16.
//
//

#import "SDZEntityObject.h"
#import "ReportsListEntity.h"
#import "SDZArrayOfvw_UnSubmitedBankTranx.h"
#import "ArrayCostAllocations.h"

@interface reportDetailEntity : SDZEntityObject
@property (nonatomic,strong) ReportsListEntity *reportListEntity;
@property (nonatomic,strong) SDZArrayOfvw_UnSubmitedBankTranx *transactionsArray;
@property (nonatomic,strong) ArrayCostAllocations *costAllocationsArray;

@end
