//
//  BNRImageStore.m
//  LeaningWay
//
//  Created by Huway Mac on 16/5/21.
//  Copyright © 2016年 Android Develope. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore ()

@property(nonatomic, strong) NSMutableDictionary *dictinary;

@end

@implementation BNRImageStore


+ (instancetype)sharedStore {
    static BNRImageStore *sharedStore = nil;
//    if(!sharedStore){
//        sharedStore=[[self alloc]initPrivate];
//    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });

    return sharedStore;
}

- (instancetype)init {
    @throw[NSException exceptionWithName:@"Singleton" reason:@"Use +[BNRImageStore sharedStore]" userInfo:nil];
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        self.dictinary = [[NSMutableDictionary alloc] init];


        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(clearCache:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (void)clearCache:(NSNotification *)note {
    NSLog(@"flushing %%d images out of the cache", [self.dictinary count]);
    [self.dictinary removeAllObjects];
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key {
//  [self.dictinary setObject:image forKey:key];
    self.dictinary[key] = image;
    NSString *imagePath = [self imagePathForKey:key];
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    [data writeToFile:imagePath atomically:YES];
}

- (UIImage *)imageForKey:(NSString *)key {
//    return [self.dictinary objectForKey:key];
    UIImage *result = self.dictinary[key];
    if (!result) {
        NSString *imagePath = [self imagePathForKey:key];
        result = [UIImage imageWithContentsOfFile:imagePath];
        if (result) {
            self.dictinary[key] = result;
        } else {
            NSLog(@"Unable to find %@", [self imagePathForKey:key]);
        }
    }
    return result;
//    return self.dictinary[key];
}

- (void)deleteImageForKey:(NSString *)key {
    if (!key) return;

    [self.dictinary removeObjectForKey:key];
    NSString *imagePath = [self imagePathForKey:key];
    [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
}


- (NSString *)imagePathForKey:(NSString *)key {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];
    return [documentDirectory stringByAppendingPathComponent:key];
}

@end
