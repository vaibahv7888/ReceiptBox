//
//  SDZBillingCode.h
//  expense
//
//  Created by Parveen Sharma on 4/24/15.
//
//

#import "SDZEntityObject.h"

@interface SDZBillingCode : SDZEntityObject

@property int BillingCodeID;
@property (nonatomic,strong) NSString *BillingCodeERPID;
@property (nonatomic,strong) NSString *BillingCode;


+ (SDZBillingCode*) newWithNode: (CXMLNode*) node;
- (id) initWithNode: (CXMLNode*) node;


@end
