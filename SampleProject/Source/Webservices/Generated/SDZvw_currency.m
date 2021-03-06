/*
	SDZvw_currency.h
	The implementation of properties and methods for the SDZvw_currency object.
	Generated by SudzC.com
*/
#import "SDZvw_currency.h"

@implementation SDZvw_currency
	@synthesize Active = _Active;
	@synthesize Currency = _Currency;
	@synthesize CurrencyId = _CurrencyId;
	@synthesize ERPId = _ERPId;
	@synthesize IsDefault = _IsDefault;

	- (id) init
	{
		if(self = [super init])
		{
			self.Currency = nil;
			self.ERPId = nil;

		}
		return self;
	}

	+ (SDZvw_currency*) newWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return (SDZvw_currency*)[[[SDZvw_currency alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
			self.Active = [[Soap getNodeValue: node withName: @"Active"] boolValue];
			self.Currency = [Soap getNodeValue: node withName: @"Currency"];
			self.CurrencyId = [[Soap getNodeValue: node withName: @"CurrencyId"] intValue];
			self.ERPId = [Soap getNodeValue: node withName: @"ERPId"];
			self.IsDefault = [[Soap getNodeValue: node withName: @"IsDefault"] boolValue];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"vw_currency"];
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
		if (self.Currency != nil) [s appendFormat: @"<Currency>%@</Currency>", [[self.Currency stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		[s appendFormat: @"<CurrencyId>%@</CurrencyId>", [NSString stringWithFormat: @"%i", self.CurrencyId]];
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
		if(object != nil && [object isKindOfClass:[SDZvw_currency class]]) {
			return [[self serialize] isEqualToString:[object serialize]];
		}
		return NO;
	}
	
	-(NSUInteger)hash{
		return [Soap generateHash:self];

	}
	
	- (void) dealloc
	{
		if(self.Currency != nil) { [self.Currency release]; }
		if(self.ERPId != nil) { [self.ERPId release]; }
		[super dealloc];
	}

@end
