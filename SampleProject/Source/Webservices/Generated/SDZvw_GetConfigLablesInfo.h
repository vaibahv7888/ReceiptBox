#import "Soap.h"

#import "SDZEntityObject.h"
@class SDZEntityObject;


@interface SDZvw_GetConfigLablesInfo : SDZEntityObject
{
    
	NSString    *ConfigLabelId;
    NSString    *ConfigLabel;
    BOOL        IsMadatory;
	BOOL        IsAddToAmount;
    BOOL        IsMultipliedByAmount;
    NSString    *DataType;
}

@property (retain, nonatomic) NSString *ConfigLabelId;
@property (retain, nonatomic) NSString* ConfigLabel;
@property (retain, nonatomic) NSString* ConfigLabelKey;
@property BOOL IsMadatory;
@property BOOL IsAddToAmount;
@property BOOL IsMultipliedByAmount;
@property (retain, nonatomic) NSString* DataType;


+ (SDZvw_GetConfigLablesInfo *) newWithNode: (CXMLNode*) node;
- (id) initWithNode: (CXMLNode*) node;
- (NSMutableString*) serialize;
- (NSMutableString*) serialize: (NSString*) nodeName;
- (NSMutableString*) serializeAttributes;
- (NSMutableString*) serializeElements;

@end