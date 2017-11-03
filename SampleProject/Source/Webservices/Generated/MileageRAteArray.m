//
//  MileageRAteArray.m
//  expense
//
//  Created by Parveen Sharma on 11/24/15.
//
//

#import "MileageRAteArray.h"
#import "MileageRateObject.h"

@implementation MileageRAteArray

+ (id) newWithNode: (CXMLNode*) node
{
    return [[MileageRAteArray alloc] initWithNode: node];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            MileageRateObject* value = [[MileageRateObject newWithNode: child] object];
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
        [s appendString: [item serialize: @"vw_MileageRate"]];
    }
    return s;
}

@end
