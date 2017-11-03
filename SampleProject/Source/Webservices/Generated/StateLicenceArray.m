//
//  StateLicenceArray.m
//  expense
//
//  Created by Parveen Sharma on 12/17/15.
//
//

#import "StateLicenceArray.h"
#import "SDZStateLicenceEntity.h"

@implementation StateLicenceArray
+ (id) newWithNode: (CXMLNode*) node
{
    return [[StateLicenceArray alloc] initWithNode: node];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            SDZStateLicenceEntity* value = [[SDZStateLicenceEntity newWithNode: child] object];
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
