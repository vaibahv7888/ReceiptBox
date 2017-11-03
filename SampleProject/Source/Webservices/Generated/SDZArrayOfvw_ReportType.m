//
//  SDZArrayOfvw_ReportType.m
//  expense
//
//  Created by praveen chellenkula on 24/12/13.
//
//

#import "SDZArrayOfvw_ReportType.h"
#import "SDZvw_ReportType.h"

@implementation SDZArrayOfvw_ReportType


+ (id) newWithNode: (CXMLNode*) node
{
    return [[[SDZArrayOfvw_ReportType alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            SDZvw_ReportType* value = [[SDZvw_ReportType newWithNode: child] object];
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
        [s appendString: [item serialize: @"vw_ReportType"]];
    }
    return s;
}

@end
