//
//  ReportHeaderEntity.h
//  expense
//
//  Created by mac on 28/03/16.
//
//

#import "SDZEntityObject.h"

@interface ReportHeaderEntity : SDZEntityObject
@property (nonatomic,strong) NSString   *elementName;
@property (nonatomic,strong) NSString   *elementValue;
@property (nonatomic,strong) NSNumber   *reportId;

+ (ReportHeaderEntity *) newWithNode: (CXMLNode*) node withReportId:(NSNumber *)reportID;

@end
