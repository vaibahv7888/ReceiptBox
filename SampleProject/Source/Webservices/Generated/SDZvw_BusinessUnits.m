//
//  SDZvw_ReportType.m
//  expense
//
//  Created by praveen chellenkula on 24/12/13.
//
//

#import "SDZvw_BusinessUnits.h"

@implementation SDZvw_BusinessUnits

@synthesize CompanyId = _CompanyId;
@synthesize BusinessUnitDescription = _BusinessUnitDescription;
@synthesize BusinessUnitId = _BusinessUnitId;


- (id) init
{
    if(self = [super init])
    {
        self.BusinessUnitDescription = nil;
        
    }
    return self;
}

+ (SDZvw_BusinessUnits*) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (SDZvw_BusinessUnits*)[[[SDZvw_BusinessUnits alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.CompanyId = [[Soap getNodeValue: node withName: @"CompanyId"] intValue];
        self.BusinessUnitDescription = [Soap getNodeValue: node withName: @"BusinessUnitDescription"];
        self.BusinessUnitId = [[Soap getNodeValue: node withName: @"BusinessUnitId"] intValue];
      
        
    }
    return self;
}

- (NSMutableString*) serialize
{
    return [self serialize: @"vw_BusinessUnits"];
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
   
    if (self.BusinessUnitDescription != nil) [s appendFormat: @"<BusinessUnitDescription>%@</BusinessUnitDescription>", [[self.BusinessUnitDescription  stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];

    [s appendFormat: @"<BusinessUnitId>%@</BusinessUnitId>", [NSString stringWithFormat: @"%i", self.BusinessUnitId]];
    
    return s;
}

- (NSMutableString*) serializeAttributes
{
    NSMutableString* s = [super serializeAttributes];
    
    return s;
}

-(BOOL)isEqual:(id)object{
    if(object != nil && [object isKindOfClass:[SDZvw_BusinessUnits class]]) {
        return [[self serialize] isEqualToString:[object serialize]];
    }
    return NO;
}

-(NSUInteger)hash{
    return [Soap generateHash:self];
    
}

- (void) dealloc
{
    if(self.BusinessUnitDescription != nil) { [self.BusinessUnitDescription release]; }
    [super dealloc];
}


@end
