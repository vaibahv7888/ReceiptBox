//
//  StaffMemberEntity.h
//  expense
//
//  Created by mac on 21/09/16.
//
//

#import "SDZEntityObject.h"

@interface StaffMemberEntity : SDZEntityObject


@property (nonatomic,strong) NSString   *APGLCode;
@property                    BOOL       Active;
@property                    int        BusinessUnitId;
@property (nonatomic,strong) NSString   *CashAdvanceGLCode;
@property                    int        CompanyId;
@property                    int        CostCenterId;
@property                    int        CreatedByUserId;
@property (nonatomic,strong) NSString   *CreatedTimestamp;
@property                    int        CurrencyId;
@property (nonatomic,strong) NSString   *CustomDateFormat;
@property                    int        ERPId;
@property (nonatomic,strong) NSString   *Email;
@property (nonatomic,strong) NSString   *EmailNotify;
@property (nonatomic,strong) NSString   *FirstName;
@property (nonatomic,strong) NSString   *LastName;
@property                    float      MilageRate;
@property (nonatomic,strong) NSDate     *OutOfOfficeEndDate;
@property (nonatomic,strong) NSDate     *OutOfOfficeStartDate;
@property (nonatomic,strong) NSString   *PDFTemplate;
@property (nonatomic,strong) NSString   *Password;
@property (nonatomic,strong) NSString   *PerDeim;
@property (nonatomic,strong) NSString   *PhoneNumber;
@property (nonatomic,strong) NSString   *ResponsibilityID;
@property                    int        RoleId;
@property (nonatomic,strong) NSString   *UnitOfTravel;
@property                    int        UpdatedByUserId;
@property (nonatomic,strong) NSString   *UpdatedTimestamp;
@property (nonatomic,strong) NSString   *UserGroup;
@property                    int        UserId;
@property (nonatomic,strong) NSString   *VendorNumber;
@property (nonatomic,strong) NSString   *aspnet_userId;


@end
