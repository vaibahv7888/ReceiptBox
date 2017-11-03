//
//  UserDefaultSyncEntity.h
//  expense
//
//  Created by Parveen Sharma on 10/27/15.
//
//

#import "SDZEntityObject.h"

@interface UserDefaultSyncEntity : SDZEntityObject


@property (nonatomic,strong) NSString   *BillingCode;
@property (nonatomic,strong) NSString   *BusinessPurpose;
@property (nonatomic,strong) NSString   *BusinessUnit;
@property (nonatomic,strong) NSString   *City;
@property (nonatomic,strong) NSString   *Comments;
@property (nonatomic,strong) NSString   *Company;
@property (nonatomic,strong) NSString   *CostCenter;
@property (nonatomic,strong) NSString   *Country;
@property (nonatomic,strong) NSString   *Currency;
@property float                          CurrencyRate;
@property (nonatomic,strong) NSString   *Customer;
@property (nonatomic,strong) NSString   *OtherCoworker;
@property (nonatomic,strong) NSString   *OtherDetails;
@property (nonatomic,strong) NSString   *PayMethod;
@property (nonatomic,strong) NSString   *Project;
@property (nonatomic,strong) NSString   *ProjectTask;
@property (nonatomic,strong) NSString   *State;
@property (nonatomic,strong) NSString   *Vendor;
@property (nonatomic,strong) NSString   *TimeType;
@property (nonatomic,strong) NSString   *Desc;
@property (nonatomic,strong) NSString   *Misc1;
@property (nonatomic,strong) NSString   *Misc2;
@property (nonatomic,strong) NSString   *Misc3;
@property (nonatomic,strong) NSString   *BusinessActivity;
@property (nonatomic,strong) NSString   *Reference;
@property (nonatomic,strong) NSString   *StaffMember;
@property (nonatomic,strong) NSString   *Approver;

@end
