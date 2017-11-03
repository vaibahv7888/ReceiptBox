//
//  UnApproveReportEntity.m
//  expense
//
//  Created by Parveen Sharma on 9/22/15.
//
//

#import "UnApproveReportEntity.h"

@implementation UnApproveReportEntity

@synthesize URExpenseId;
@synthesize SubTotal;
@synthesize TotalReimbursable;
@synthesize Currency;
@synthesize ReportName;
@synthesize UserName;
@synthesize Status;
@synthesize StatusCategory;
@synthesize StartDate;
@synthesize EndDate;
@synthesize ExpenseConfNo;

- (id) init
{
    if(self = [super init])
    {
        
    }
    return self;
}

+ (UnApproveReportEntity *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (UnApproveReportEntity*)[[[UnApproveReportEntity alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.URExpenseId = [[Soap getNodeValue: node withName: @"ExpenseId"] intValue] ;
        self.SubTotal = [[Soap getNodeValue: node withName: @"SubTotal"] floatValue] ;
        self.TotalReimbursable = [[Soap getNodeValue: node withName: @"TotalReimbursable"] floatValue] ;
        
        self.Currency = [Soap getNodeValue: node withName: @"Currency"];
        self.ReportName = [Soap getNodeValue: node withName: @"ReportName"];
        self.UserName = [Soap getNodeValue: node withName: @"UserFullName"];
        self.Status = [Soap getNodeValue: node withName: @"Status"];
        self.StatusCategory = [Soap getNodeValue: node withName: @"StatusCategory"];
        self.ExpenseConfNo = [Soap getNodeValue: node withName: @"ExpenseConfNo"];
        
        NSDateFormatter *format=[[NSDateFormatter alloc]init];
        [format setDateFormat:@"YYYY-MM-dd"];
        
        NSString *str=[Soap getNodeValue: node withName: @"StartDate"];
        NSArray *array=[str componentsSeparatedByString:@"T"];
        NSDate *date=[format dateFromString:[array objectAtIndex:0]];
        self.StartDate = date ;
        
        
        NSString *str1=[Soap getNodeValue: node withName: @"EndDate"];
        NSArray *array1=[str1 componentsSeparatedByString:@"T"];
        NSDate *date1=[format dateFromString:[array1 objectAtIndex:0]];
        self.EndDate = date1 ;
        
        
    }
    return self;
}

@end
