//
//  ARrayHCPDetails.m
//  expense
//
//  Created by Parveen Sharma on 12/3/15.
//
//

#import "ARrayHCPDetails.h"
#import "HCPDetailEntity.h"
@implementation ARrayHCPDetails

+ (id) newWithNode: (CXMLNode*) node
{
    return [[ARrayHCPDetails alloc] initWithNode: node];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            HCPDetailEntity* value = [[HCPDetailEntity newWithNode: child] object];
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
