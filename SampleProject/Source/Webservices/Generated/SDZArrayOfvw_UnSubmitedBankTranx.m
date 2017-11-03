//
//  SDZArrayOfvw_UnSubmitedBankTranx.m
//  expense
//
//  Created by praveen chellenkula on 14/09/13.
//
//

#import "SDZArrayOfvw_UnSubmitedBankTranx.h"
#import "SDZvw_UnSubmitedBankTranx.h"

@implementation SDZArrayOfvw_UnSubmitedBankTranx


+ (id) newWithNode: (CXMLNode*) node
{
    return [[[SDZArrayOfvw_UnSubmitedBankTranx alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            SDZvw_UnSubmitedBankTranx* value = [[SDZvw_UnSubmitedBankTranx newWithNode: child] object];
            if(value != nil) {
                [self addObject: value];
            }
        }
    }
    return self;
}

+ (NSMutableString*) serialize: (NSArray*) array
{
    NSMutableString* s = [NSMutableString string];
    for(id item in array) {
        [s appendString: [item serialize: @"vw_UnSubmitedBankTrnx"]];
    }
    return s;
}
@end

