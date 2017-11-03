//
//  MapProjectExpense.h
//  expense
//
//  Created by Parveen Sharma on 5/18/15.
//
//

#import "SDZEntityObject.h"

@interface MapProjectExpense : SDZEntityObject

@property(nonatomic,assign) BOOL isActive;
@property int ExpenseTypeID;
@property int TaxRateID;
@property int ProjectExpenseID;
@property int ProjectID;
@property int UserID;

@end
