//
//  SDZArrayOfvw_GetMileageAddressMatrixList.m
//  expense
//
//  Created by Praveen on 09/09/14.
//
//

#import "SDZArrayOfvw_GetMileageAddressMatrixList.h"
#import "SDZService_GetMileageAddressMatrixList.h"

@implementation SDZArrayOfvw_GetMileageAddressMatrixList

+ (id) newWithNode: (CXMLNode*) node
{
    return [[[SDZArrayOfvw_GetMileageAddressMatrixList alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            SDZService_GetMileageAddressMatrixList* value = [[SDZService_GetMileageAddressMatrixList newWithNode: child] object];
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
        [s appendString: [item serialize: @"Service_GetMileageAddressMatrixList"]];
    }
    return s;
}
@end