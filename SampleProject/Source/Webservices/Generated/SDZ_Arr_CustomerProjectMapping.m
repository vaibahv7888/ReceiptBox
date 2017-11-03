//
//  SDZ_Arr_CustomerProjectMapping.m
//  expense
//
//  Created by Parveen Sharma on 4/2/15.
//
//

#import "SDZ_Arr_CustomerProjectMapping.h"
#import "SDZ_CustomerProjectMapping.h"

@implementation SDZ_Arr_CustomerProjectMapping

+ (id) newWithNode: (CXMLNode*) node
{
    return [[[SDZ_Arr_CustomerProjectMapping alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            SDZ_CustomerProjectMapping* value = [[SDZ_CustomerProjectMapping newWithNode: child] object];
            
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
        [s appendString: [item serialize: @"vw_mapping"]];
    }
    return s;
}

@end
