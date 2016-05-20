//
//  BNRItem.h
//  LeaningWay
//
//  Created by Huway Mac on 16/5/18.
//  Copyright © 2016年 Android Develope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject

@property (nonatomic,weak) NSString *name;
@property int serial;
@property (nonatomic,weak) NSString *value;
@property (nonatomic,strong) NSDate *dateValue;

-(instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber;
-(instancetype) initWithItemName:(NSString *)name;
+(instancetype) randomItem;
@end
