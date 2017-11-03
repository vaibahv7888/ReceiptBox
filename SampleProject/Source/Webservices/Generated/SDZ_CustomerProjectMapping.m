//
//  SDZ_CustomerProjectMapping.m
//  expense
//
//  Created by Parveen Sharma on 4/1/15.
//
//

#import "SDZ_CustomerProjectMapping.h"

@implementation SDZ_CustomerProjectMapping
@synthesize CustomerID=_CountryID;
@synthesize ProjectID=_ProjectID;

- (id) init
{
    if(self = [super init])
    {
        self.CustomerID = nil;
        self.ProjectID = nil;
        
    }
    return self;
}

+ (SDZ_CustomerProjectMapping*) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (SDZ_CustomerProjectMapping*)[[[SDZ_CustomerProjectMapping alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.CustomerID = [[Soap getNodeValue: node withName: @"CustomerId"] intValue];
        self.ProjectID = [[Soap getNodeValue: node withName: @"ProjectId"] intValue];
    }
    return self;
}

- (NSMutableString*) serialize
{
    return [self serialize: @"vw_mapping"];
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
    [s appendFormat: @"<CustomerId>%@</CustomerId>", [NSString stringWithFormat: @"%i", self.CustomerID]];
    [s appendFormat: @"<ProjectId>%@</ProjectId>", [NSString stringWithFormat: @"%i", self.ProjectID]];
    return s;
}

- (NSMutableString*) serializeAttributes
{
    NSMutableString* s = [super serializeAttributes];
    
    return s;
}

-(BOOL)isEqual:(id)object{
    if(object != nil && [object isKindOfClass:[SDZ_CustomerProjectMapping class]]) {
        return [[self serialize] isEqualToString:[object serialize]];
    }
    return NO;
}

-(NSUInteger)hash{
    return [Soap generateHash:self];
    
}

@end
