//
//  BNRImageStore.m
//  LeaningWay
//
//  Created by Huway Mac on 16/5/21.
//  Copyright © 2016年 Android Develope. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore()

@property (nonatomic,strong)NSMutableDictionary *dictinary;

@end

@implementation BNRImageStore


+(instancetype)sharedStore{
    static BNRImageStore *sharedStore = nil;
//    if(!sharedStore){
//        sharedStore=[[self alloc]initPrivate];
//    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });
    
    return  sharedStore;
}

-(instancetype)init{
    @throw[NSException exceptionWithName:@"Singleton" reason:@"Use +[BNRImageStore sharedStore]" userInfo:nil];
    return  nil;
}

-(instancetype)initPrivate{
    self = [super init];
    if(self){
        self.dictinary = [[NSMutableDictionary alloc]init];
    }
    return self;
}

-(void)setImage:(UIImage *)image forKey:(NSString*)key{
//    [self.dictinary setObject:image forKey:key];
    self.dictinary[key] = image;
}

-(UIImage *)imageForKey:(NSString*)key{
//    return [self.dictinary objectForKey:key];
    return self.dictinary[key];
}

-(void)deleteImageForKey:(NSString *)key{
    if(!key){
        return;
    }
    [self.dictinary removeObjectForKey:key];
}

@end
