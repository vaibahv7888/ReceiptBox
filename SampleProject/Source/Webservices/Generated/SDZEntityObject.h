/*
	SDZEntityObject.h
	The interface definition of properties and methods for the SDZEntityObject object.
	Generated by SudzC.com
*/

#import "Soap.h";
	
@class SDZEntityKey;
#import "SDZStructuralObject.h"
@class SDZStructuralObject;


@interface SDZEntityObject : SDZStructuralObject
{
	SDZEntityKey* _EntityKey;
	
}
		
	@property (retain, nonatomic) SDZEntityKey* EntityKey;

	+ (SDZEntityObject*) newWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
