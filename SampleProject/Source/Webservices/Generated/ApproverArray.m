//
//  ApproverArray.m
//  expense
//
//  Created by mac on 22/09/16.
//
//

#import "ApproverArray.h"
#import "ApproverEntity.h"
@implementation ApproverArray

+ (id) newWithNode: (CXMLNode*) node
{
    return [[ApproverArray alloc] initWithNode: node];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            ApproverEntity* value = [[ApproverEntity newWithNode: child] object];
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
        [s appendString: [item serialize: @"vw_ProjectManagerMapping"]];
    }
    return s;
}

@end
