/*
 SDZvw_UnSubmitedBankTranx.h
 The interface definition of properties and methods for the SDZvw_UnSubmitedBankTranx object.
 Generated by SudzC.com
 */

#import "Soap.h"

#import "SDZEntityObject.h"
@class SDZEntityObject;


@interface SDZvw_UnSubmitedBankTranx : SDZEntityObject
{
	BOOL _Active;
	NSString* _Activity;
	NSDecimalNumber* _Amount;
	NSString* _City;
	NSString* _CoWorkers;
	NSString* _Comment;
	NSDecimalNumber* _ConvertedAmount;
	int _CountryId;
	int _CurrencyId;
	NSDecimalNumber* _CurrencyRate;
	NSDate* _ExpenseDate;
	int _ExpenseDetailId;
	int _ExpenseId;
	int _ExpenseTypeId;
	int _IsReceipt;
	int _MethodId;
	BOOL _NotReimbursable;
	NSDecimalNumber* _OtherAmount1;
	NSDecimalNumber* _OtherAmount2;
	NSDecimalNumber* _OtherAmount3;
	NSDecimalNumber* _OtherAmount4;
	NSString* _OtherComments;
	NSString* _ReceiptPath;
	int _StateId;
	NSString* _TransactionName;
	NSString* _TransactionSource;
	int _UserId;
	int _VendorId;
	NSString* _VendorName;
    NSString* _BusinessPurpose;
	
    int _CompanyID;
    int _BusinessID;
    int _DeptID;
    int _CustomerID;
    int _ProjectID;
    int _ProjTaskID;
    int _BillingID;
    NSString* ExpenseTypeCat;

    BOOL isInvalid;
    
}

@property BOOL Active;
@property (retain, nonatomic) NSString* Activity;
@property (retain, nonatomic) NSDecimalNumber* Amount;
@property (retain, nonatomic) NSString* City;
@property (retain, nonatomic) NSString* CoWorkers;
@property (retain, nonatomic) NSString* Comment;
@property (retain, nonatomic) NSDecimalNumber* ConvertedAmount;
@property int CountryId;
@property int CurrencyId;
@property (retain, nonatomic) NSDecimalNumber* CurrencyRate;
@property (retain, nonatomic) NSDate* ExpenseDate;
@property int ExpenseDetailId;
@property int ExpenseId;
@property int ExpenseTypeId;
@property int IsReceipt;
@property int MethodId;
@property BOOL NotReimbursable;
@property (retain, nonatomic) NSDecimalNumber* OtherAmount1;
@property (retain, nonatomic) NSDecimalNumber* OtherAmount2;
@property (retain, nonatomic) NSDecimalNumber* OtherAmount3;
@property (retain, nonatomic) NSDecimalNumber* OtherAmount4;
@property (retain, nonatomic) NSString* OtherComments;
@property (retain, nonatomic) NSString* ReceiptPath;
@property int StateId;
@property (retain, nonatomic) NSString* TransactionName;
@property (retain, nonatomic) NSString* TransactionSource;
@property int UserId;
@property int VendorId;
@property (retain, nonatomic) NSString* VendorName;
@property (retain, nonatomic) NSString* BusinessPurpose;
@property (retain, nonatomic) NSString* referenceType;
@property (retain, nonatomic) NSString* ExpenseTypeCat;
@property int businessActivityId;
@property int referenceId;
@property int staffMemberId;
@property int approverId;

@property int companyID;
@property int businessID;
@property int deptID;

@property int customerID;
@property int projectID;
@property int projTaskID;

@property int billingID;
@property int splitDetailID;

@property BOOL isInvalid;


+ (SDZvw_UnSubmitedBankTranx*) createWithNode: (CXMLNode*) node;
- (id) initWithNode: (CXMLNode*) node;
- (NSMutableString*) serialize;
- (NSMutableString*) serialize: (NSString*) nodeName;
- (NSMutableString*) serializeAttributes;
- (NSMutableString*) serializeElements;

@end
