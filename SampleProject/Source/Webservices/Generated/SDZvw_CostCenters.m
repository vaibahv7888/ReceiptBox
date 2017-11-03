//
//  SDZvw_ReportType.m
//  expense
//
//  Created by praveen chellenkula on 24/12/13.
//
//

#import "SDZvw_CostCenters.h"

@implementation SDZvw_CostCenters

@synthesize BusinessUnitId = _BusinessUnitId;
@synthesize CostCenterDescription = _CostCenterDescription;
@synthesize CostCenterId = _CostCenterId;


- (id) init
{
    if(self = [super init])
    {
        self.CostCenterDescription = nil;
        
    }
    return self;
}

+ (SDZvw_CostCenters*) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (SDZvw_CostCenters*)[[[SDZvw_CostCenters alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.BusinessUnitId = [[Soap getNodeValue: node withName: @"BusinessUnitId"] intValue];
        self.CostCenterDescription = [Soap getNodeValue: node withName: @"CostCenterDescription"];
        self.CostCenterId = [[Soap getNodeValue: node withName: @"CostCenterId"] intValue];
      
        
    }
    return self;
}

- (NSMutableString*) serialize
{
    return [self serialize: @"vw_CostCenters"];
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

  
    [s appendFormat: @"<BusinessUnitId>%@</BusinessUnitId>", [NSString stringWithFormat: @"%i", self.BusinessUnitId]];
   
    if (self.CostCenterDescription != nil) [s appendFormat: @"<CostCenterDescription>%@</CostCenterDescription>", [[self.CostCenterDescription  stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];

    [s appendFormat: @"<CostCenterId>%@</CostCenterId>", [NSString stringWithFormat: @"%i", self.CostCenterId]];
    
    return s;
}

- (NSMutableString*) serializeAttributes
{
    NSMutableString* s = [super serializeAttributes];
    
    return s;
}

-(BOOL)isEqual:(id)object{
    if(object != nil && [object isKindOfClass:[SDZvw_CostCenters class]]) {
        return [[self serialize] isEqualToString:[object serialize]];
    }
    return NO;
}

-(NSUInteger)hash{
    return [Soap generateHash:self];
    
}

- (void) dealloc
{
    if(self.CostCenterDescription != nil) { [self.CostCenterDescription release]; }
    [super dealloc];
}


@end
