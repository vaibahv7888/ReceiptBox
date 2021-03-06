/*
	SDZvw_vendor.h
	The implementation of properties and methods for the SDZvw_vendor object.
	Generated by SudzC.com
*/
#import "SDZvw_vendor.h"

@implementation SDZvw_vendor
	@synthesize Active = _Active;
	@synthesize VendorId = _VendorId;
	@synthesize VendorName = _VendorName;

	- (id) init
	{
		if(self = [super init])
		{
			self.VendorName = nil;

		}
		return self;
	}

	+ (SDZvw_vendor*) newWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return (SDZvw_vendor*)[[[SDZvw_vendor alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
			self.Active = [[Soap getNodeValue: node withName: @"Active"] intValue];
			self.VendorId = [[Soap getNodeValue: node withName: @"VendorId"] intValue];
			self.VendorName = [Soap getNodeValue: node withName: @"VendorName"];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"vw_vendor"];
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
		[s appendFormat: @"<Active>%@</Active>", [NSString stringWithFormat: @"%i", self.Active]];
		[s appendFormat: @"<VendorId>%@</VendorId>", [NSString stringWithFormat: @"%i", self.VendorId]];
		if (self.VendorName != nil) [s appendFormat: @"<VendorName>%@</VendorName>", [[self.VendorName stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];

		return s;
	}
	
	- (NSMutableString*) serializeAttributes
	{
		NSMutableString* s = [super serializeAttributes];

		return s;
	}
	
	-(BOOL)isEqual:(id)object{
		if(object != nil && [object isKindOfClass:[SDZvw_vendor class]]) {
			return [[self serialize] isEqualToString:[object serialize]];
		}
		return NO;
	}
	
	-(NSUInteger)hash{
		return [Soap generateHash:self];

	}
	
	- (void) dealloc
	{
		if(self.VendorName != nil) { [self.VendorName release]; }
		[super dealloc];
	}

@end
