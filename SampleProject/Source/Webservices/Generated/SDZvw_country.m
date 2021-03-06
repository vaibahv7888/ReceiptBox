/*
	SDZvw_country.h
	The implementation of properties and methods for the SDZvw_country object.
	Generated by SudzC.com
*/
#import "SDZvw_country.h"

@implementation SDZvw_country
	@synthesize Active = _Active;
	@synthesize Country = _Country;
	@synthesize CountryId = _CountryId;
	@synthesize ERPId = _ERPId;
	@synthesize IsDefault = _IsDefault;

	- (id) init
	{
		if(self = [super init])
		{
			self.Country = nil;
			self.ERPId = nil;

		}
		return self;
	}

	+ (SDZvw_country*) newWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return (SDZvw_country*)[[[SDZvw_country alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
			self.Active = [[Soap getNodeValue: node withName: @"Active"] boolValue];
			self.Country = [Soap getNodeValue: node withName: @"Country"];
			self.CountryId = [[Soap getNodeValue: node withName: @"CountryId"] intValue];
			self.ERPId = [Soap getNodeValue: node withName: @"ERPId"];
			self.IsDefault = [[Soap getNodeValue: node withName: @"IsDefault"] boolValue];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"vw_country"];
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
		[s appendFormat: @"<Active>%@</Active>", (self.Active)?@"true":@"false"];
		if (self.Country != nil) [s appendFormat: @"<Country>%@</Country>", [[self.Country stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		[s appendFormat: @"<CountryId>%@</CountryId>", [NSString stringWithFormat: @"%i", self.CountryId]];
		if (self.ERPId != nil) [s appendFormat: @"<ERPId>%@</ERPId>", [[self.ERPId stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		[s appendFormat: @"<IsDefault>%@</IsDefault>", (self.IsDefault)?@"true":@"false"];

		return s;
	}
	
	- (NSMutableString*) serializeAttributes
	{
		NSMutableString* s = [super serializeAttributes];

		return s;
	}
	
	-(BOOL)isEqual:(id)object{
		if(object != nil && [object isKindOfClass:[SDZvw_country class]]) {
			return [[self serialize] isEqualToString:[object serialize]];
		}
		return NO;
	}
	
	-(NSUInteger)hash{
		return [Soap generateHash:self];

	}
	
	- (void) dealloc
	{
		if(self.Country != nil) { [self.Country release]; }
		if(self.ERPId != nil) { [self.ERPId release]; }
		[super dealloc];
	}

@end
