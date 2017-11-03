//
//  SDZ_TaxRateArray.m
//  expense
//
//  Created by Parveen Sharma on 4/30/15.
//
//

#import "SDZ_TaxRateArray.h"
#import "SDZ_TaxRate.h"

@implementation SDZ_TaxRateArray
+ (id) newWithNode: (CXMLNode*) node
{
    return [[[SDZ_TaxRateArray alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            SDZ_TaxRate* value = [[SDZ_TaxRate newWithNode: child] object];
            
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
