//
//  UnApprovedReportsArray.m
//  expense
//
//  Created by Parveen Sharma on 9/22/15.
//
//

#import "UnApprovedReportsArray.h"
#import "UnApproveReportEntity.h"

@implementation UnApprovedReportsArray

+ (id) newWithNode: (CXMLNode*) node
{
    return [[[UnApprovedReportsArray alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node
{
    if(self = [self init]) {
        for(CXMLElement* child in [node children])
        {
            UnApproveReportEntity* value = [[UnApproveReportEntity newWithNode: child] object];
            if(value != nil) {
                [self addObject: value];
            }
        }
    }
    return self;
}

@end
