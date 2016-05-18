//
//  BNRItemStore.m
//  LeaningWay
//
//  Created by Huway Mac on 16/5/18.
//  Copyright © 2016年 Android Develope. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemStore()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation BNRItemStore

+(instancetype)sharedStore{
    static BNRItemStore *shareStore = nil;
    if(!shareStore){
        shareStore = [[BNRItemStore alloc] initPrivate];
    }
    return shareStore;
}

-(instancetype)init{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[BNRItemStore sharedStore]" userInfo:nil];
    return nil;
}

-(instancetype) initPrivate{
    self = [super init];
    if(self){
        _privateItems= [[NSMutableArray alloc]init];
    }
        return self;
}

-(NSArray *)allItems{
    return self.privateItems;
}

-(BNRItem *)createItem{
    BNRItem *item = [BNRItem randomItem];
    [self.privateItems addObject:item];
    return item;
}

-(void)removeItem:(BNRItem *)item{
    [self.privateItems removeObjectIdenticalTo:item];
}


-(void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex{
    if(fromIndex == toIndex){
        return;
    }
    BNRItem *item = self.privateItems[fromIndex];
    [self.privateItems removeObjectAtIndex:fromIndex];
    [self.privateItems insertObject:item  atIndex:toIndex];
}


@end

