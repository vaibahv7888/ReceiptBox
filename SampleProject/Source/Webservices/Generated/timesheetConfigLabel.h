//
//  timesheetConfigLabel.h
//  expense
//
//  Created by Parveen Sharma on 5/22/15.
//
//

#import "SDZEntityObject.h"

@interface timesheetConfigLabel : SDZEntityObject

{
NSString    *ConfigLabelId;
NSString    *ConfigLabelKey;
NSString    *ConfigLabelValue;
NSString    *ConfigLabelCategory;
BOOL        IsMandatory;
BOOL        IsEnabled;
}

@property (retain, nonatomic) NSString *ConfigLabelId;
@property (retain, nonatomic) NSString *ConfigLabelKey;
@property (retain, nonatomic) NSString *ConfigLabelCategory;
@property (retain, nonatomic) NSString *ConfigLabelValue;

@property BOOL                          IsMandatory;
@property BOOL                          IsEnabled;


+ (timesheetConfigLabel *) newWithNode: (CXMLNode*) node;
- (id) initWithNode: (CXMLNode*) node;

@end
