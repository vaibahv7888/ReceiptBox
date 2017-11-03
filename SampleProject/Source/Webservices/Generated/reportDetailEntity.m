//
//  reportDetailEntity.m
//  expense
//
//  Created by mac on 05/01/16.
//
//

#import "reportDetailEntity.h"
#import "ArrayCostAllocations.h"

@implementation reportDetailEntity
@synthesize reportListEntity;
@synthesize transactionsArray;
@synthesize costAllocationsArray;

- (id) init
{
    if(self = [super init])
    {
    }
    return self;
}

+ (reportDetailEntity *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (reportDetailEntity*)[[reportDetailEntity alloc] initWithNode: node] ;
}

- (id) initWithNode: (CXMLNode*) node {
    
    if(self = [self init]) {
        for(CXMLElement* child in [node children]) {
            if ([[child name] isEqualToString:@"CostAllocations"]) {
                self.costAllocationsArray = [[[ArrayCostAllocations alloc] initWithNode:child] object];
            }
            if ([[child name] isEqualToString:@"ReportHeader"]) {
                self.reportListEntity = [[ReportsListEntity newWithNode: child] object];
            }

            if ([[child name] isEqualToString:@"Transactions"]) {
                self.transactionsArray = [[[SDZArrayOfvw_UnSubmitedBankTranx alloc] initWithNode:child] object];//[[SDZArrayOfvw_UnSubmitedBankTranx newWithNode: child] object];

//                NSArray *arryGroup = [child elementsForName:@"int"];
//
//                NSMutableArray *expenseDetailsArray=[NSMutableArray new];
//                for(CXMLElement* childExpense in arryGroup) {
//                    [expenseDetailsArray addObject:childExpense.stringValue];
//                }
//                self.expenseDetailId=expenseDetailsArray;
            }
        }
    }
    return self;
}
@end

