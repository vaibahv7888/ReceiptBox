//
//  SDZvw_ GetApplicationConfigLables.h
//  expense
//
//  Created by praveen chellenkula on 07/04/13.
//
//

#import "Soap.h"

#import "SDZEntityObject.h"
@class SDZEntityObject;


@interface SDZvw_GetApplicationConfigLables : SDZEntityObject
{
    
	NSString    *ConfigLabelId;
    NSString    *ConfigLabelKey;
    NSString    *ConfigLabelValue;
}

@property (retain, nonatomic) NSString *ConfigLabelId;
@property (retain, nonatomic) NSString* ConfigLabelKey;
@property (retain, nonatomic) NSString* ConfigLabelValue;


+ (SDZvw_GetApplicationConfigLables *) newWithNode: (CXMLNode*) node;
- (id) initWithNode: (CXMLNode*) node;
- (NSMutableString*) serialize;
- (NSMutableString*) serialize: (NSString*) nodeName;
- (NSMutableString*) serializeAttributes;
- (NSMutableString*) serializeElements;

@end