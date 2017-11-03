//
//  SDZService_GetSettings.m
//  expense
//
//  Created by Praveen on 30/07/14.
//
//

#import "SDZService_GetSettings.h"

@implementation SDZService_GetSettings

@synthesize SettingKey = _SettingKey;
@synthesize SettingValue = _SettingValue;




- (id) init
{
    if(self = [super init])
    {
        self.SettingValue = nil;
        
    }
    return self;
}

+ (SDZService_GetSettings *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (SDZService_GetSettings *)[[[SDZService_GetSettings alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.SettingKey = [Soap getNodeValue: node withName: @"SettingKey"];
        self.SettingValue = [Soap getNodeValue: node withName: @"SettingValue"];
      
        
    }
    return self;
}

- (NSMutableString*) serialize
{
    return [self serialize: @"vw_ConfigInfo"];
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
    [s appendFormat: @"<SettingKey>%@</SettingKey>", self.SettingKey];
    if (self.SettingValue != nil) [s appendFormat: @"<SettingValue>%@</SettingValue>", [[self.SettingValue stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
    
    
    return s;
}

- (NSMutableString*) serializeAttributes
{
    NSMutableString* s = [super serializeAttributes];
    
    return s;
}

-(BOOL)isEqual:(id)object{
    if(object != nil && [object isKindOfClass:[SDZService_GetSettings class]]) {
        return [[self serialize] isEqualToString:[object serialize]];
    }
    return NO;
}

-(NSUInteger)hash{
    return [Soap generateHash:self];
    
}

- (void) dealloc
{
    if(self.SettingValue != nil) { [self.SettingValue release]; }
    [super dealloc];
}


@end
