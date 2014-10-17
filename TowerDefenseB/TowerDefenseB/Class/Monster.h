//
//  Monster.h
//  TowerDefenseB
//
//  Created by xyxd mac on 12-12-5.
//  Copyright (c) 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import "CCSprite.h"
#import "WayPoint.h"



@interface Monster : CCSprite
{
    int _curHp;
    int _totalHp;
	int _moveDuration;
	
	int _curWaypoint;
    int _lastWaypoint;
    
    float firstDistance;
    
    CCProgressTimer *_healthBar;
    CCProgressTimer *_healthBarBg;
}

@property (nonatomic, assign) int curHp;
@property (nonatomic, assign) int totalHp;
@property (nonatomic, assign) int moveDuration;

@property (nonatomic, assign) int curWaypoint;
@property (nonatomic, assign) int lastWaypoint;

@property (nonatomic,retain) CCProgressTimer *healthBar;
@property (nonatomic,retain) CCProgressTimer *healthBarBg;


- (WayPoint *)getCurrentWaypoint;
- (WayPoint *)getNextWaypoint;

@end


@interface BossBigMonster : Monster
+ (id)monster;
@end
@interface FatBossGreenMonster : Monster
+ (id)monster;
@end
@interface FatGreenMonster : Monster
+ (id)monster;
@end
@interface FlyBlueMonster : Monster
+ (id)monster;
@end
@interface FlyBossBlueMonster : Monster
+ (id)monster;
@end
@interface FlyBossYellowMonster : Monster
+ (id)monster;
@end
@interface FlyYellowMonster : Monster
+ (id)monster;
@end
@interface LandBossNimaMonster : Monster
+ (id)monster;
@end
@interface LandBossPinkMonster : Monster
+ (id)monster;
@end
@interface LandBossStarMonster : Monster
+ (id)monster;
@end
@interface LandNimaMonster : Monster
+ (id)monster;
@end
@interface LandPinkMonster : Monster
+ (id)monster;
@end
@interface LandStarMonster : Monster
+ (id)monster;
@end
