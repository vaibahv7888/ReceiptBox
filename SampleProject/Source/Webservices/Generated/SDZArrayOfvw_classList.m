//
//  SDZArrayOfvw_classList.m
//  expense
//
//  Created by praveen chellenkula on 05/01/14.
//
//

#import "SDZArrayOfvw_classList.h"
#import "SDZvw_Class.h"

@implementation SDZArrayOfvw_classList

+ (id) newWithNode: (CXMLNode*) node
{
    return [[[SDZArrayOfvw_classList alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            SDZvw_Class * value = [[SDZvw_Class newWithNode: child] object];
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
        [s appendString: [item serialize: @"vw_Class"]];
    }
    return s;
}
@end
