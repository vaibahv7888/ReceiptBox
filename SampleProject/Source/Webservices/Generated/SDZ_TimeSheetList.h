//
//  SDZ_TimeSheetList.h
//  expense
//
//  Created by Parveen Sharma on 6/8/15.
//
//

#import "SDZEntityObject.h"

@interface SDZ_TimeSheetList : SDZEntityObject
{
    NSDate      *StartDate;
    NSDate      *EndDate;
    int         TimesheetHeaderId;
    NSString    *TimsheetName;
    float         TotalTimesshetHrs;
}

@property (retain, nonatomic) NSDate *StartDate;
@property (retain, nonatomic) NSDate *EndDate;
@property (retain, nonatomic) NSString *TimsheetName;
@property float TotalTimesshetHrs;
@property int TimesheetHeaderId;
@property (retain , nonatomic) NSString *Status;

+ (SDZ_TimeSheetList *) newWithNode: (CXMLNode*) node;
- (id) initWithNode: (CXMLNode*) node;

@end
