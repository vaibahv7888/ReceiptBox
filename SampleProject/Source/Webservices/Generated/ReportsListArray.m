//
//  ReportsListArray.m
//  expense
//
//  Created by mac on 05/01/16.
//
//

#import "ReportsListArray.h"
#import "ReportsListEntity.h"

@implementation ReportsListArray

+ (id) newWithNode: (CXMLNode*) node
{
    return [[ReportsListArray alloc] initWithNode: node];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            ReportsListEntity* value = [[ReportsListEntity newWithNode: child] object];
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
        [s appendString: [item serialize: @"vw_MileageRate"]];
    }
    return s;
}

@end
