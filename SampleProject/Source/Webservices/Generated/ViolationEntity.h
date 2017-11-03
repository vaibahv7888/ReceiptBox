//
//  ViolationEntity.h
//  expense
//
//  Created by Parveen Sharma on 9/14/15.
//
//

#import "SDZEntityObject.h"

@interface ViolationEntity : SDZEntityObject
{
    int         violationId;
    NSString    *violationName;
    NSString    *violationReason;
}
@property (retain, nonatomic) NSString *violationName;
@property (retain, nonatomic) NSString *violationReason;
@property int violationId;

+ (ViolationEntity *) newWithNode: (CXMLNode*) node;
- (id) initWithNode: (CXMLNode*) node;
@end
