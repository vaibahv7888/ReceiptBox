//
//  BusinessActivityArray.m
//  expense
//
//  Created by mac on 22/09/16.
//
//

#import "BusinessActivityArray.h"
#import "BusinessActivityEntity.h"

@implementation BusinessActivityArray

+ (id) newWithNode: (CXMLNode*) node
{
    return [[BusinessActivityArray alloc] initWithNode: node];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            BusinessActivityEntity* value = [[BusinessActivityEntity newWithNode: child] object];
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
        [s appendString: [item serialize: @"vw_BusinessActivity"]];
    }
    return s;
}

@end
