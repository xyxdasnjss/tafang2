//
//  Projectile.h
//  TowerDefenseB
//
//  Created by xyxd mac on 12-12-10.
//  Copyright (c) 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import "CCSprite.h"

@interface Projectile : CCSprite



@end

@interface BottleProjectile : Projectile
+ (id)projectile;
@end