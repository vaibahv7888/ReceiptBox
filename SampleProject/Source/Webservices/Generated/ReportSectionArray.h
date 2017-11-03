//
//  ReportSectionArray.h
//  expense
//
//  Created by mac on 28/03/16.
//
//

#import "SoapArray.h"

@interface ReportSectionArray : SoapArray
- (id) initWithNode: (CXMLNode*) node withReportId:(NSNumber *)reportID;

@end
