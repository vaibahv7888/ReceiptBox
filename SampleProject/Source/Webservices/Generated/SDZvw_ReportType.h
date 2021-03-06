/*
 SDZvw_ReportType.h
 The interface definition of properties and methods for the SDZvw_ReportType object.
 Generated by SudzC.com
 */

#import "Soap.h"

#import "SDZEntityObject.h"
@class SDZEntityObject;


@interface SDZvw_ReportType : SDZEntityObject
{
	int _RoleId;
    NSString* _TravelType, *_SubTravelType;
	int _TravelTypeId;
	
}

@property int RoleId;
@property (retain, nonatomic) NSString* TravelType, *SubTravelType;
@property int TravelTypeId;

+ (SDZvw_ReportType*) createWithNode: (CXMLNode*) node;
- (id) initWithNode: (CXMLNode*) node;
- (NSMutableString*) serialize;
- (NSMutableString*) serialize: (NSString*) nodeName;
- (NSMutableString*) serializeAttributes;
- (NSMutableString*) serializeElements;

@end