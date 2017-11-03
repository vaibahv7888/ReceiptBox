//
//  ExpTypeViolationsMappingEntity.h
//  expense
//
//  Created by Parveen Sharma on 9/14/15.
//
//

#import "SDZEntityObject.h"

@interface ExpTypeViolationsMappingEntity : SDZEntityObject
{
    int         ExpenseTypeViolationId;
    int         ExpesneTypeId;
    int         ViolationId;
}

@property int ExpenseTypeViolationId;
@property int ExpesneTypeId;
@property int ViolationId;

+ (ExpTypeViolationsMappingEntity *) newWithNode: (CXMLNode*) node;
- (id) initWithNode: (CXMLNode*) node;

@end
