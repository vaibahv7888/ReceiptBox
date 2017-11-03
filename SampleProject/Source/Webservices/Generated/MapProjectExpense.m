//
//  MapProjectExpense.m
//  expense
//
//  Created by Parveen Sharma on 5/18/15.
//
//

#import "MapProjectExpense.h"

@implementation MapProjectExpense
@synthesize isActive=_isActive,ExpenseTypeID=_ExpenseTypeID,ProjectExpenseID=_ProjectExpenseID,ProjectID=_ProjectID,UserID=_UserID;


- (id) init
{
    if(self = [super init])
    {
        self.isActive=nil;
        self.ExpenseTypeID=nil;
        self.ProjectExpenseID=nil;
        self.ProjectID=nil;
        self.UserID=nil;
    }
    return self;
}

+ (MapProjectExpense*) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (MapProjectExpense*)[[[MapProjectExpense alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.isActive = [[Soap getNodeValue: node withName: @"Active"] boolValue];
        self.ExpenseTypeID = [[Soap getNodeValue: node withName: @"ExpenseTypeId"] intValue];
        self.ProjectExpenseID = [[Soap getNodeValue: node withName: @"ProjectExpenseTypeId"] intValue];
        self.ProjectID = [[Soap getNodeValue: node withName: @"ProjectId"] intValue];
        self.UserID = [[Soap getNodeValue: node withName: @"UserId"] intValue];
    }
    return self;
}
@end
