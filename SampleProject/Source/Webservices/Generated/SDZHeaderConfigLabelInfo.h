
/*
 SDZHeaderConfigLabelInfo.h
 The interface definition of properties and methods for the SDZHeaderConfigLabelInfo object.
 Generated by SudzC.com
 */

#import "Soap.h"


@interface SDZHeaderConfigLabelInfo : SoapObject
{
	NSString* _ConfigLabel;
	NSString* _ConfigLabelKey;
	BOOL _EnforceValidation;
	BOOL _IsEnabled;
	BOOL _IsMandatory;
	int _TravelTypeId;
	
}

@property (retain, nonatomic) NSString* ConfigLabel;
@property (retain, nonatomic) NSString* ConfigLabelKey;
@property BOOL EnforceValidation;
@property BOOL IsEnabled;
@property BOOL IsMandatory;
@property int TravelTypeId;

+ (SDZHeaderConfigLabelInfo*) createWithNode: (CXMLNode*) node;
- (id) initWithNode: (CXMLNode*) node;
- (NSMutableString*) serialize;
- (NSMutableString*) serialize: (NSString*) nodeName;
- (NSMutableString*) serializeAttributes;
- (NSMutableString*) serializeElements;

@end