//
//  SDZvw_ GetApplicationConfigLables.m
//  expense
//
//  Created by praveen chellenkula on 07/04/13.
//
//

#import "SDZvw_GetApplicationConfigLables.h"

@implementation SDZvw_GetApplicationConfigLables

@synthesize ConfigLabelId = _ConfigLabelId;
@synthesize ConfigLabelKey = _ConfigLabelKey;

@synthesize ConfigLabelValue = _ConfigLabelValue;


- (id) init
{
    if(self = [super init])
    {
        self.ConfigLabelKey = nil;
        self.ConfigLabelValue = nil;
        
    }
    return self;
}

+ (SDZvw_GetApplicationConfigLables *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (SDZvw_GetApplicationConfigLables*)[[[SDZvw_GetApplicationConfigLables alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.ConfigLabelId = [Soap getNodeValue: node withName: @"ConfigLabelId"];
        self.ConfigLabelKey = [Soap getNodeValue: node withName: @"ConfigLabelKey"];
        self.ConfigLabelValue = [Soap getNodeValue: node withName: @"ConfigLabelValue"];
    }
    return self;
}

- (NSMutableString*) serialize
{
    return [self serialize: @"vw_GetApplicationConfigLables"];
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
    [s appendFormat: @"<ConfigLabelId>%@</ConfigLabelId>", self.ConfigLabelId];
    if (self.ConfigLabelKey != nil) [s appendFormat: @"<ConfigLabelKey>%@</ConfigLabelKey>", [[self.ConfigLabelKey stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
    
    if (self.ConfigLabelValue != nil) [s appendFormat: @"<ConfigLabelValue>%@</ConfigLabelValue>", [[self.ConfigLabelValue stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
    
    return s;
}

- (NSMutableString*) serializeAttributes
{
    NSMutableString* s = [super serializeAttributes];
    
    return s;
}

-(BOOL)isEqual:(id)object{
    if(object != nil && [object isKindOfClass:[SDZvw_GetApplicationConfigLables class]]) {
        return [[self serialize] isEqualToString:[object serialize]];
    }
    return NO;
}

-(NSUInteger)hash{
    return [Soap generateHash:self];
    
}

- (void) dealloc
{
    if(self.ConfigLabelKey != nil) { [self.ConfigLabelKey release]; }
    if(self.ConfigLabelValue != nil) { [self.ConfigLabelValue release]; }
    [super dealloc];
}


@end