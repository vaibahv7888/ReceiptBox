//
//  SDZArrayOfvw_jobList.m
//  expense
//
//  Created by praveen chellenkula on 09/08/13.
//
//

#import "SDZArrayOfvw_jobList.h"
#import "SDZvw_jobList.h"

@implementation SDZArrayOfvw_jobList

+ (id) newWithNode: (CXMLNode*) node
{
    return [[[SDZArrayOfvw_jobList alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            SDZvw_jobList* value = [[SDZvw_jobList newWithNode: child] object];
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
        [s appendString: [item serialize: @"vw_Jobs"]];
    }
    return s;
}
@end
