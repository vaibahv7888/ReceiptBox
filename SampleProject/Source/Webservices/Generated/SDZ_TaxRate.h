//
//  SDZ_TaxRate.h
//  expense
//
//  Created by Parveen Sharma on 4/30/15.
//
//

#import "SDZEntityObject.h"

@interface SDZ_TaxRate : SDZEntityObject

@property(nonatomic,assign) BOOL isActive;
@property(nonatomic,assign) BOOL isEnableVat1;
@property(nonatomic,assign) BOOL isEnableVat2;
@property(nonatomic,assign) BOOL isEnableVat3;
@property(nonatomic,assign) BOOL isEnableVat4;

@property int ExpenseTypeID;

@property (nonatomic,strong) NSString *State;
@property int StateID;

@property int TaxRateID;

@property float Vat1Rate;
@property float Vat2Rate;
@property float Vat3Rate;
@property float Vat4Rate;

@property (nonatomic,strong) NSDate *dateValidFrom;
@property (nonatomic,strong) NSDate *dateValidTo;

@end
