//
//  DesignationArray.m
//  expense
//
//  Created by Parveen Sharma on 12/17/15.
//
//

#import "DesignationArray.h"
#import "SDZDesignationEntity.h"

@implementation DesignationArray

+ (id) newWithNode: (CXMLNode*) node
{
    return [[DesignationArray alloc] initWithNode: node];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            SDZDesignationEntity* value = [[SDZDesignationEntity newWithNode: child] object];
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
