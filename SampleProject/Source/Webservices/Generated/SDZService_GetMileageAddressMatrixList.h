//
//  SDZService_GetMileageAddressMatrixList.h
//  expense
//
//  Created by Praveen on 09/09/14.
//
//

#import "Soap.h"

#import "SDZEntityObject.h"
@class SDZEntityObject;

@interface SDZService_GetMileageAddressMatrixList : SDZEntityObject{
    
    NSString    *MileageAddressTo;
	NSString    *MileageAddressFrom;
    int          MileageAddressMatrixId, MileageAddressFromId, MileageAddressToId;
    float       Distance;
    
}

@property (retain, nonatomic) NSString *MileageAddressTo;
@property (retain, nonatomic) NSString* MileageAddressFrom;
@property (nonatomic)          int          MileageAddressMatrixId , MileageAddressFromId, MileageAddressToId;
@property (nonatomic)           float       Distance;

+ (SDZService_GetMileageAddressMatrixList *) newWithNode: (CXMLNode*) node;
- (id) initWithNode: (CXMLNode*) node;
- (NSMutableString*) serialize;
- (NSMutableString*) serialize: (NSString*) nodeName;
- (NSMutableString*) serializeAttributes;
- (NSMutableString*) serializeElements;

@end