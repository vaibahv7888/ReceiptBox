//
//  ReferenceArray.m
//  expense
//
//  Created by mac on 22/09/16.
//
//

#import "ReferenceArray.h"
#import "ReferenceEntity.h"

@implementation ReferenceArray

+ (id) newWithNode: (CXMLNode*) node
{
    return [[ReferenceArray alloc] initWithNode: node];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            ReferenceEntity* value = [[ReferenceEntity newWithNode: child] object];
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
        [s appendString: [item serialize: @"vw_Reference"]];
    }
    return s;
}

@end
