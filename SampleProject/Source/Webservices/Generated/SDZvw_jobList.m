//
//  SDZvw_jobList.m
//  expense
//
//  Created by praveen chellenkula on 09/08/13.
//
//

#import "SDZvw_jobList.h"

@implementation SDZvw_jobList

@synthesize ProjectNumberID, ProjectNumber;
@synthesize ProjectTask;
@synthesize dateFrom,dateTo;

@synthesize budgetStartDate,budgetEndDate,isBudgetEnabled;

- (id) init
{
    if(self = [super init])
    {
        self.ProjectTask = nil;
        
    }
    return self;
}

+ (SDZvw_jobList*) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (SDZvw_jobList*)[[[SDZvw_jobList alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.ProjectNumberID = [Soap getNodeValue: node withName: @"ProjectNumberId"];
        self.ProjectNumber = [Soap getNodeValue: node withName: @"ProjectNumber"];
        self.ProjectTask = [Soap getNodeValue: node withName: @"ProjectTask"];
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
        NSString *str2=[Soap getNodeValue: node withName: @"BudgetPeriodStartDate"];
        NSArray *array2=[str2 componentsSeparatedByString:@"T"];
        NSDate *date2=[format dateFromString:[array2 objectAtIndex:0]];
        self.budgetStartDate = date2;
        NSString *str3=[Soap getNodeValue: node withName: @"BudgetPeriodEndDate"];
        NSArray *array3=[str3 componentsSeparatedByString:@"T"];
        NSDate *date3=[format dateFromString:[array3 objectAtIndex:0]];
        self.budgetEndDate = date3;
        self.isBudgetEnabled = [[Soap getNodeValue: node withName: @"BudgetIsEnabled"] boolValue];

    }
    return self;
}

- (NSMutableString*) serialize
{
    return [self serialize: @"vw_jobList"];
}

- (NSMutableString*) serialize: (NSString*) nodeName
{
    NSMutableString* s = [[NSMutableString alloc] init];
    [s appendFormat: @"<%@", nodeName];
    [s appendString: [self serializeAttributes]];
    [s appendString: @">"];
    [s appendString: [self serializeElements]];
    [s appendFormat: @"</%@>", nodeName];
    return [s autorelease];
}

- (NSMutableString*) serializeElements
{
    NSMutableString* s = [super serializeElements];
   
    [s appendFormat: @"<ProjectNumberId>%@</ProjectNumberId>", self.ProjectNumberID];
    [s appendFormat: @"<ProjectNumber>%@</ProjectNumber>", self.ProjectNumber];

    if (self.ProjectTask != nil){
        [s appendFormat: @"<ProjectTask>%@</ProjectTask>", [[self.ProjectTask stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
    }
   
    
    return s;
}

- (NSMutableString*) serializeAttributes
{
    NSMutableString* s = [super serializeAttributes];
    
    return s;
}

-(BOOL)isEqual:(id)object{
    if(object != nil && [object isKindOfClass:[SDZvw_jobList class]]) {
        return [[self serialize] isEqualToString:[object serialize]];
    }
    return NO;
}

-(NSUInteger)hash{
    return [Soap generateHash:self];
    
}

- (void) dealloc
{
    if(self.ProjectTask != nil) { [self.ProjectTask release]; }
    [super dealloc];
}

@end
