//
//  ReportsListEntity.h
//  expense
//
//  Created by mac on 05/01/16.
//
//

#import "SDZEntityObject.h"

@interface ReportsListEntity : SDZEntityObject

@property (nonatomic,strong) NSString   *Currency;
@property (nonatomic,strong) NSDate     *EndDate;
@property (nonatomic,strong) NSDate     *StartDate;
@property (nonatomic,strong) NSString   *ExpenseConfNo;
@property                         int   ExpenseId;
@property (nonatomic,strong) NSString   *ReportName;
@property (nonatomic,strong) NSString   *Status;
@property (nonatomic,strong) NSString   *StatusCategory;
@property                       float   SubTotal;
@property                       float   TotalReimbursable;
@property (nonatomic,strong) NSString   *UserFullName;
@property (nonatomic,strong) NSString   *ReportType;
@property                         int   ReportTypeId;
@property (nonatomic,strong) NSString   *ReferenceNumber;
@property (nonatomic,strong) NSString   *ProjectNumber;
@property (nonatomic,strong) NSString   *NetworkNumber;
@property                        BOOL   IsSubmitted;
@property (nonatomic,strong) NSString   *Comments;
@property (nonatomic,strong) NSString   *AdditionalComments;
@property (nonatomic,strong) NSString   *CashInAdvance;
@property (nonatomic,strong) NSString   *ReceiptPath;
@property (nonatomic,strong) NSString   *ReviewerRemarks;

@end
