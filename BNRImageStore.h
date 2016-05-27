//
//  BNRImageStore.h
//  LeaningWay
//
//  Created by Huway Mac on 16/5/21.
//  Copyright © 2016年 Android Develope. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <UIKit/UIKit.h>
@interface BNRImageStore : NSObject

+(instancetype)sharedStore;

-(void)setImage:(UIImage *)image forKey:(NSString *)key;
-(UIImage *)imageForKey:(NSString *)key;
-(void)deleteImageForKey:(NSString *)key;

- (NSString *)imagePathForKey:(NSString *)key;
@end
