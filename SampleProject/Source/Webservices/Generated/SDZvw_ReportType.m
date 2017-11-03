//
//  SDZvw_ReportType.m
//  expense
//
//  Created by praveen chellenkula on 24/12/13.
//
//

#import "SDZvw_ReportType.h"

@implementation SDZvw_ReportType

@synthesize RoleId = _RoleId;
@synthesize TravelType = _TravelType;
@synthesize TravelTypeId = _TravelTypeId;
@synthesize SubTravelType = _SubTravelType;

- (id) init
{
    if(self = [super init])
    {
        self.TravelType = nil;
        
    }
    return self;
}

+ (SDZvw_ReportType*) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (SDZvw_ReportType*)[[[SDZvw_ReportType alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.RoleId = [[Soap getNodeValue: node withName: @"RoleId"] intValue];
        self.TravelType = [Soap getNodeValue: node withName: @"TravelType"];
        self.TravelTypeId = [[Soap getNodeValue: node withName: @"TravelTypeId"] intValue];
        self.SubTravelType = [Soap getNodeValue:node withName:@"SubTravelType"];

        
    }
    return self;
}

- (NSMutableString*) serialize
{
    return [self serialize: @"vw_ReportType"];
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

  
    [s appendFormat: @"<RoleId>%@</RoleId>", [NSString stringWithFormat: @"%i", self.RoleId]];
   
    if (self.TravelType != nil) [s appendFormat: @"<TravelType>%@</TravelType>", [[self.TravelType  stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];

     if (self.SubTravelType != nil) [s appendFormat: @"<SubTravelType>%@</SubTravelType>", [[self.SubTravelType  stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
    
    
    [s appendFormat: @"<TravelTypeId>%@</TravelTypeId>", [NSString stringWithFormat: @"%i", self.TravelTypeId]];
    
    return s;
}

- (NSMutableString*) serializeAttributes
{
    NSMutableString* s = [super serializeAttributes];
    
    return s;
}

-(BOOL)isEqual:(id)object{
    if(object != nil && [object isKindOfClass:[SDZvw_ReportType class]]) {
        return [[self serialize] isEqualToString:[object serialize]];
    }
    return NO;
}

-(NSUInteger)hash{
    return [Soap generateHash:self];
    
}

- (void) dealloc
{
    if(self.TravelType != nil) { [self.TravelType release]; }
    if(self.SubTravelType !=nil){
        [self.SubTravelType release];
    }
    [super dealloc];
}


@end
