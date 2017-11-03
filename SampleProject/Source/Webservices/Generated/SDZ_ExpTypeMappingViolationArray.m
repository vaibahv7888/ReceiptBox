//
//  SDZ_ExpTypeMappingViolationArray.m
//  expense
//
//  Created by Parveen Sharma on 9/14/15.
//
//

#import "SDZ_ExpTypeMappingViolationArray.h"
#import "ExpTypeViolationsMappingEntity.h"

@implementation SDZ_ExpTypeMappingViolationArray

+ (id) newWithNode: (CXMLNode*) node
{
    return [[[SDZ_ExpTypeMappingViolationArray alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            ExpTypeViolationsMappingEntity* value = [[ExpTypeViolationsMappingEntity newWithNode: child] object];
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
        [s appendString: [item serialize: @"vw_ExpenseTypeViolationMapping"]];
    }
    return s;
}

@end
