//
//  ApproverEntity.m
//  expense
//
//  Created by mac on 22/09/16.
//
//

#import "ApproverEntity.h"

@implementation ApproverEntity

@synthesize Active;
@synthesize FullName;
@synthesize IsDefaultManager;
@synthesize IsReportOnly;
@synthesize ManagerId;
@synthesize ProjectId;

- (id) init
{
    if(self = [super init])
    {
    }
    return self;
}

+ (ApproverEntity *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (ApproverEntity*)[[ApproverEntity alloc] initWithNode: node] ;
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.Active = [[Soap getNodeValue: node withName: @"Active"] boolValue];
        self.FullName = [Soap getNodeValue: node withName: @"FullName"];
        self.IsDefaultManager = [[Soap getNodeValue: node withName: @"IsDefaultManager"] boolValue];
        self.IsReportOnly = [[Soap getNodeValue: node withName: @"IsReportOnly"] boolValue];
        self.ManagerId = [[Soap getNodeValue: node withName: @"ManagerId"] intValue];
        self.ProjectId = [[Soap getNodeValue: node withName: @"ProjectId"] intValue];
       
    }
    return self;
}

@end
