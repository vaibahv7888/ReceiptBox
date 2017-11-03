/*
 SDZFileTransferRequestBuf.h
 The interface definition of properties and methods for the SDZFileTransferRequestBuf object.
 Generated by SudzC.com
 */

#import "Soap.h";


@interface SDZFileTransferRequestBuf : SoapObject
{
	NSString* _FileName;
	NSString* _UploadFolder;
	NSData* _binaryBuffer;
	
}

@property (retain, nonatomic) NSString* FileName;
@property (retain, nonatomic) NSString* UploadFolder;
@property (retain, nonatomic) NSData* binaryBuffer;

+ (SDZFileTransferRequestBuf*) newWithNode: (CXMLNode*) node;
- (id) initWithNode: (CXMLNode*) node;
- (NSMutableString*) serialize;
- (NSMutableString*) serialize: (NSString*) nodeName;
- (NSMutableString*) serializeAttributes;
- (NSMutableString*) serializeElements;

@end
