//
//  SDZArrayOfvw_ReportType.m
//  expense
//
//  Created by praveen chellenkula on 24/12/13.
//
//

#import "SDZArrayOfvw_CostCenters.h"
#import "SDZvw_CostCenters.h"

@implementation SDZArrayOfvw_CostCenters


+ (id) newWithNode: (CXMLNode*) node
{
    return [[[SDZArrayOfvw_CostCenters alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            SDZvw_CostCenters* value = [[SDZvw_CostCenters newWithNode: child] object];
            if(value != nil) {
                [self addObject: value];
            }
        }
    }
    return self;
}

+ (NSMutableString*) serialize: (NSArray*) array
{
    NSMutableString* s = [NSMutableString string];
    for(id item in array) {
        [s appendString: [item serialize: @"vw_CostCenters"]];
    }
    return s;
}

@end
