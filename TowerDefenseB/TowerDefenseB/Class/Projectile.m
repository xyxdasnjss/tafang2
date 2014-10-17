//
//  Projectile.m
//  TowerDefenseB
//
//  Created by xyxd mac on 12-12-10.
//  Copyright (c) 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import "Projectile.h"

@implementation Projectile



@end


@implementation BottleProjectile

+ (id)projectile
{
    
    BottleProjectile *projectile = nil;
    
    
    
    if (( projectile = [Projectile spriteWithSpriteFrameName:@"PBottle11.png"])) {
       
        
    }
    //    monster.tag = kMonsterTypeBossBig;
//    NSMutableArray *monster1s = [NSMutableArray array];
//    
//    CCSpriteFrame *spriteFrame;
//    int count = 1;
//    
//    for (int i = 1; i < 4; i++) {
//        while ((spriteFrame =  [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
//                                [NSString stringWithFormat:@"PBottle%d%d.png", i,count]])) {
//            [monster1s addObject:spriteFrame];
//            count++;
//        }
//    }
//    
//    
//    spriteFrame = nil;
//    
//    CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:monster1s delay:.3f];
//    id walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]];
//    [projectile runAction:walkAction];
    
    return projectile;
}

@end
