//
//  SDZvw_classList.m
//  expense
//
//  Created by praveen chellenkula on 05/01/14.
//
//

#import "SDZvw_Class.h"

@implementation SDZvw_Class



@synthesize NetworkNumber;
@synthesize NetworkNumberId = _NetworkNumberId;


- (id) init
{
    if(self = [super init])
    {
        self.NetworkNumber = nil;
        
    }
    return self;
}

+ (SDZvw_Class*) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (SDZvw_Class*)[[[SDZvw_Class alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.NetworkNumber = [Soap getNodeValue: node withName: @"NetworkNumber"];
        self.NetworkNumberId = [[Soap getNodeValue: node withName: @"NetworkNumberId"] intValue];
        
    }
    return self;
}

- (NSMutableString*) serialize
{
    return [self serialize: @"vw_Class"];
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
    
    if (self.NetworkNumber != nil){
        [s appendFormat: @"<NetworkNumber>%@</NetworkNumber>", [[self.NetworkNumber stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
    }
    [s appendFormat: @"<NetworkNumberId>%@</NetworkNumberId>", [NSString stringWithFormat: @"%i", self.NetworkNumberId]];
    
    
    
    
    return s;
}

- (NSMutableString*) serializeAttributes
{
    NSMutableString* s = [super serializeAttributes];
    
    return s;
}

-(BOOL)isEqual:(id)object{
    if(object != nil && [object isKindOfClass:[SDZvw_Class class]]) {
        return [[self serialize] isEqualToString:[object serialize]];
    }
    return NO;
}

-(NSUInteger)hash{
    return [Soap generateHash:self];
    
}

- (void) dealloc
{
    if(self.NetworkNumber != nil) { [self.NetworkNumber release]; }
    [super dealloc];
}



@end
