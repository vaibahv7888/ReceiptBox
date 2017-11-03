//
//  timeSheetConfigLabelArray.m
//  expense
//
//  Created by Parveen Sharma on 5/22/15.
//
//

#import "timeSheetConfigLabelArray.h"
#import "timesheetConfigLabel.h"
@implementation timeSheetConfigLabelArray
+ (id) newWithNode: (CXMLNode*) node
{
    return [[[timeSheetConfigLabelArray alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            timesheetConfigLabel* value = [[timesheetConfigLabel newWithNode: child] object];
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
