//
//  SDZArrayBillingCode.m
//  expense
//
//  Created by Parveen Sharma on 4/24/15.
//
//

#import "SDZArrayBillingCode.h"
#import "SDZBillingCode.h"
@implementation SDZArrayBillingCode
+ (id) newWithNode: (CXMLNode*) node
{
    return [[[SDZArrayBillingCode alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            SDZBillingCode* value = [[SDZBillingCode newWithNode: child] object];
            
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
