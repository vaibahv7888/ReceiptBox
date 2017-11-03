//
//  UnApproveReportEntity.h
//  expense
//
//  Created by Parveen Sharma on 9/22/15.
//
//

#import "SDZEntityObject.h"

@interface UnApproveReportEntity : SDZEntityObject

@property int                            URExpenseId;
@property float                          SubTotal;
@property float                          TotalReimbursable;

@property (nonatomic,strong) NSString   *Currency;
@property (nonatomic,strong) NSString   *ReportName;
@property (nonatomic,strong) NSString   *UserName;
@property (nonatomic,strong) NSString   *Status;
@property (nonatomic,strong) NSString   *StatusCategory;
@property (nonatomic,strong) NSString   *ExpenseConfNo;

@property (nonatomic,strong) NSDate     *StartDate;
@property (nonatomic,strong) NSDate     *EndDate;

+ (UnApproveReportEntity*) newWithNode: (CXMLNode*) node;
- (id) initWithNode: (CXMLNode*) node;

@end
