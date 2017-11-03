//
//  SDZ_CityWithPerDiemArray.m
//  expense
//
//  Created by Parveen Sharma on 9/14/15.
//
//

#import "SDZ_CityWithPerDiemArray.h"
#import "CityWithPerDiemEntity.h"

@implementation SDZ_CityWithPerDiemArray
+ (id) newWithNode: (CXMLNode*) node
{
    return [[[SDZ_CityWithPerDiemArray alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            CityWithPerDiemEntity* value = [[CityWithPerDiemEntity newWithNode: child] object];
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
        [s appendString: [item serialize: @"vw_City_PerDiem"]];
    }
    return s;
}
@end
