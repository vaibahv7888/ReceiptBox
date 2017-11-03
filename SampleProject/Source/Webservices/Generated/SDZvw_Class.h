//
//  SDZvw_classList.h
//  expense
//
//  Created by praveen chellenkula on 05/01/14.
//
//

#import "Soap.h"

#import "SDZEntityObject.h"
@class SDZEntityObject;

@interface SDZvw_Class : SDZEntityObject
{
	NSString* _NetworkNumber;
	int _NetworkNumberId;
	
}

@property (retain, nonatomic) NSString* NetworkNumber;
@property int NetworkNumberId;

+ (SDZvw_Class*) createWithNode: (CXMLNode*) node;
- (id) initWithNode: (CXMLNode*) node;
- (NSMutableString*) serialize;
- (NSMutableString*) serialize: (NSString*) nodeName;
- (NSMutableString*) serializeAttributes;
- (NSMutableString*) serializeElements;

@end