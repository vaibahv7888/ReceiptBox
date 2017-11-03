//
//  SDZvw_ReportType.m
//  expense
//
//  Created by praveen chellenkula on 24/12/13.
//
//

#import "SDZvw_CostAccountings.h"

@implementation SDZvw_CostAccountings


@synthesize CostAccountingId = _CostAccountingId;
@synthesize CostAccountingDescription = _CostAccountingDescription;


- (id) init
{
    if(self = [super init])
    {
        self.CostAccountingDescription = nil;
        
    }
    return self;
}

+ (SDZvw_CostAccountings*) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (SDZvw_CostAccountings*)[[[SDZvw_CostAccountings alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.CostAccountingDescription = [Soap getNodeValue: node withName: @"CostAccountingDescription"];
        self.CostAccountingId = [[Soap getNodeValue: node withName: @"CostAccountingId"] intValue];
      
        
    }
    return self;
}

- (NSMutableString*) serialize
{
    return [self serialize: @"vw_CostAccountings"];
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
    [s appendFormat: @"<CostAccountingId>%@</CostAccountingId>", [NSString stringWithFormat: @"%i", self.CostAccountingId]];
    if (self.CostAccountingDescription != nil) [s appendFormat: @"<CostAccountingDescription>%@</CostAccountingDescription>", [[self.CostAccountingDescription  stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
    
    return s;
}

- (NSMutableString*) serializeAttributes
{
    NSMutableString* s = [super serializeAttributes];
    
    return s;
}

-(BOOL)isEqual:(id)object{
    if(object != nil && [object isKindOfClass:[SDZvw_CostAccountings class]]) {
        return [[self serialize] isEqualToString:[object serialize]];
    }
    return NO;
}

-(NSUInteger)hash{
    return [Soap generateHash:self];
    
}

- (void) dealloc
{
    if(self.CostAccountingDescription != nil) { [self.CostAccountingDescription release]; }
    [super dealloc];
}


@end
