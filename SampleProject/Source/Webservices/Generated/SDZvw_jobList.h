//
//  SDZvw_jobList.h
//  expense
//
//  Created by praveen chellenkula on 09/08/13.
//
//


#import "Soap.h"

#import "SDZEntityObject.h"
@class SDZEntityObject;


@interface SDZvw_jobList : SDZEntityObject
{

	NSString* ProjectTask, *ProjectNumberID, *ProjectNumber;

}

@property (retain, nonatomic) NSString* ProjectTask, *ProjectNumberID, *ProjectNumber;

@property (nonatomic,strong) NSDate *dateFrom;
@property (nonatomic,strong) NSDate *dateTo;

@property (nonatomic,strong) NSDate *budgetStartDate;
@property (nonatomic,strong) NSDate *budgetEndDate;
@property (assign)           BOOL   isBudgetEnabled;


+ (SDZvw_jobList*) newWithNode: (CXMLNode*) node;
- (id) initWithNode: (CXMLNode*) node;
- (NSMutableString*) serialize;
- (NSMutableString*) serialize: (NSString*) nodeName;
- (NSMutableString*) serializeAttributes;
- (NSMutableString*) serializeElements;

@end
