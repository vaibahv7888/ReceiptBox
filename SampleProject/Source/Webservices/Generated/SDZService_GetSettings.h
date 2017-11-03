//
//  SDZService_GetSettings.h
//  expense
//
//  Created by Praveen on 30/07/14.
//
//

#import "Soap.h"

#import "SDZEntityObject.h"
@class SDZEntityObject;

@interface SDZService_GetSettings : SDZEntityObject{
    
	NSString    *SettingKey;
    NSString    *SettingValue;
   
}

@property (retain, nonatomic) NSString *SettingKey;
@property (retain, nonatomic) NSString* SettingValue;



+ (SDZService_GetSettings *) newWithNode: (CXMLNode*) node;
- (id) initWithNode: (CXMLNode*) node;
- (NSMutableString*) serialize;
- (NSMutableString*) serialize: (NSString*) nodeName;
- (NSMutableString*) serializeAttributes;
- (NSMutableString*) serializeElements;

@end