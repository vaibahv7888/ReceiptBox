 //
//  ReportTransactionArray.m
//  expense
//
//  Created by mac on 30/03/16.
//
//

#import "ReportTransactionArray.h"
#import "ReportSectionArray.h"

@implementation ReportTransactionArray

+ (id) newWithNode: (CXMLNode*) node
{
    return [[ReportTransactionArray alloc] initWithNode: node];
}

- (id) initWithNode: (CXMLNode*) node withReportId:(NSNumber *)reportID
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            CXMLElement *childNode=[[child children] objectAtIndex:0];
            ReportSectionArray* value = [[[ReportSectionArray alloc] initWithNode:childNode withReportId:reportID] object];
            if(value != nil) {
                [self addObject: value];
            }
        }
    }
    return self;
}

@end
