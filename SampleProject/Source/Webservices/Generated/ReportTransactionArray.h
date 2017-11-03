//
//  ReportTransactionArray.h
//  expense
//
//  Created by mac on 30/03/16.
//
//

#import "SoapArray.h"

@interface ReportTransactionArray : SoapArray
- (id) initWithNode: (CXMLNode*) node withReportId:(NSNumber *)reportID;

@end
