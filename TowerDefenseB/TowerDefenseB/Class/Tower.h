//
//  Tower.h
//  TowerDefenseB
//
//  Created by xyxd mac on 12-12-5.
//  Copyright (c) 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import "CCSprite.h"
@class Monster;

typedef enum _TowerType{
    kTowerBottle = 10,
    kTowerArrow,
    kTowerBall,
    kTowerBlueStar,
    kTowerFan,
    kTowerFireBottle,
    kTowerPin,
    kTowerPlane,
    kTowerRocket,
    kTowerShit,
    kTowerSnow,
    kTowerStar,
    kTowerSun,
    
}TowerType;

@interface Tower : CCSprite
{
    int _range;
	CCSprite *_bottom;
    Monster *_target;
    
    NSMutableArray *_projectiles;
	CCSprite *_nextProjectile;
    CCLayer *_gameLayer;
}
@property (nonatomic, assign) int range;
@property (nonatomic, retain) CCSprite *bottom;
@property (nonatomic, retain) Monster *target;

@property (nonatomic, retain) NSMutableArray *projectiles;
@property (nonatomic, retain) CCSprite *nextProjectile;
@property (nonatomic, retain) CCLayer *gameLayer;

- (void)towerLogic:(ccTime)dt;

@end



@interface TBottle : Tower {
}
+ (id)tower;

@end
@interface TArrow : Tower {
}
+ (id)tower;

@end
@interface TBall : Tower {
}
+ (id)tower;

@end
@interface TBlueStar : Tower {
}
+ (id)tower;

@end
@interface TFan : Tower {
}
+ (id)tower;

@end
@interface TFireBottle : Tower {
}
+ (id)tower;

@end
@interface TPin : Tower {
}
+ (id)tower;

@end
@interface TPlane : Tower {
}
+ (id)tower;

@end
@interface TRocket : Tower {
}
+ (id)tower;

@end
@interface TShit : Tower {
}
+ (id)tower;

@end
@interface TSnow : Tower {
}
+ (id)tower;

@end
@interface TStar : Tower {
}
+ (id)tower;

@end
@interface TSun : Tower {
}
+ (id)tower;

@end

