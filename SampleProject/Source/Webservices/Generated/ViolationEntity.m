//
//  ViolationEntity.m
//  expense
//
//  Created by Parveen Sharma on 9/14/15.
//
//

#import "ViolationEntity.h"

@implementation ViolationEntity
@synthesize violationId ;
@synthesize violationName;
@synthesize violationReason;

- (id) init
{
    if(self = [super init])
    {
        
    }
    return self;
}

+ (ViolationEntity *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (ViolationEntity*)[[[ViolationEntity alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.violationReason = [Soap getNodeValue: node withName: @"ViolationReason"];
        self.violationName = [Soap getNodeValue: node withName: @"ViolationCategory"];
        self.violationId = [[Soap getNodeValue: node withName: @"ViolationId"] intValue] ;
    }
    return self;
}

@end
