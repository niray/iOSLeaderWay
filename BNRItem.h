//
//  BNRItem.h
//  LeaningWay
//
//  Created by Huway Mac on 16/5/18.
//  Copyright © 2016年 Android Develope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject <NSCoding>

@property (nonatomic,weak) NSString *name;
@property int serial;
@property (nonatomic,weak) NSString *value;
@property (nonatomic,strong) NSDate *dateValue;
@property(nonatomic, copy) NSString *itemKey;

- (instancetype)initWithCoder:(NSCoder *)coder;

- (void)encodeWithCoder:(NSCoder *)coder;
-(instancetype)initWithItemName:(NSString *)name valueInDollars:(int)value serialNumber:(NSString *)sNumber;
-(instancetype) initWithItemName:(NSString *)name;
+(instancetype) randomItem;
@end
