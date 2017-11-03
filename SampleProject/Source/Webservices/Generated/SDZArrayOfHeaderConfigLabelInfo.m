//
//  SDZArrayOfHeaderConfigLabelInfo.m
//  expense
//
//  Created by praveen chellenkula on 24/12/13.
//
//

#import "SDZArrayOfHeaderConfigLabelInfo.h"
#import "SDZHeaderConfigLabelInfo.h"

@implementation SDZArrayOfHeaderConfigLabelInfo


+ (id) newWithNode: (CXMLNode*) node
{
    return [[[SDZArrayOfHeaderConfigLabelInfo alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            SDZHeaderConfigLabelInfo* value = [[SDZHeaderConfigLabelInfo newWithNode: child] object];
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
        [s appendString: [item serialize: @"HeaderConfigLabelInfo"]];
    }
    return s;
}


@end
