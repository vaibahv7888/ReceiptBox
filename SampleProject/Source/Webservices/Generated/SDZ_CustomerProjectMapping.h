//
//  SDZ_CustomerProjectMapping.h
//  expense
//
//  Created by Parveen Sharma on 4/1/15.
//
//

#import "SDZEntityObject.h"

@interface SDZ_CustomerProjectMapping : SDZEntityObject

@property int CustomerID;
@property int ProjectID;


+ (SDZ_CustomerProjectMapping*) newWithNode: (CXMLNode*) node;
- (id) initWithNode: (CXMLNode*) node;
- (NSMutableString*) serialize;
- (NSMutableString*) serialize: (NSString*) nodeName;
- (NSMutableString*) serializeAttributes;
- (NSMutableString*) serializeElements;

@end
