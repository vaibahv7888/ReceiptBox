//
//  SDZDesignationEntity.m
//  expense
//
//  Created by Parveen Sharma on 12/17/15.
//
//

#import "SDZDesignationEntity.h"

@implementation SDZDesignationEntity
@synthesize Designation;
@synthesize DesignationCode;

- (id) init
{
    if(self = [super init])
    {
    }
    return self;
}

+ (SDZDesignationEntity *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (SDZDesignationEntity*)[[SDZDesignationEntity alloc] initWithNode: node] ;
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.Designation = [Soap getNodeValue: node withName: @"Designation"];
        self.DesignationCode = [Soap getNodeValue: node withName: @"DesignationCode"];
    }
    return self;
}

@end
