//
//  BNRItem.h
//  LeaningWay
//
//  Created by Huway Mac on 16/5/18.
//  Copyright © 2016年 Android Develope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject


-(instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber;
-(instancetype) initWithItemName:(NSString *)name;
+(instancetype) randomItem;
@end
