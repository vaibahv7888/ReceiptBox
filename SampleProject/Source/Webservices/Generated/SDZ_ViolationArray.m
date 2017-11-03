//
//  SDZ_ViolationArray.m
//  expense
//
//  Created by Parveen Sharma on 9/14/15.
//
//

#import "SDZ_ViolationArray.h"
#import "ViolationEntity.h"

@implementation SDZ_ViolationArray
+ (id) newWithNode: (CXMLNode*) node
{
    return [[[SDZ_ViolationArray alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            ViolationEntity* value = [[ViolationEntity newWithNode: child] object];
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
        [s appendString: [item serialize: @"vw_Violation"]];
    }
    return s;
}

@end
