//
//  SDZStateLicenceEntity.h
//  expense
//
//  Created by Parveen Sharma on 12/17/15.
//
//

#import "SDZEntityObject.h"

@interface SDZStateLicenceEntity : SDZEntityObject
{
    NSString *Country;
    NSString *State;
    NSString *StateCode;
}
@property (nonatomic,strong) NSString *Country;
@property (nonatomic,strong) NSString *State;
@property (nonatomic,strong) NSString *StateCode;


+ (SDZStateLicenceEntity *) newWithNode: (CXMLNode*) node;
- (id) initWithNode: (CXMLNode*) node;

@end
