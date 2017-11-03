//
//  timeTypeArray.m
//  expense
//
//  Created by Parveen Sharma on 5/28/15.
//
//

#import "timeTypeArray.h"
#import "timeTypeEntity.h"

@implementation timeTypeArray
+ (id) newWithNode: (CXMLNode*) node
{
    return [[[timeTypeArray alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            timeTypeEntity* value = [[timeTypeEntity newWithNode: child] object];
            
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
