//
//  HCPDetailEntity.m
//  expense
//
//  Created by Parveen Sharma on 12/3/15.
//
//

#import "HCPDetailEntity.h"

@implementation HCPDetailEntity
@synthesize AddressLineOne;
@synthesize AddressLineTwo;
@synthesize AddressState;
@synthesize AffiliatedOrg;
@synthesize City;
@synthesize Country;
@synthesize CustomerPractitionerNumber;
@synthesize Designation;
@synthesize ErrorCode;
@synthesize ErrorMessage;
@synthesize FirstName;
@synthesize IsInUniverse;
@synthesize IsPreviouslySearched;
@synthesize LastName;
@synthesize MiddleName;
@synthesize NPINumber;
@synthesize NPIOnPecosOAndR;
@synthesize NPISLNNumber;
@synthesize NPISLNState;
@synthesize PrimaryTaxonomyCode;
@synthesize PrimaryTaxonomyDescription;
@synthesize ProviderUniqueID;
@synthesize StateLicenseNumber;
@synthesize StateOfLicense;
@synthesize StateSpecific;
@synthesize Suffix;
@synthesize Title;
@synthesize TransactionID;
@synthesize VPLSLNNumber;
@synthesize VPLSLNStateID;
@synthesize VPLVersionOfFirstName;
@synthesize VPLVersionOfLastName;
@synthesize ZipCode;
@synthesize HCPNode;

- (id) init
{
    if(self = [super init])
    {
    }
    return self;
}

+ (HCPDetailEntity *) newWithNode: (CXMLNode*) node
{
    if(node == nil) { return nil; }
    return (HCPDetailEntity*)[[HCPDetailEntity alloc] initWithNode: node] ;
}

- (id) initWithNode: (CXMLNode*) node {
    if(self = [super initWithNode: node])
    {
        self.AddressLineOne = [Soap getNodeValue: node withName: @"AddressLineOne"];
        self.AddressLineTwo = [Soap getNodeValue: node withName: @"AddressLineTwo"];
        self.AddressState = [Soap getNodeValue: node withName: @"AddressState"];
        self.AffiliatedOrg = [Soap getNodeValue: node withName: @"AffiliatedOrg"];
        self.City = [Soap getNodeValue: node withName: @"City"];
        self.Country = [Soap getNodeValue: node withName: @"Country"];
        self.CustomerPractitionerNumber = [Soap getNodeValue: node withName: @"CustomerPractitionerNumber"];
        self.Designation = [Soap getNodeValue: node withName: @"Designation"];
        self.ErrorCode = [Soap getNodeValue: node withName: @"ErrorCode"];
        self.ErrorMessage = [Soap getNodeValue: node withName: @"ErrorMessage"];
        self.FirstName = [Soap getNodeValue: node withName: @"FirstName"];
        self.IsInUniverse = [[Soap getNodeValue: node withName: @"IsInUniverse"] boolValue];
        self.IsPreviouslySearched = [[Soap getNodeValue: node withName: @"IsPreviouslySearched"] boolValue];
        self.LastName = [Soap getNodeValue: node withName: @"LastName"];
        self.MiddleName = [Soap getNodeValue: node withName: @"MiddleName"];
        self.NPINumber = [[Soap getNodeValue: node withName: @"NPINumber"] intValue];
        self.NPIOnPecosOAndR = [Soap getNodeValue: node withName: @"NPIOnPecosOAndR"];
        self.NPISLNNumber = [[Soap getNodeValue: node withName: @"NPISLNNumber"] intValue];
        self.NPISLNState = [Soap getNodeValue: node withName: @"NPISLNState"];
        self.PrimaryTaxonomyCode = [[Soap getNodeValue: node withName: @"PrimaryTaxonomyCode"] intValue];
        self.PrimaryTaxonomyDescription = [Soap getNodeValue: node withName: @"PrimaryTaxonomyDescription"];
        self.ProviderUniqueID = [[Soap getNodeValue: node withName: @"ProviderUniqueID"] intValue];
        self.StateLicenseNumber = [Soap getNodeValue: node withName: @"StateLicenseNumber"];
        self.StateOfLicense = [Soap getNodeValue: node withName: @"StateOfLicense"];
        self.StateSpecific = [Soap getNodeValue: node withName: @"StateSpecific"];
        self.Suffix = [Soap getNodeValue: node withName: @"Suffix"];
        self.Title = [Soap getNodeValue: node withName: @"Title"];
        self.TransactionID = [[Soap getNodeValue: node withName: @"TransactionID"] intValue];
        self.VPLSLNNumber = [[Soap getNodeValue: node withName: @"VPLSLNNumber"] intValue];
        self.VPLSLNStateID = [[Soap getNodeValue: node withName: @"VPLSLNStateID"] intValue];
        self.VPLVersionOfFirstName = [Soap getNodeValue: node withName: @"VPLVersionOfFirstName"];
        self.VPLVersionOfLastName = [Soap getNodeValue: node withName: @"VPLVersionOfLastName"];
        self.ZipCode = [Soap getNodeValue: node withName: @"ZipCode"];

        self.HCPNode = [NSString stringWithFormat:@"%@",[node XMLString]];
    }
    return self;
}



@end
