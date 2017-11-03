//
//  TimesheetDetailEntity.m
//  expense
//
//  Created by Parveen Sharma on 6/16/15.
//
//

#import "TimesheetDetailEntity.h"

@implementation TimesheetDetailEntity

@synthesize BillingCode;
@synthesize Customer;
@synthesize Description;
@synthesize Misc1Str;
@synthesize Misc2Str;
@synthesize Misc3Str;
@synthesize Project;
@synthesize ProjectTask;
@synthesize Time;
@synthesize TimeEntryDate;
@synthesize TimeSheetName;
@synthesize TimeType;
@synthesize TimesheetAdditionalId;
@synthesize TimesheetDetailId;
@synthesize TimesheetHeaderId;

- (id) init
{
    if(self = [super init])
    {
        
    }
    return self;
}

+ (TimesheetDetailEntity *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (TimesheetDetailEntity*)[[[TimesheetDetailEntity alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.BillingCode = [Soap getNodeValue: node withName: @"BillingCode"] ;
        self.Customer = [Soap getNodeValue: node withName: @"Customer"] ;
        self.Description = [Soap getNodeValue: node withName: @"Description"] ;
        self.Misc1Str = [Soap getNodeValue: node withName: @"MiscField1"] ;
        self.Misc2Str = [Soap getNodeValue: node withName: @"MiscField2"] ;
        self.Misc3Str = [Soap getNodeValue: node withName: @"MiscField3"] ;
        self.Project = [Soap getNodeValue: node withName: @"Project"] ;
        self.ProjectTask = [Soap getNodeValue: node withName: @"ProjectTask"] ;
        self.Time = [Soap getNodeValue: node withName: @"Time"] ;
        NSDateFormatter *format=[[NSDateFormatter alloc]init];
        [format setDateFormat:@"YYYY-MM-dd"];
        NSString *str=[Soap getNodeValue: node withName: @"TimeEntryDate"];
        NSArray *array=[str componentsSeparatedByString:@"T"];
        NSDate *date=[format dateFromString:[array objectAtIndex:0]];
        self.TimeEntryDate = date ;
        self.TimeSheetName = [Soap getNodeValue: node withName: @"TimesheetName"] ;
        self.TimeType = [Soap getNodeValue: node withName: @"TimeType"] ;
        self.TimesheetAdditionalId = [Soap getNodeValue: node withName: @"TimesheetDetailAdditionalId"] ;
        self.TimesheetDetailId = [Soap getNodeValue: node withName: @"TimesheetDetailId"] ;
        self.TimesheetHeaderId = [Soap getNodeValue: node withName: @"TimesheetHeaderId"] ;
    }
    return self;
}

@end
