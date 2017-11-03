//
//  BusinessActivityEntity.m
//  expense
//
//  Created by mac on 22/09/16.
//
//

#import "BusinessActivityEntity.h"

@implementation BusinessActivityEntity

@synthesize Active;
@synthesize BusinessActivityId;
@synthesize Code;
@synthesize CreatedByUserId;
@synthesize CreatedTimestamp;
@synthesize Description;
@synthesize IsClosed;
@synthesize UpdatedByUserId;
@synthesize UpdatedTimestamp;

- (id) init
{
    if(self = [super init])
    {
    }
    return self;
}

+ (BusinessActivityEntity *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (BusinessActivityEntity*)[[BusinessActivityEntity alloc] initWithNode: node] ;
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.Active = [[Soap getNodeValue: node withName: @"Active"] boolValue];
        self.Code = [Soap getNodeValue: node withName: @"Code"];
        self.Description = [Soap getNodeValue: node withName: @"Description"];
        self.IsClosed = [[Soap getNodeValue: node withName: @"IsClosed"] boolValue];
        self.BusinessActivityId = [[Soap getNodeValue: node withName: @"BusinessActivityId"] intValue];
        self.CreatedByUserId = [[Soap getNodeValue: node withName: @"CreatedByUserId"] intValue];
        self.UpdatedByUserId = [[Soap getNodeValue: node withName: @"UpdatedByUserId"] intValue];
        self.CreatedTimestamp = [Soap getNodeValue: node withName: @"CreatedTimestamp"];
        self.UpdatedTimestamp = [Soap getNodeValue: node withName: @"UpdatedTimestamp"];

    }
    return self;
}

@end
