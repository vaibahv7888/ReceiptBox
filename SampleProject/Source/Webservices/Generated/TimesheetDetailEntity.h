//
//  TimesheetDetailEntity.h
//  expense
//
//  Created by Parveen Sharma on 6/16/15.
//
//

#import "SDZEntityObject.h"

@interface TimesheetDetailEntity : SDZEntityObject
{
    NSString    *BillingCode;
    NSString    *Customer;
    NSString    *Description;
    NSString    *Misc1Str;
    NSString    *Misc2Str;
    NSString    *Misc3Str;
    NSString    *Project;
    NSString    *ProjectTask;
    NSString    *Time;
    NSDate      *TimeEntryDate;
    NSString    *TimeSheetName;
    NSString    *TimeType;
    NSString    *TimesheetAdditionalId;
    NSString    *TimesheetDetailId;
    NSString    *TimesheetHeaderId;
}

@property (retain, nonatomic) NSString *BillingCode;
@property (retain, nonatomic) NSString *Customer;
@property (retain, nonatomic) NSString *Description;
@property (retain, nonatomic) NSString *Misc1Str;
@property (retain, nonatomic) NSString *Misc2Str;
@property (retain, nonatomic) NSString *Misc3Str;
@property (retain, nonatomic) NSString *Project;
@property (retain, nonatomic) NSString *ProjectTask;
@property (retain, nonatomic) NSString *Time;
@property (retain, nonatomic) NSDate   *TimeEntryDate;
@property (retain, nonatomic) NSString *TimeSheetName;
@property (retain, nonatomic) NSString *TimeType;
@property (retain, nonatomic) NSString *TimesheetAdditionalId;
@property (retain, nonatomic) NSString *TimesheetDetailId;
@property (retain, nonatomic) NSString *TimesheetHeaderId;


+ (TimesheetDetailEntity *) newWithNode: (CXMLNode*) node;
- (id) initWithNode: (CXMLNode*) node;
@end
