//
//  SDZArrayOfvw_GetSettings.m
//  expense
//
//  Created by Praveen on 30/07/14.
//
//

#import "SDZArrayOfvw_GetSettings.h"
#import "SDZService_GetSettings.h"

@implementation SDZArrayOfvw_GetSettings

+ (id) newWithNode: (CXMLNode*) node
{
    return [[[SDZArrayOfvw_GetSettings alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            SDZService_GetSettings* value = [[SDZService_GetSettings newWithNode: child] object];
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
        [s appendString: [item serialize: @"Service_GetSettings"]];
    }
    return s;
}
@end
