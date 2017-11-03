//
//  ReportsListEntity.m
//  expense
//
//  Created by mac on 05/01/16.
//
//

#import "ReportsListEntity.h"
#import "ReportsListEntity.h"

@implementation ReportsListEntity

@synthesize Currency;
@synthesize EndDate;
@synthesize StartDate;
@synthesize ExpenseConfNo;
@synthesize ExpenseId;
@synthesize ReportName;
@synthesize Status;
@synthesize StatusCategory;
@synthesize SubTotal;
@synthesize TotalReimbursable;
@synthesize UserFullName;
@synthesize ReportType;
@synthesize ReportTypeId;
@synthesize ReferenceNumber;
@synthesize ProjectNumber;
@synthesize NetworkNumber;
@synthesize IsSubmitted;
@synthesize Comments;
@synthesize AdditionalComments;
@synthesize CashInAdvance;
@synthesize ReceiptPath;
@synthesize ReviewerRemarks;
- (id) init
{
    if(self = [super init])
    {
    }
    return self;
}

+ (ReportsListEntity *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (ReportsListEntity*)[[ReportsListEntity alloc] initWithNode: node] ;
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.Currency = [Soap getNodeValue: node withName: @"Currency"];
        self.ExpenseConfNo = [Soap getNodeValue: node withName: @"ExpenseConfNo"];
        self.ExpenseId = [[Soap getNodeValue: node withName: @"ExpenseId"] intValue];
        self.ReportName = [Soap getNodeValue: node withName: @"ReportName"];
        self.Status = [Soap getNodeValue: node withName: @"Status"];
        self.StatusCategory = [Soap getNodeValue: node withName: @"StatusCategory"];
        self.SubTotal = [[Soap getNodeValue: node withName: @"SubTotal"] floatValue];
        self.TotalReimbursable = [[Soap getNodeValue: node withName: @"TotalReimbursable"] floatValue];
        self.UserFullName = [Soap getNodeValue: node withName: @"UserFullName"];
        self.ReportType = [Soap getNodeValue: node withName: @"ReportType"];
        self.ReceiptPath = [Soap getNodeValue: node withName: @"ReceiptPath"];
        if (self.ReportName==nil) {
            self.ReportName = [Soap getNodeValue: node withName: @"ExpenseReportName"];
        }
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
        
        self.ReportTypeId = [[Soap getNodeValue: node withName: @"ReportTypeId"] intValue];
        self.ReferenceNumber = [Soap getNodeValue: node withName: @"ReferenceNumber"];
        self.ProjectNumber = [Soap getNodeValue: node withName: @"ProjectNumber"];
        self.NetworkNumber = [Soap getNodeValue: node withName: @"NetworkNumber"];
        self.IsSubmitted= [[Soap getNodeValue: node withName: @"IsSubmitted"] boolValue];
        self.Comments = [Soap getNodeValue: node withName: @"Comments"];
        self.AdditionalComments = [Soap getNodeValue: node withName: @"AdditionalComments"];
        self.CashInAdvance = [Soap getNodeValue: node withName: @"CashInAdvance"];
        self.ReviewerRemarks = [Soap getNodeValue: node withName: @"ReviewerRemark"];

    }
    return self;
}


@end
