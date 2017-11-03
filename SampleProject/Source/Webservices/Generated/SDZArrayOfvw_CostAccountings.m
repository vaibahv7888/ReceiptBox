//
//  SDZArrayOfvw_ReportType.m
//  expense
//
//  Created by praveen chellenkula on 24/12/13.
//
//

#import "SDZArrayOfvw_CostAccountings.h"
#import "SDZvw_CostAccountings.h"

@implementation SDZArrayOfvw_CostAccountings


+ (id) newWithNode: (CXMLNode*) node
{
    return [[[SDZArrayOfvw_CostAccountings alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            SDZvw_CostAccountings* value = [[SDZvw_CostAccountings newWithNode: child] object];
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
        [s appendString: [item serialize: @"vw_CostAccountings"]];
    }
    return s;
}

@end
