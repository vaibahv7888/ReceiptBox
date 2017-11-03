//
//  SDZService_GetMileageAddress.h
//  expense
//
//  Created by Praveen on 07/09/14.
//
//

#import "Soap.h"

#import "SDZEntityObject.h"
@class SDZEntityObject;


@interface SDZService_GetMileageAddress : SDZEntityObject{
    
    NSString    *Address;
	NSString    *AddressDesc;
    int          MileageAddressId;
    
}

@property (retain, nonatomic) NSString *Address;
@property (retain, nonatomic) NSString* AddressDesc;
@property (nonatomic)          int          MileageAddressId;


+ (SDZService_GetMileageAddress *) newWithNode: (CXMLNode*) node;
- (id) initWithNode: (CXMLNode*) node;
- (NSMutableString*) serialize;
- (NSMutableString*) serialize: (NSString*) nodeName;
- (NSMutableString*) serializeAttributes;
- (NSMutableString*) serializeElements;

@end