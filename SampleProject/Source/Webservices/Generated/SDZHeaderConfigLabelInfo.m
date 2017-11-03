//
//  SDZHeaderConfigLabelInfo.m
//  expense
//
//  Created by praveen chellenkula on 24/12/13.
//
//

#import "SDZHeaderConfigLabelInfo.h"

@implementation SDZHeaderConfigLabelInfo

@synthesize ConfigLabel = _ConfigLabel;
@synthesize ConfigLabelKey = _ConfigLabelKey;
@synthesize EnforceValidation = _EnforceValidation;
@synthesize IsEnabled = _IsEnabled;
@synthesize IsMandatory  = _IsMandatory;
@synthesize TravelTypeId = _TravelTypeId;

- (id) init
{
    if(self = [super init])
    {
        self.ConfigLabel = nil;
        self.ConfigLabelKey = nil;
     
        
    }
    return self;
}

+ (SDZHeaderConfigLabelInfo*) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (SDZHeaderConfigLabelInfo*)[[[SDZHeaderConfigLabelInfo alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.ConfigLabel = [Soap getNodeValue: node withName: @"ConfigLabel"];
        self.ConfigLabelKey = [Soap getNodeValue: node withName: @"ConfigLabelKey"];

        self.EnforceValidation = [[Soap getNodeValue: node withName: @"EnforceValidation"] boolValue];
        self.IsEnabled = [[Soap getNodeValue: node withName: @"IsEnabled"] boolValue];
        self.IsMandatory = [[Soap getNodeValue: node withName: @"IsMandatory"] boolValue];
        self.TravelTypeId = [[Soap getNodeValue: node withName: @"TravelTypeId"] intValue];
    }
    return self;
}

- (NSMutableString*) serialize
{
    return [self serialize: @"HeaderConfigLabelInfo"];
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
    
    if (self.ConfigLabel != nil) [s appendFormat: @"<ConfigLabel>%@</ConfigLabel>", [[self.ConfigLabel stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
    
    if (self.ConfigLabelKey != nil) [s appendFormat: @"<ConfigLabelKey>%@</ConfigLabelKey>", [[self.ConfigLabelKey stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
    
    [s appendFormat: @"<EnforceValidation>%@</EnforceValidation>", (self.EnforceValidation)?@"true":@"false"];
    [s appendFormat: @"<IsEnabled>%@</IsEnabled>", (self.IsEnabled)?@"true":@"false"];
    [s appendFormat: @"<IsMandatory>%@</IsMandatory>", (self.IsMandatory)?@"true":@"false"];
    [s appendFormat: @"<TravelTypeId>%d</TravelTypeId>", self.TravelTypeId];
    
    return s;
}

- (NSMutableString*) serializeAttributes
{
    NSMutableString* s = [super serializeAttributes];
    
    return s;
}

-(BOOL)isEqual:(id)object{
    if(object != nil && [object isKindOfClass:[SDZHeaderConfigLabelInfo class]]) {
        return [[self serialize] isEqualToString:[object serialize]];
    }
    return NO;
}

-(NSUInteger)hash{
    return [Soap generateHash:self];
    
}

- (void) dealloc
{
    if(self.ConfigLabel != nil) { [self.ConfigLabel release]; }
    if(self.ConfigLabelKey != nil) { [self.ConfigLabelKey release]; }

    [super dealloc];
}


@end
