//
//  HCPDetailEntity.h
//  expense
//
//  Created by Parveen Sharma on 12/3/15.
//
//

#import "SDZEntityObject.h"

@interface HCPDetailEntity : SDZEntityObject
{
    NSString *AddressLineOne;
    NSString *AddressLineTwo;
    NSString *AddressState;
    NSString *AffiliatedOrg;
    NSString *City;
    NSString *Country;
    int       CustomerPractitionerNumber;
    NSString *Designation;
    NSString *ErrorCode;
    NSString *ErrorMessage;
    NSString *FirstName;
    BOOL      IsInUniverse;
    BOOL      IsPreviouslySearched;
    NSString *LastName;
    NSString *MiddleName;
    int       NPINumber;
    NSString *NPIOnPecosOAndR;
    int       NPISLNNumber;
    NSString *NPISLNState;
    int       PrimaryTaxonomyCode;
    NSString *PrimaryTaxonomyDescription;
    int       ProviderUniqueID;
    NSString *StateLicenseNumber;
    NSString *StateOfLicense;
    NSString *StateSpecific;
    NSString *Suffix;
    NSString *Title;
    int       TransactionID;
    int       VPLSLNNumber;
    int       VPLSLNStateID;
    NSString *VPLVersionOfFirstName;
    NSString *VPLVersionOfLastName;
    NSString *ZipCode;
}


@property (nonatomic,strong) NSString *AddressLineOne;
@property (nonatomic,strong) NSString *AddressLineTwo;
@property (nonatomic,strong) NSString *AddressState;
@property (nonatomic,strong) NSString *AffiliatedOrg;
@property (nonatomic,strong) NSString *City;
@property (nonatomic,strong) NSString *Country;
@property                         int CustomerPractitionerNumber;
@property (nonatomic,strong) NSString *Designation;
@property (nonatomic,strong) NSString *ErrorCode;
@property (nonatomic,strong) NSString *ErrorMessage;
@property (nonatomic,strong) NSString *FirstName;
@property                        BOOL  IsInUniverse;
@property                        BOOL  IsPreviouslySearched;
@property (nonatomic,strong) NSString *LastName;
@property (nonatomic,strong) NSString *MiddleName;
@property                         int  NPINumber;
@property (nonatomic,strong) NSString *NPIOnPecosOAndR;
@property                         int  NPISLNNumber;
@property (nonatomic,strong) NSString *NPISLNState;
@property                         int  PrimaryTaxonomyCode;
@property (nonatomic,strong) NSString *PrimaryTaxonomyDescription;
@property                         int  ProviderUniqueID;
@property (nonatomic,strong) NSString *StateLicenseNumber;
@property (nonatomic,strong) NSString *StateOfLicense;
@property (nonatomic,strong) NSString *StateSpecific;
@property (nonatomic,strong) NSString *Suffix;
@property (nonatomic,strong) NSString *Title;
@property                         int  TransactionID;
@property                         int  VPLSLNNumber;
@property                         int  VPLSLNStateID;
@property (nonatomic,strong) NSString *VPLVersionOfFirstName;
@property (nonatomic,strong) NSString *VPLVersionOfLastName;
@property (nonatomic,strong) NSString *ZipCode;

@property (nonatomic,strong) NSString *HCPNode;

+ (HCPDetailEntity *) newWithNode: (CXMLNode*) node;
- (id) initWithNode: (CXMLNode*) node;


@end
