//
//  ReportSectionArray.m
//  expense
//
//  Created by mac on 28/03/16.
//
//

#import "ReportSectionArray.h"
#import "ReportHeaderEntity.h"

@implementation ReportSectionArray

+ (id) newWithNode: (CXMLNode*) node
{
    return [[ReportSectionArray alloc] initWithNode: node];
}

- (id) initWithNode: (CXMLNode*) node withReportId:(NSNumber *)reportID
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            ReportHeaderEntity* value = [[ReportHeaderEntity newWithNode: child withReportId:reportID] object];
            if(value != nil) {
                [self addObject: value];
            }
        }
    }
    return self;
}

@end
