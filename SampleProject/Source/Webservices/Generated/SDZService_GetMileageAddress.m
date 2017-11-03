//
//  SDZService_GetMileageAddress.m
//  expense
//
//  Created by Praveen on 07/09/14.
//
//

#import "SDZService_GetMileageAddress.h"

@implementation SDZService_GetMileageAddress

@synthesize Address = _Address;
@synthesize AddressDesc = _AddressDesc;
@synthesize MileageAddressId = _MileageAddressId;




- (id) init
{
    if(self = [super init])
    {
        self.Address = nil;
        self.AddressDesc = nil;
        
    }
    return self;
}

+ (SDZService_GetMileageAddress *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (SDZService_GetMileageAddress *)[[[SDZService_GetMileageAddress alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.Address = [Soap getNodeValue: node withName: @"Address"];
        self.AddressDesc = [Soap getNodeValue: node withName: @"AddressDesc"];
        self.MileageAddressId = [[Soap getNodeValue: node withName: @"MileageAddressId"] intValue];

        
    }
    return self;
}

- (NSMutableString*) serialize
{
    return [self serialize: @"Service_GetMileageAddress"];
}

- (NSMutableString*) serialize: (NSString*) nodeName
{
    NSMutableString* s = [[NSMutableString alloc] init];
    [s appendFormat: @"<%@", nodeName];
    [s appendString: [self serializeAttributes]];
    [s appendString: @">"];
    [s appendString: [self serializeElements]];
    [s appendFormat: @"</%@>", nodeName];
    return [s autorelease];
}

- (NSMutableString*) serializeElements
{
    NSMutableString* s = [super serializeElements];
    [s appendFormat: @"<Address>%@</Address>", self.Address];
    [s appendFormat: @"<AddressDesc>%@</AddressDesc>", self.AddressDesc];
	[s appendFormat: @"<MileageAddressId>%@</MileageAddressId>", [NSString stringWithFormat: @"%i", self.MileageAddressId]];
    
    return s;
}

- (NSMutableString*) serializeAttributes
{
    NSMutableString* s = [super serializeAttributes];
    
    return s;
}

-(BOOL)isEqual:(id)object{
    if(object != nil && [object isKindOfClass:[SDZService_GetMileageAddress class]]) {
        return [[self serialize] isEqualToString:[object serialize]];
    }
    return NO;
}

-(NSUInteger)hash{
    return [Soap generateHash:self];
    
}

- (void) dealloc
{
    if(self.Address != nil) { [self.Address release]; }
    if(self.AddressDesc != nil) { [self.AddressDesc release]; }

    [super dealloc];
}


@end
