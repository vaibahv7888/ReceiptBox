//
//  SDZArrayOfvw_ConfigLables.m
//  expense
//
//  Created by praveen chellenkula on 07/04/13.
//
//

#import "SDZArrayOfvw_ApplicationConfigLables.h"
#import "SDZvw_GetApplicationConfigLables.h"


@implementation SDZArrayOfvw_ApplicationConfigLables
+ (id) newWithNode: (CXMLNode*) node
{
    return [[[SDZArrayOfvw_ApplicationConfigLables alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            SDZvw_GetApplicationConfigLables* value = [[SDZvw_GetApplicationConfigLables newWithNode: child] object];
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
        [s appendString: [item serialize: @"vw_GetApplicationConfigLables"]];
    }
    return s;
}
@end