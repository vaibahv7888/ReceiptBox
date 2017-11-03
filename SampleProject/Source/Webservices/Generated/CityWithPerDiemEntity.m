//
//  CityWithPerDiemEntity.m
//  expense
//
//  Created by Parveen Sharma on 9/14/15.
//
//

#import "CityWithPerDiemEntity.h"

@implementation CityWithPerDiemEntity

@synthesize cityCurrency ;
@synthesize cityId;
@synthesize cityName;
@synthesize perDiemAmount;
@synthesize StartDate;
@synthesize EndDate;

- (id) init
{
    if(self = [super init])
    {
        
    }
    return self;
}

+ (CityWithPerDiemEntity *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (CityWithPerDiemEntity*)[[[CityWithPerDiemEntity alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.cityName = [Soap getNodeValue: node withName: @"City"];
        self.cityCurrency = [Soap getNodeValue: node withName: @"Currency"];
        self.cityId = [[Soap getNodeValue: node withName: @"CityId"] intValue] ;
        self.perDiemAmount = [[Soap getNodeValue: node withName: @"PerDiemAmount"]floatValue];
        
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
