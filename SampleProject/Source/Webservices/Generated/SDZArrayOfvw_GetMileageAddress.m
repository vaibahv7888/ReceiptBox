//
//  SDZArrayOfvw_GetMileageAddress.m
//  expense
//
//  Created by Praveen on 07/09/14.
//
//

#import "SDZArrayOfvw_GetMileageAddress.h"
#import "SDZService_GetMileageAddress.h"

@implementation SDZArrayOfvw_GetMileageAddress

+ (id) newWithNode: (CXMLNode*) node
{
    return [[[SDZArrayOfvw_GetMileageAddress alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            SDZService_GetMileageAddress* value = [[SDZService_GetMileageAddress newWithNode: child] object];
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
        [s appendString: [item serialize: @"Service_GetMileageAddress"]];
    }
    return s;
}
@end