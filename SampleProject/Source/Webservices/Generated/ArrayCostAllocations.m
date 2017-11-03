//
//  ArrayCostAllocations.m
//  expense
//
//  Created by mac on 07/01/16.
//
//

#import "ArrayCostAllocations.h"
#import "CostAllocationEntity.h"

@implementation ArrayCostAllocations
+ (id) newWithNode: (CXMLNode*) node
{
    return [[ArrayCostAllocations alloc] initWithNode: node];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            CostAllocationEntity* value = [[CostAllocationEntity newWithNode: child] object];
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
