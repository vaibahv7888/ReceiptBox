/*
	SDZArrayOfvw_state.h
	The implementation of properties and methods for the SDZArrayOfvw_state array.
	Generated by SudzC.com
*/
#import "SDZArrayOfvw_state.h"

#import "SDZvw_state.h";
@implementation SDZArrayOfvw_state

	+ (id) newWithNode: (CXMLNode*) node
	{
		return [[[SDZArrayOfvw_state alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [self init]) {
			for(CXMLElement* child in [node children])
			{
				SDZvw_state* value = [[SDZvw_state newWithNode: child] object];
				if(value != nil) {
					[self addObject: value];
				}
			}
		}
		return self;
	}
	
	+ (NSMutableString*) serialize: (NSArray*) array
	{
		NSMutableString* s = [NSMutableString string];
		for(id item in array) {
			[s appendString: [item serialize: @"vw_state"]];
		}
		return s;
	}
@end
