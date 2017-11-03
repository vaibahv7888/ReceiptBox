//
//  SDZ_JobsTasks.h
//  expense
//
//  Created by Parveen Sharma on 4/2/15.
//
//

#import "SDZEntityObject.h"

@interface SDZ_JobsTasks : SDZEntityObject

@property int TaskID;
@property int ProjectID;
@property (nonatomic,strong) NSString *ProjectName;
@property (nonatomic,strong) NSString *TaskName;

@property (nonatomic,strong) NSDate *dateFrom;
@property (nonatomic,strong) NSDate *dateTo;
@property (nonatomic,strong) NSString *projectTaskType;

+ (SDZ_JobsTasks*) newWithNode: (CXMLNode*) node;
- (id) initWithNode: (CXMLNode*) node;
@end
