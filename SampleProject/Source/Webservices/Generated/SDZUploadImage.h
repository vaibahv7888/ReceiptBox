//
//  SDZUploadImage.h
//  expense
//
//  Created by Parveen Sharma on 3/5/15.
//
//

#import "SDZEntityObject.h"
#import <CoreData/CoreData.h>

@interface SDZUploadImage : SDZEntityObject

@property (retain, nonatomic) NSDecimalNumber* Amount;
@property (retain, nonatomic) NSDate * Date;
@property (retain, nonatomic) NSString * Vendor;
@property (retain, nonatomic) NSString *Country;
@property (retain, nonatomic) NSString *State;
@property (retain, nonatomic) NSString *City;
@property (retain, nonatomic) NSString *Tax;


@property (nonatomic,strong) SoapFault *fault;

@property (retain, nonatomic) NSManagedObject * ExpenseObj;
- (id) initWithExpense:(NSManagedObject*) expense;
- (id) initWithFault: (SoapFault*) node ;

@end
