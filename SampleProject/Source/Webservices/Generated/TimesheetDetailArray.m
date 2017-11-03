//
//  TimesheetDetailArray.m
//  expense
//
//  Created by Parveen Sharma on 6/16/15.
//
//

#import "TimesheetDetailArray.h"
#import "TimesheetDetailEntity.h"

@implementation TimesheetDetailArray
+ (id) newWithNode: (CXMLNode*) node
{
    return [[[TimesheetDetailArray alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            TimesheetDetailEntity* value = [[TimesheetDetailEntity newWithNode: child] object];
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
        [s appendString: [item serialize: @"vw_ts_TimesheetConfigLabels"]];
    }
    return s;
}
@end
