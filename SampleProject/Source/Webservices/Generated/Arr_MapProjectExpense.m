//
//  Arr_MapProjectExpense.m
//  expense
//
//  Created by Parveen Sharma on 5/18/15.
//
//

#import "Arr_MapProjectExpense.h"
#import "MapProjectExpense.h"
@implementation Arr_MapProjectExpense
+ (id) newWithNode: (CXMLNode*) node
{
    return [[[Arr_MapProjectExpense alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            MapProjectExpense* value = [[MapProjectExpense newWithNode: child] object];
            
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
