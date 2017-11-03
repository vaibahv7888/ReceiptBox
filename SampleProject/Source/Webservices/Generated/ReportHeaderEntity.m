//
//  ReportHeaderEntity.m
//  expense
//
//  Created by mac on 28/03/16.
//
//

#import "ReportHeaderEntity.h"

@implementation ReportHeaderEntity
@synthesize elementName,elementValue,reportId;

- (id) initWithReportID:(NSNumber *)reportId1
{
    if(self = [super init])
    {
    }
    return self;
}

+ (ReportHeaderEntity *) newWithNode: (CXMLNode*) node withReportId:(NSNumber *)reportID
{
    if(node == nil) { return nil; }
    return (ReportHeaderEntity*)[[ReportHeaderEntity alloc] initWithNode: node withReportId:reportID] ;
}

- (id) initWithNode: (CXMLNode*) node  withReportId:(NSNumber *)reportID
{
    if(self = [super initWithNode: node])
    {
        self.elementValue = [Soap getNodeValue: node withName: @"ElementValue"];
        self.elementName = [Soap getNodeValue: node withName: @"ElementName"];
        self.reportId = reportID;
    }
    return self;
}
@end
