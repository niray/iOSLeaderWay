//
//  BNRItem.m
//  LeaningWay
//
//  Created by Huway Mac on 16/5/18.
//  Copyright © 2016年 Android Develope. All rights reserved.
//

#import "BNRItem.h"


@implementation BNRItem



-(instancetype)initWithItemName:(NSString *)name{
    return  self;
}
-(instancetype)initWithItemName:
(NSString *)name
                 valueInDollars:(int)value
                   serialNumber:(NSString *)sNumber{
    self.name=name;
    self.serial=value;
    self.value=sNumber;
    self.dateValue = [[NSDate alloc]init];
     return  self;
}


+(instancetype) randomItem{
    NSArray *randomAdjectiveList = @[@"Fluffy",@"Rusty",@"Shiny"];
    NSArray *randomNounList = @[@"Bear",@"Spork",@"Mac"];
    
    NSInteger adjectiveIndex =arc4random()%[randomAdjectiveList count];
    NSInteger nounIndex = arc4random() % [randomNounList count];
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@",[randomNounList objectAtIndex:adjectiveIndex],[randomNounList objectAtIndex:nounIndex]];
                            
    int randomValue = arc4random() %100;
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                    '0' +arc4random()%10,
                                    'A' +arc4random()%26,
                                    '0' +arc4random()%10,
                                    'A' +arc4random()%26,
                                    '0' +arc4random()%10 ];
    
    BNRItem *newItem = [[self alloc] initWithItemName:randomName
                                       valueInDollars:randomValue
                                         serialNumber:randomSerialNumber];
    return newItem;
}



-(NSString *) description{
    NSString *desciptionString = [[NSString alloc]initWithFormat:@"%@ (%@):Worth $%d , recorded on %@",
                                  self.name,self.value,self.serial,self.dateValue];
    return desciptionString;
}








@end
