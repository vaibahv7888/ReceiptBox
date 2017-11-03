//
//  SDZReportDetailEntity.h
//  expense
//
//  Created by mac on 28/03/16.
//
//

#import "SDZEntityObject.h"
#import "ReportSectionArray.h"
#import "ReportTransactionArray.h"

@interface SDZReportDetailEntity : SDZEntityObject
@property (strong , nonatomic) NSNumber *reportId;
@property (nonatomic,strong) ReportSectionArray *reportHeaderArray;
@property (nonatomic,strong) ReportSectionArray *reportSummaryArray;
@property (nonatomic,strong) ReportSectionArray *reportFooterArray;
@property (nonatomic,strong) ReportTransactionArray *reportTransactionArray;

- (id) initWithReportID:(NSNumber *)reportId1;

@end
