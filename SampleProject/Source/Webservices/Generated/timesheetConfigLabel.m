//
//  timesheetConfigLabel.m
//  expense
//
//  Created by Parveen Sharma on 5/22/15.
//
//

#import "timesheetConfigLabel.h"

@implementation timesheetConfigLabel

@synthesize ConfigLabelId = _ConfigLabelId;
@synthesize ConfigLabelKey = _ConfigLabelKey;
@synthesize ConfigLabelValue = _ConfigLabelValue;
@synthesize IsEnabled = _IsEnabled;
@synthesize ConfigLabelCategory=_ConfigLabelCategory;
@synthesize IsMandatory = _IsMandatory;

- (id) init
{
    if(self = [super init])
    {
        
    }
    return self;
}

+ (timesheetConfigLabel *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (timesheetConfigLabel*)[[[timesheetConfigLabel alloc] initWithNode: node] autorelease];
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.ConfigLabelId = [Soap getNodeValue: node withName: @"ConfigLblId"];
        self.ConfigLabelKey = [Soap getNodeValue: node withName: @"ConfigurationLabelKey"];
        self.ConfigLabelValue = [Soap getNodeValue: node withName: @"ConfigurationLabelValue"];
        self.ConfigLabelCategory = [Soap getNodeValue: node withName: @"Category"] ;

        self.IsMandatory = [[Soap getNodeValue: node withName: @"IsMandatory"] boolValue];
        self.IsEnabled = [[Soap getNodeValue: node withName: @"IsEnabled"] boolValue];
        
    }
    return self;
}

@end
