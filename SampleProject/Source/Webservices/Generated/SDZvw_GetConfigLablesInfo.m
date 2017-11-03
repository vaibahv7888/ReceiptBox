//
//  SDZArrayOfvw_ConfigInfo.m
//  expense
//
//  Created by praveen chellenkula on 09/03/13.
//
//

#import "SDZvw_GetConfigLablesInfo.h"

@interface SDZvw_GetConfigLablesInfo ()

@end

@implementation SDZvw_GetConfigLablesInfo

@synthesize ConfigLabelId = _ConfigLabelId;
@synthesize ConfigLabel = _ConfigLabel;
@synthesize IsMadatory = _IsMadatory;
@synthesize IsAddToAmount = _IsAddToAmount;
@synthesize IsMultipliedByAmount = _IsMultipliedByAmount;
@synthesize DataType = _DataType;
@synthesize ConfigLabelKey =_ConfigLabelKey;

- (id) init
{
    if(self = [super init])
    {
        self.ConfigLabel = nil;
        self.DataType = nil;
        
    }
    return self;
}

+ (SDZvw_GetConfigLablesInfo *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (SDZvw_GetConfigLablesInfo*)[[[SDZvw_GetConfigLablesInfo alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.ConfigLabelId = [Soap getNodeValue: node withName: @"ConfigLabelId"];
        self.ConfigLabel = [Soap getNodeValue: node withName: @"ConfigLabel"];
        self.IsMadatory = [[Soap getNodeValue: node withName: @"IsMadatory"] boolValue];
        self.IsAddToAmount = [[Soap getNodeValue: node withName: @"IsAddToAmount"] boolValue];
        self.DataType = [Soap getNodeValue: node withName: @"DataType"];
        self.IsMultipliedByAmount = [[Soap getNodeValue: node withName: @"IsMultipledByAmount"] boolValue] ;
        self.ConfigLabelKey=[Soap getNodeValue: node withName: @"ConfigLabelKey"];
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
    [s appendFormat: @"<ConfigLabelId>%@</ConfigLabelId>", self.ConfigLabelId];
    if (self.ConfigLabel != nil) [s appendFormat: @"<ConfigLabel>%@</ConfigLabel>", [[self.ConfigLabel stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
    
    [s appendFormat: @"<IsMadatory>%@</IsMadatory>", (self.IsMadatory)?@"true":@"false"];
    [s appendFormat: @"<IsAddToAmount>%@</IsAddToAmount>", (self.IsAddToAmount)?@"true":@"false"];
    [s appendFormat: @"<IsMultipliedByAmount>%@</IsMultipliedByAmount>", (self.IsMultipliedByAmount)?@"true":@"false"];
    
    if (self.ConfigLabel != nil) [s appendFormat: @"<DataType>%@</DataType>", [[self.DataType stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
    
    return s;
}

- (NSMutableString*) serializeAttributes
{
    NSMutableString* s = [super serializeAttributes];
    
    return s;
}

-(BOOL)isEqual:(id)object{
    if(object != nil && [object isKindOfClass:[SDZvw_GetConfigLablesInfo class]]) {
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
    if(self.DataType != nil) { [self.DataType release]; }
    [super dealloc];
}


@end
