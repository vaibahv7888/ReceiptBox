//
//  SDZUploadImageParse.h
//  expense
//
//  Created by Parveen Sharma on 3/17/15.
//
//

#import "SDZEntityObject.h"
#import <CoreData/CoreData.h>
#import "SoapFault.h"


@interface SDZUploadImageParse : SDZEntityObject

@property(nonatomic,strong) NSString *imageId;
@property(nonatomic,strong) NSString *imagePath;
@property(nonatomic,strong) NSString *status;@property (nonatomic,strong) NSString *processingResult;
@property (nonatomic,strong) SoapFault *fault;
@property (nonatomic,strong) NSManagedObject *expenseObj;

- (id) initWithExpense:(NSManagedObject*)expense;
- (id) initWithFault: (SoapFault*) node ;
@end
