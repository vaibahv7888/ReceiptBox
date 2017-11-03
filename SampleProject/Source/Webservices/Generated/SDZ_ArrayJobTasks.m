//
//  SDZ_ArrayJobTasks.m
//  expense
//
//  Created by Parveen Sharma on 4/2/15.
//
//

#import "SDZ_ArrayJobTasks.h"
#import "SDZ_JobsTasks.h"

@implementation SDZ_ArrayJobTasks

+ (id) newWithNode: (CXMLNode*) node
{
    return [[[SDZ_ArrayJobTasks alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            SDZ_JobsTasks* value = [[SDZ_JobsTasks newWithNode: child] object];
            
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
