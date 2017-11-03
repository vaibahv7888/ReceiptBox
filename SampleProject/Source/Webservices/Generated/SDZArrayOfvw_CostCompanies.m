//
//  SDZArrayOfvw_ReportType.m
//  expense
//
//  Created by praveen chellenkula on 24/12/13.
//
//

#import "SDZArrayOfvw_CostCompanies.h"
#import "SDZvw_CostCompanies.h"

@implementation SDZArrayOfvw_CostCompanies


+ (id) newWithNode: (CXMLNode*) node
{
    return [[[SDZArrayOfvw_CostCompanies alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            SDZvw_CostCompanies* value = [[SDZvw_CostCompanies newWithNode: child] object];
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
        [s appendString: [item serialize: @"vw_CostCompanies"]];
    }
    return s;
}

@end
