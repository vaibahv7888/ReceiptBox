//
//  SDZBillingCode.m
//  expense
//
//  Created by Parveen Sharma on 4/24/15.
//
//

#import "SDZBillingCode.h"

@implementation SDZBillingCode

@synthesize BillingCodeID=_BillingCodeID;
@synthesize BillingCodeERPID=_BillingCodeERPID;
@synthesize BillingCode=_BillingCode;

- (id) init
{
    if(self = [super init])
    {
        self.BillingCode = nil;
        self.BillingCodeERPID = nil;
        self.BillingCodeID = nil;
    }
    return self;
}

+ (SDZBillingCode*) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (SDZBillingCode*)[[[SDZBillingCode alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.BillingCodeID = [[Soap getNodeValue: node withName: @"BillingCodeId"] intValue];
        self.BillingCodeERPID = [Soap getNodeValue: node withName: @"BillingCodeERPId"] ;
        self.BillingCode = [Soap getNodeValue: node withName: @"BillingCode"];
    }
    return self;
}

@end
