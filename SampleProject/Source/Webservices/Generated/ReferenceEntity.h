//
//  ReferenceEntity.h
//  expense
//
//  Created by mac on 22/09/16.
//
//

#import "SDZEntityObject.h"

@interface ReferenceEntity : SDZEntityObject

@property                    BOOL       Active;
@property                    int        ReferenceId;
@property (nonatomic,strong) NSString   *Code;
@property                    int        CreatedByUserId;
@property (nonatomic,strong) NSString   *CreatedTimestamp;
@property (nonatomic,strong) NSString   *Description;
@property                    BOOL       IsClosed;
@property                    BOOL       IsDefault;
@property                    int        UpdatedByUserId;
@property (nonatomic,strong) NSString   *UpdatedTimestamp;

@end
