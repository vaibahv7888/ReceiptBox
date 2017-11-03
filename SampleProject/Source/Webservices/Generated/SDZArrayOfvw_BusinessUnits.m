//
//  SDZArrayOfvw_ReportType.m
//  expense
//
//  Created by praveen chellenkula on 24/12/13.
//
//

#import "SDZArrayOfvw_BusinessUnits.h"
#import "SDZvw_BusinessUnits.h"

@implementation SDZArrayOfvw_BusinessUnits


+ (id) newWithNode: (CXMLNode*) node
{
    return [[[SDZArrayOfvw_BusinessUnits alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            SDZvw_BusinessUnits* value = [[SDZvw_BusinessUnits newWithNode: child] object];
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
        [s appendString: [item serialize: @"vw_BusinessUnits"]];
    }
    return s;
}

@end
