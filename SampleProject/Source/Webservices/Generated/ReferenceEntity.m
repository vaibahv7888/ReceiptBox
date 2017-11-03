//
//  ReferenceEntity.m
//  expense
//
//  Created by mac on 22/09/16.
//
//

#import "ReferenceEntity.h"

@implementation ReferenceEntity

@synthesize Active;
@synthesize ReferenceId;
@synthesize Code;
@synthesize CreatedByUserId;
@synthesize CreatedTimestamp;
@synthesize Description;
@synthesize IsClosed;
@synthesize IsDefault;
@synthesize UpdatedByUserId;
@synthesize UpdatedTimestamp;

- (id) init
{
    if(self = [super init])
    {
    }
    return self;
}

+ (ReferenceEntity *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (ReferenceEntity*)[[ReferenceEntity alloc] initWithNode: node] ;
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.Active = [[Soap getNodeValue: node withName: @"Active"] boolValue];
        self.Code = [Soap getNodeValue: node withName: @"Code"];
        self.Description = [Soap getNodeValue: node withName: @"Description"];
        self.IsClosed = [[Soap getNodeValue: node withName: @"IsClosed"] boolValue];
        self.IsDefault = [[Soap getNodeValue: node withName: @"IsDefault"] boolValue];
        self.ReferenceId = [[Soap getNodeValue: node withName: @"ReferenceId"] intValue];
        self.CreatedByUserId = [[Soap getNodeValue: node withName: @"CreatedByUserId"] intValue];
        self.UpdatedByUserId = [[Soap getNodeValue: node withName: @"UpdatedByUserId"] intValue];
        self.CreatedTimestamp = [Soap getNodeValue: node withName: @"CreatedTimestamp"];
        self.UpdatedTimestamp = [Soap getNodeValue: node withName: @"UpdatedTimestamp"];
        
    }
    return self;
}

@end
