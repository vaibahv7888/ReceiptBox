//
//  SDZ_TimeSheetList.m
//  expense
//
//  Created by Parveen Sharma on 6/8/15.
//
//

#import "SDZ_TimeSheetList.h"

@implementation SDZ_TimeSheetList

@synthesize StartDate = _StartDate;
@synthesize EndDate = _EndDate;
@synthesize TimesheetHeaderId = _TimesheetHeaderId;
@synthesize TimsheetName = _TimeSheetName;
@synthesize TotalTimesshetHrs = _TotalTimesshetHrs;
@synthesize Status;

- (id) init
{
    if(self = [super init])
    {
        
    }
    return self;
}

+ (SDZ_TimeSheetList *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (SDZ_TimeSheetList*)[[[SDZ_TimeSheetList alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        NSDateFormatter *format=[[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyy-MM-dd"];
        
        NSString *str=[Soap getNodeValue: node withName: @"StartDate"];
        NSArray *array=[str componentsSeparatedByString:@"T"];
        NSDate *date=[format dateFromString:[array objectAtIndex:0]];
        self.StartDate = date;

        NSString *str1=[Soap getNodeValue: node withName: @"EndDate"];
        NSArray *array1=[str1 componentsSeparatedByString:@"T"];
        NSDate *date1=[format dateFromString:[array1 objectAtIndex:0]];
        self.EndDate = date1;
        
        self.TimesheetHeaderId = [[Soap getNodeValue: node withName: @"TimesheetHeaderId"] intValue];
        self.TimsheetName = [Soap getNodeValue: node withName: @"TimsheetName"] ;
        self.TotalTimesshetHrs = [[Soap getNodeValue: node withName: @"TotalTimesshetHrs"]floatValue];
        self.Status=[Soap getNodeValue:node withName:@"Status"];
        
    }
    return self;
}

@end
