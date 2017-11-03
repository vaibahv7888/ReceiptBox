//
//  SDZStateLicenceEntity.m
//  expense
//
//  Created by Parveen Sharma on 12/17/15.
//
//

#import "SDZStateLicenceEntity.h"

@implementation SDZStateLicenceEntity
@synthesize Country;
@synthesize State;
@synthesize StateCode;

- (id) init
{
    if(self = [super init])
    {
    }
    return self;
}

+ (SDZStateLicenceEntity *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (SDZStateLicenceEntity*)[[SDZStateLicenceEntity alloc] initWithNode: node] ;
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.Country = [Soap getNodeValue: node withName: @"Country"];
        self.State = [Soap getNodeValue: node withName: @"State"];
        self.StateCode = [Soap getNodeValue: node withName: @"StateCode"];
    }
    return self;
}

@end
