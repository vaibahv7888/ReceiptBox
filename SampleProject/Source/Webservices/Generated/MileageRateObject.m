//
//  MileageRateObject.m
//  expense
//
//  Created by Parveen Sharma on 11/24/15.
//
//

#import "MileageRateObject.h"

@implementation MileageRateObject
@synthesize MileageRateID;
@synthesize StartDate;
@synthesize EndDate;
@synthesize MilageRate;


+ (MileageRateObject *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (MileageRateObject*)[[MileageRateObject alloc] initWithNode: node] ;
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.MileageRateID = [[Soap getNodeValue: node withName: @"MileageRateDataId"] intValue] ;
        self.MilageRate = [[Soap getNodeValue: node withName: @"MileageRate"] floatValue] ;
        
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
