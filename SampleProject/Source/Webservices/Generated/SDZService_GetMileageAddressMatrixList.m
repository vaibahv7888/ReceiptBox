//
//  SDZService_GetMileageAddressMatrixList.m
//  expense
//
//  Created by Praveen on 09/09/14.
//
//

#import "SDZService_GetMileageAddressMatrixList.h"

@implementation SDZService_GetMileageAddressMatrixList

@synthesize MileageAddressTo = _MileageAddressTo;
@synthesize MileageAddressFrom = _MileageAddressFrom;
@synthesize MileageAddressMatrixId = _MileageAddressMatrixId;
@synthesize MileageAddressFromId, MileageAddressToId;
@synthesize Distance;



- (id) init
{
    if(self = [super init])
    {
        self.MileageAddressTo = nil;
        self.MileageAddressFrom = nil;
        
    }
    return self;
}

+ (SDZService_GetMileageAddressMatrixList *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (SDZService_GetMileageAddressMatrixList *)[[[SDZService_GetMileageAddressMatrixList alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.MileageAddressFrom = [Soap getNodeValue: node withName: @"MileageAddressFrom"];
        self.MileageAddressFrom = [Soap getNodeValue: node withName: @"MileageAddressFrom"];
       
        self.MileageAddressMatrixId = [[Soap getNodeValue: node withName: @"MileageAddressMatrixId"] intValue];
        self.MileageAddressFromId = [[Soap getNodeValue: node withName: @"MileageAddressFromId"] intValue];
        self.MileageAddressToId = [[Soap getNodeValue: node withName: @"MileageAddressToId"] intValue];
        self.Distance = [[Soap getNodeValue: node withName: @"Distance"] floatValue];

        
    }
    return self;
}

- (NSMutableString*) serialize
{
    return [self serialize: @"Service_GetMileageAddress"];
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
    [s appendFormat: @"<MileageAddressTo>%@</MileageAddressTo>", self.MileageAddressTo];
    [s appendFormat: @"<MileageAddressFrom>%@</MileageAddressFrom>", self.MileageAddressFrom];
	[s appendFormat: @"<MileageAddressMatrixId>%@</MileageAddressMatrixId>", [NSString stringWithFormat: @"%i", self.MileageAddressMatrixId]];
    [s appendFormat: @"<MileageAddressToId>%@</MileageAddressToId>", [NSString stringWithFormat: @"%i", self.MileageAddressToId]];
    [s appendFormat: @"<MileageAddressFromId>%@</MileageAddressFromId>", [NSString stringWithFormat: @"%i", self.MileageAddressFromId]];
    [s appendFormat: @"<Distance>%@</Distance>", [NSString stringWithFormat: @"%f", self.Distance]];
    
    return s;
}

- (NSMutableString*) serializeAttributes
{
    NSMutableString* s = [super serializeAttributes];
    
    return s;
}

-(BOOL)isEqual:(id)object{
    if(object != nil && [object isKindOfClass:[SDZService_GetMileageAddressMatrixList class]]) {
        return [[self serialize] isEqualToString:[object serialize]];
    }
    return NO;
}

-(NSUInteger)hash{
    return [Soap generateHash:self];
    
}

- (void) dealloc
{
    if(self.MileageAddressTo != nil) { [self.MileageAddressTo release]; }
    if(self.MileageAddressFrom != nil) { [self.MileageAddressFrom release]; }
    
    [super dealloc];
}


@end