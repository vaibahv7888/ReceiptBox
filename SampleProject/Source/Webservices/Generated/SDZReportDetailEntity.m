//
//  SDZReportDetailEntity.m
//  expense
//
//  Created by mac on 28/03/16.
//
//

#import "SDZReportDetailEntity.h"

@implementation SDZReportDetailEntity
@synthesize reportHeaderArray,reportSummaryArray,reportFooterArray,reportTransactionArray;

- (id) initWithReportID:(NSNumber *)reportId1
{
    if(self = [super init])
    {
        self.reportId=reportId1;
    }
    return self;
}

+ (SDZReportDetailEntity *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (SDZReportDetailEntity*)[[SDZReportDetailEntity alloc] initWithNode: node] ;
}

- (id) initWithNode: (CXMLNode*) node {
    
    if(self = [self init]) {
        for(CXMLElement* child in [node children]) {
            if ([[child name] isEqualToString:@"ExpenseReportHeader"]) {
                self.reportHeaderArray = [[[ReportSectionArray alloc] initWithNode:child withReportId:self.reportId] object];
            }
            if ([[child name] isEqualToString:@"ExpenseReportSummaries"]) {
                self.reportSummaryArray = [[[ReportSectionArray alloc] initWithNode:child withReportId:self.reportId] object];
            }
            if ([[child name] isEqualToString:@"ExpenseReportFooter"]) {
                self.reportFooterArray = [[[ReportSectionArray alloc] initWithNode:child withReportId:self.reportId] object];
            }
            if ([[child name] isEqualToString:@"ExpenseReportTransactions"]) {
//                if ([[child children] count]) {
//                    NSMutableArray *reportArray = [NSMutableArray new];
//                    for (CXMLElement* childNode in [child children]) {
                        self.reportTransactionArray = [[[ReportTransactionArray alloc] initWithNode:child withReportId:self.reportId] object];
//                    }
//                    CXMLElement *childNode=[[child children] objectAtIndex:0];
//                    [repor addObject:reportArray]; //[[[ReportTransactionArray alloc] initWithNode:childNode withReportId:self.reportId] object];
//                }
            }
        }
    }
    return self;
}

@end
