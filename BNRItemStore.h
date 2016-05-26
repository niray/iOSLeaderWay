//
//  BNRItemStore.h
//  LeaningWay
//
//  Created by Huway Mac on 16/5/18.
//  Copyright © 2016年 Android Develope. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface BNRItemStore : NSObject


@property (nonatomic,readonly) NSArray *allItems;
+(instancetype)sharedStore;
-(BNRItem *)createItem;
-(void)removeItem:(BNRItem *)item;

-(void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

- (BOOL)saveChanges;
@end
