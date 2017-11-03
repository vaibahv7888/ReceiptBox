//
//  timeTypeEntity.m
//  expense
//
//  Created by Parveen Sharma on 5/28/15.
//
//

#import "timeTypeEntity.h"

@implementation timeTypeEntity

@synthesize timeTypeID=_timeTypeID;
@synthesize TimeTypeName=_TimeTypeName;

- (id) init
{
    if(self = [super init])
    {
        self.TimeTypeName = nil;
        self.timeTypeID = nil;
    }
    return self;
}

+ (timeTypeEntity*) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (timeTypeEntity*)[[[timeTypeEntity alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.timeTypeID = [[Soap getNodeValue: node withName: @"TimeTypeId"] intValue];
        self.TimeTypeName = [Soap getNodeValue: node withName: @"TimeType"];
    }
    return self;
}

@end
