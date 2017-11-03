//
//  ExpTypeViolationsMappingEntity.m
//  expense
//
//  Created by Parveen Sharma on 9/14/15.
//
//

#import "ExpTypeViolationsMappingEntity.h"

@implementation ExpTypeViolationsMappingEntity
@synthesize ViolationId ;
@synthesize ExpenseTypeViolationId;
@synthesize ExpesneTypeId;

- (id) init
{
    if(self = [super init])
    {
        
    }
    return self;
}

+ (ExpTypeViolationsMappingEntity *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (ExpTypeViolationsMappingEntity*)[[[ExpTypeViolationsMappingEntity alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.ViolationId = [[Soap getNodeValue: node withName: @"ViolationId"] intValue] ;
        self.ExpesneTypeId = [[Soap getNodeValue: node withName: @"ExpesneTypeId"] intValue] ;
        self.ExpenseTypeViolationId = [[Soap getNodeValue: node withName: @"ExpenseTypeViolationId"] intValue] ;

    }
    return self;
}

@end
