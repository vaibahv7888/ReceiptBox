//
//  SDZDesignationEntity.h
//  expense
//
//  Created by Parveen Sharma on 12/17/15.
//
//

#import "SDZEntityObject.h"

@interface SDZDesignationEntity : SDZEntityObject
{
    NSString *Designation;
    NSString *DesignationCode;
}
@property (nonatomic,strong) NSString *Designation;
@property (nonatomic,strong) NSString *DesignationCode;

+ (SDZDesignationEntity *) newWithNode: (CXMLNode*) node;
- (id) initWithNode: (CXMLNode*) node;
@end
