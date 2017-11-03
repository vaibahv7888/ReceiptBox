//
//  ApproverEntity.h
//  expense
//
//  Created by mac on 22/09/16.
//
//

#import "SDZEntityObject.h"

@interface ApproverEntity : SDZEntityObject

@property                    BOOL       Active;
@property (nonatomic,strong) NSString   *FullName;
@property                    BOOL       IsDefaultManager;
@property                    BOOL       IsReportOnly;
@property                    int        ManagerId;
@property                    int        ProjectId;

@end
