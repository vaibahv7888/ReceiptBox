//
//  timeTypeEntity.h
//  expense
//
//  Created by Parveen Sharma on 5/28/15.
//
//

#import "SDZEntityObject.h"

@interface timeTypeEntity : SDZEntityObject

@property int timeTypeID;
@property (nonatomic,strong) NSString *TimeTypeName;


+ (timeTypeEntity*) newWithNode: (CXMLNode*) node;
- (id) initWithNode: (CXMLNode*) node;

@end
