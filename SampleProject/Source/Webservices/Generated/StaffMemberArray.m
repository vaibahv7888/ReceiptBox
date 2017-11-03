//
//  StaffMemberArray.m
//  expense
//
//  Created by mac on 21/09/16.
//
//

#import "StaffMemberArray.h"
#import "StaffMemberEntity.h"

@implementation StaffMemberArray
+ (id) newWithNode: (CXMLNode*) node
{
    return [[StaffMemberArray alloc] initWithNode: node];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            StaffMemberEntity* value = [[StaffMemberEntity newWithNode: child] object];
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
        [s appendString: [item serialize: @"vw_user"]];
    }
    return s;
}
@end
