//
//  MileageRateObject.h
//  expense
//
//  Created by Parveen Sharma on 11/24/15.
//
//

#import "SDZEntityObject.h"

@interface MileageRateObject : SDZEntityObject

@property float                          MilageRate;
@property int                            MileageRateID;

@property (nonatomic,strong) NSDate     *StartDate;
@property (nonatomic,strong) NSDate     *EndDate;

@end
