//
//  CityWithPerDiemEntity.h
//  expense
//
//  Created by Parveen Sharma on 9/14/15.
//
//

#import "SDZEntityObject.h"

@interface CityWithPerDiemEntity : SDZEntityObject
{
    int         cityId;
    NSString    *cityName;
    NSString    *cityCurrency;
    double      perDiemAmount;
}
@property (retain, nonatomic) NSString *cityName;
@property (retain, nonatomic) NSString *cityCurrency;
@property double perDiemAmount;
@property int cityId;

@property (nonatomic,strong) NSDate     *StartDate;
@property (nonatomic,strong) NSDate     *EndDate;

+ (CityWithPerDiemEntity *) newWithNode: (CXMLNode*) node;
- (id) initWithNode: (CXMLNode*) node;

@end
