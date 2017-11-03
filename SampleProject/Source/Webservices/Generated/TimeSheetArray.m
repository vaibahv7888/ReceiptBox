//
//  TimeSheetArray.m
//  expense
//
//  Created by Parveen Sharma on 6/8/15.
//
//

#import "TimeSheetArray.h"
#import "SDZ_TimeSheetList.h"
@implementation TimeSheetArray

+ (id) newWithNode: (CXMLNode*) node
{
    return [[[TimeSheetArray alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            SDZ_TimeSheetList* value = [[SDZ_TimeSheetList newWithNode: child] object];
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
