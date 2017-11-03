//
//  SDZvw_ReportType.m
//  expense
//
//  Created by praveen chellenkula on 24/12/13.
//
//

#import "SDZvw_CostCompanies.h"

@implementation SDZvw_CostCompanies

@synthesize CompanyId = _CompanyId;
@synthesize CompanyName = _CompanyName;


- (id) init
{
    if(self = [super init])
    {
        self.CompanyName = nil;
        
    }
    return self;
}

+ (SDZvw_CostCompanies*) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (SDZvw_CostCompanies*)[[[SDZvw_CostCompanies alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.CompanyId = [[Soap getNodeValue: node withName: @"CompanyId"] intValue];
        self.CompanyName = [Soap getNodeValue: node withName: @"CompanyName"];
      
        
    }
    return self;
}

- (NSMutableString*) serialize
{
    return [self serialize: @"vw_CostCompanies"];
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

  
    [s appendFormat: @"<CompanyId>%@</CompanyId>", [NSString stringWithFormat: @"%i", self.CompanyId]];
   
    if (self.CompanyName != nil) [s appendFormat: @"<CompanyName>%@</CompanyName>", [[self.CompanyName  stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
    
    return s;
}

- (NSMutableString*) serializeAttributes
{
    NSMutableString* s = [super serializeAttributes];
    
    return s;
}

-(BOOL)isEqual:(id)object{
    if(object != nil && [object isKindOfClass:[SDZvw_CostCompanies class]]) {
        return [[self serialize] isEqualToString:[object serialize]];
    }
    return NO;
}

-(NSUInteger)hash{
    return [Soap generateHash:self];
    
}

- (void) dealloc
{
    if(self.CompanyName != nil) { [self.CompanyName release]; }
    [super dealloc];
}


@end
