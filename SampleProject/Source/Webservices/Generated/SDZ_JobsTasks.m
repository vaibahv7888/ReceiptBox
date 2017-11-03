//
//  SDZ_JobsTasks.m
//  expense
//
//  Created by Parveen Sharma on 4/2/15.
//
//

#import "SDZ_JobsTasks.h"

@implementation SDZ_JobsTasks

@synthesize TaskID=_TaskID;
@synthesize ProjectID=_ProjectID;
@synthesize ProjectName=_ProjectName;
@synthesize TaskName=_TaskName;
@synthesize dateFrom,dateTo;
@synthesize projectTaskType;

- (id) init
{
    if(self = [super init])
    {
        self.TaskName = nil;
        self.ProjectID = nil;
        self.TaskID = nil;
        self.ProjectName = nil;
    }
    return self;
}

+ (SDZ_JobsTasks*) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (SDZ_JobsTasks*)[[[SDZ_JobsTasks alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.TaskID = [[Soap getNodeValue: node withName: @"ProjectTaskId"] intValue];
        self.ProjectID = [[Soap getNodeValue: node withName: @"ProjectId"] intValue];
        self.ProjectName = [Soap getNodeValue: node withName: @"ProjectName"];
        self.TaskName = [Soap getNodeValue: node withName: @"ProjectTask"];
        NSDateFormatter *format=[[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy-MM-dd"];
        NSString *str=[Soap getNodeValue: node withName: @"StartDate"];
        NSArray *array=[str componentsSeparatedByString:@"T"];
        NSDate *date=[format dateFromString:[array objectAtIndex:0]];
        self.dateFrom = date;
        NSString *str1=[Soap getNodeValue: node withName: @"EndDate"];
        NSArray *array1=[str1 componentsSeparatedByString:@"T"];
        NSDate *date1=[format dateFromString:[array1 objectAtIndex:0]];
        self.dateTo = date1;
        self.projectTaskType = [Soap getNodeValue: node withName: @"ProjectTaskType"];

    }
    return self;
}



@end
