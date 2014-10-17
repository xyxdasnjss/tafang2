//
//  Monster.m
//  TowerDefenseB
//
//  Created by xyxd mac on 12-12-5.
//  Copyright (c) 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import "Monster.h"
#import "DataModel.h"
#import "BaseAttributes.h"

@implementation Monster
@synthesize curHp = _curHp;
@synthesize totalHp = _totalHp;
@synthesize moveDuration = _moveDuration;
@synthesize curWaypoint = _curWaypoint;
@synthesize healthBar = _healthBar;
@synthesize healthBarBg = _healthBarBg;



- (WayPoint *)getCurrentWaypoint
{
	
	DataModel *m = [DataModel getModel];
	
	WayPoint *waypoint = (WayPoint *) [m.waypoints objectAtIndex:self.curWaypoint];
	
	return waypoint;
}

- (WayPoint *)getNextWaypoint
{
	
	DataModel *m = [DataModel getModel];
	int lastWaypoint = m.waypoints.count - 1;
    
	self.curWaypoint++;
	
    //路线走完了
	if (self.curWaypoint == lastWaypoint)
    {
        self.curWaypoint--;
        
        Monster *target = (Monster*) self;
        
        [m.targets removeObject:target];
        
        [self.parent removeChild:target.healthBar cleanup:YES];
        [self.parent removeChild:target.healthBarBg cleanup:YES];
        [self.parent removeChild:target cleanup:YES];
        
        [BaseAttributes sharedAttributes].baseHealth--;
        
        
        return nil;
    }
	
	WayPoint *waypoint = (WayPoint *) [m.waypoints objectAtIndex:self.curWaypoint];
	
	return waypoint;
}


-(void)healthBarLogic:(ccTime)dt {
    
    //Update health bar pos and percentage.
    _healthBar.position = ccp(self.position.x, (self.position.y+20));
    _healthBarBg.position = _healthBar.position;
    _healthBar.percentage = ((float)self.curHp/(float)self.totalHp) *100;
    
    
    //    DLog(@"111:%d",self.curHp);
    //    DLog(@"222:%d",self.totalHp);
    //    DLog(@":%f",_healthBar.percentage);
    
    //    if (self.curHp <= 0) {
    //        [self.parent removeChild:_healthBar cleanup:YES];
    //        [self.parent removeChild:_healthBarBg cleanup:YES];
    //    }
    
    
    
    
}

- (void) monsterLogic:(ccTime)dt
{
    CGPoint shootVector = ccpSub([self getCurrentWaypoint].position, self.position);

    
//    DLog(@"shootVector:%f",shootVector.x);
    if (shootVector.x >= 0) {
        self.flipX = NO;
    }else{
        self.flipX = YES;
    }
    
    
}



@end

@implementation BossBigMonster

+ (id)monster
{
    
    BossBigMonster *monster = nil;
    
    
    
    if (( monster = [Monster spriteWithSpriteFrameName:@"boss_big01.png"])) {
        monster.curHp = monster.totalHp = 20;
        monster.moveDuration = 4;
		monster.curWaypoint = 0;
    }
    //    monster.tag = kMonsterTypeBossBig;
    NSMutableArray *monster1s = [NSMutableArray array];
    
    CCSpriteFrame *spriteFrame;
    int i = 1;
    while ((spriteFrame =  [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                            [NSString stringWithFormat:@"boss_big0%d.png", i]])) {
        [monster1s addObject:spriteFrame];
        i++;
    }
    
    spriteFrame = nil;
    
    CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:monster1s delay:.3f];
    id walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]];
    [monster runAction:walkAction];
    
    [monster schedule:@selector(healthBarLogic:)];
    [monster schedule:@selector(monsterLogic:)];
    
    return monster;
}

@end
@implementation FatBossGreenMonster

+ (id)monster
{
    
    FatBossGreenMonster *monster = nil;
    
    if (( monster = [Monster spriteWithSpriteFrameName:@"fat_boss_green01.png"])) {
        monster.curHp = monster.totalHp = 20;
        monster.moveDuration = 8;
		monster.curWaypoint = 0;
    }
    
    NSMutableArray *monster1s = [NSMutableArray array];
    CCSpriteFrame *spriteFrame;
    int i = 1;
    while ((spriteFrame =  [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                            [NSString stringWithFormat:@"fat_boss_green0%d.png", i]])) {
        [monster1s addObject:spriteFrame];
        i++;
    }
    
    spriteFrame = nil;
    
    CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:monster1s delay:.3f];
    id walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]];
    [monster runAction:walkAction];
    
    [monster schedule:@selector(healthBarLogic:)];
    [monster schedule:@selector(monsterLogic:)];
    return monster;
}

@end
@implementation FatGreenMonster

+ (id)monster
{
    FatGreenMonster *monster = nil;
    
    if (( monster = [Monster spriteWithSpriteFrameName:@"fat_green01.png"])) {
        monster.curHp = monster.totalHp = 20;
        monster.moveDuration = 4;
		monster.curWaypoint = 0;
    }
    
    NSMutableArray *monster1s = [NSMutableArray array];
    CCSpriteFrame *spriteFrame;
    int i = 1;
    while ((spriteFrame =  [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                            [NSString stringWithFormat:@"fat_green0%d.png", i]])) {
        [monster1s addObject:spriteFrame];
        i++;
    }
    
    spriteFrame = nil;
    
    CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:monster1s delay:.3f];
    id walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]];
    [monster runAction:walkAction];
    
    [monster schedule:@selector(healthBarLogic:)];
    
    return monster;
}

@end
@implementation FlyBlueMonster

+ (id)monster
{
    FlyBlueMonster *monster = nil;
    
    if (( monster = [Monster spriteWithSpriteFrameName:@"fly_blue01.png"])) {
        monster.curHp = monster.totalHp = 20;
        monster.moveDuration = 4;
		monster.curWaypoint = 0;
    }
    
    NSMutableArray *monster1s = [NSMutableArray array];
    CCSpriteFrame *spriteFrame;
    int i = 1;
    while ((spriteFrame =  [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                            [NSString stringWithFormat:@"fly_blue0%d.png", i]])) {
        [monster1s addObject:spriteFrame];
        i++;
    }
    
    spriteFrame = nil;
    
    CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:monster1s delay:.3f];
    id walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]];
    [monster runAction:walkAction];
    [monster schedule:@selector(healthBarLogic:)];
    [monster schedule:@selector(monsterLogic:)];
    return monster;
}

@end
@implementation FlyBossBlueMonster

+ (id)monster
{
    FlyBossBlueMonster *monster = nil;
    
    if (( monster = [Monster spriteWithSpriteFrameName:@"fly_boss_blue01.png"])) {
        monster.curHp = monster.totalHp = 20;
        monster.moveDuration = 4;
		monster.curWaypoint = 0;
    }
    
    NSMutableArray *monster1s = [NSMutableArray array];
    CCSpriteFrame *spriteFrame;
    int i = 1;
    while ((spriteFrame =  [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                            [NSString stringWithFormat:@"fly_boss_blue0%d.png", i]])) {
        [monster1s addObject:spriteFrame];
        i++;
    }
    
    spriteFrame = nil;
    
    CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:monster1s delay:.3f];
    id walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]];
    [monster runAction:walkAction];
    [monster schedule:@selector(healthBarLogic:)];
    [monster schedule:@selector(monsterLogic:)];
    return monster;
}

@end
@implementation FlyBossYellowMonster

+ (id)monster
{
    FlyBossYellowMonster *monster = nil;
    
    if (( monster = [Monster spriteWithSpriteFrameName:@"fly_boss_yellow01.png"])) {
        monster.curHp = monster.totalHp = 20;
        monster.moveDuration = 4;
		monster.curWaypoint = 0;
    }
    
    NSMutableArray *monster1s = [NSMutableArray array];
    CCSpriteFrame *spriteFrame;
    int i = 1;
    while ((spriteFrame =  [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                            [NSString stringWithFormat:@"fly_boss_yellow0%d.png", i]])) {
        [monster1s addObject:spriteFrame];
        i++;
    }
    
    spriteFrame = nil;
    
    CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:monster1s delay:.3f];
    id walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]];
    [monster runAction:walkAction];
    [monster schedule:@selector(healthBarLogic:)];
    [monster schedule:@selector(monsterLogic:)];
    return monster;
}

@end
@implementation FlyYellowMonster

+ (id)monster
{
    FlyYellowMonster *monster = nil;
    
    if (( monster = [Monster spriteWithSpriteFrameName:@"fly_yellow01.png"])) {
        monster.curHp = monster.totalHp = 20;
        monster.moveDuration = 4;
		monster.curWaypoint = 0;
    }
    
    NSMutableArray *monster1s = [NSMutableArray array];
    CCSpriteFrame *spriteFrame;
    int i = 1;
    while ((spriteFrame =  [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                            [NSString stringWithFormat:@"fly_yellow0%d.png", i]])) {
        [monster1s addObject:spriteFrame];
        i++;
    }
    
    spriteFrame = nil;
    
    CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:monster1s delay:.3f];
    id walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]];
    [monster runAction:walkAction];
    [monster schedule:@selector(healthBarLogic:)];
    [monster schedule:@selector(monsterLogic:)];
    return monster;
}

@end
@implementation LandBossNimaMonster

+ (id)monster
{
    LandBossNimaMonster *monster = nil;
    
    if (( monster = [Monster spriteWithSpriteFrameName:@"land_boss_nima01.png"])) {
        monster.curHp = monster.totalHp = 20;
        monster.moveDuration = 4;
		monster.curWaypoint = 0;
    }
    
    NSMutableArray *monster1s = [NSMutableArray array];
    CCSpriteFrame *spriteFrame;
    int i = 1;
    while ((spriteFrame =  [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                            [NSString stringWithFormat:@"land_boss_nima0%d.png", i]])) {
        [monster1s addObject:spriteFrame];
        i++;
    }
    
    spriteFrame = nil;
    
    CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:monster1s delay:.3f];
    id walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]];
    [monster runAction:walkAction];
    [monster schedule:@selector(healthBarLogic:)];
    [monster schedule:@selector(monsterLogic:)];
    return monster;
}

@end
@implementation LandBossPinkMonster

+ (id)monster
{
    LandBossPinkMonster *monster = nil;
    
    if (( monster = [Monster spriteWithSpriteFrameName:@"land_boss_pink01.png"])) {
        monster.curHp = monster.totalHp = 20;
        monster.moveDuration = 4;
		monster.curWaypoint = 0;
    }
    
    NSMutableArray *monster1s = [NSMutableArray array];
    CCSpriteFrame *spriteFrame;
    int i = 1;
    while ((spriteFrame =  [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                            [NSString stringWithFormat:@"land_boss_pink0%d.png", i]])) {
        [monster1s addObject:spriteFrame];
        i++;
    }
    
    spriteFrame = nil;
    
    CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:monster1s delay:.3f];
    id walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]];
    [monster runAction:walkAction];
    [monster schedule:@selector(healthBarLogic:)];
    [monster schedule:@selector(monsterLogic:)];
    return monster;
}

@end
@implementation LandBossStarMonster

+ (id)monster
{
    LandBossStarMonster *monster = nil;
    
    if (( monster = [Monster spriteWithSpriteFrameName:@"land_boss_star01.png"])) {
        monster.curHp = monster.totalHp = 20;
        monster.moveDuration = 4;
		monster.curWaypoint = 0;
    }
    
    NSMutableArray *monster1s = [NSMutableArray array];
    CCSpriteFrame *spriteFrame;
    int i = 1;
    while ((spriteFrame =  [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                            [NSString stringWithFormat:@"land_boss_star0%d.png", i]])) {
        [monster1s addObject:spriteFrame];
        i++;
    }
    
    spriteFrame = nil;
    
    CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:monster1s delay:.3f];
    id walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]];
    [monster runAction:walkAction];
    [monster schedule:@selector(healthBarLogic:)];
    [monster schedule:@selector(monsterLogic:)];
    return monster;
}

@end
@implementation LandNimaMonster

+ (id)monster
{
    LandNimaMonster *monster = nil;
    
    if (( monster = [Monster spriteWithSpriteFrameName:@"land_nima01.png"])) {
        monster.curHp = monster.totalHp = 20;
        monster.moveDuration = 4;
		monster.curWaypoint = 0;
    }
    
    NSMutableArray *monster1s = [NSMutableArray array];
    CCSpriteFrame *spriteFrame;
    int i = 1;
    while ((spriteFrame =  [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                            [NSString stringWithFormat:@"land_nima0%d.png", i]])) {
        [monster1s addObject:spriteFrame];
        i++;
    }
    
    spriteFrame = nil;
    
    CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:monster1s delay:.3f];
    id walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]];
    [monster runAction:walkAction];
    [monster schedule:@selector(healthBarLogic:)];
    [monster schedule:@selector(monsterLogic:)];
    return monster;
}

@end
@implementation LandPinkMonster

+ (id)monster
{
    LandPinkMonster *monster = nil;
    
    if (( monster = [Monster spriteWithSpriteFrameName:@"land_pink01.png"])) {
        monster.curHp = monster.totalHp = 20;
        monster.moveDuration = 4;
		monster.curWaypoint = 0;
    }
    
    NSMutableArray *monster1s = [NSMutableArray array];
    CCSpriteFrame *spriteFrame;
    int i = 1;
    while ((spriteFrame =  [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                            [NSString stringWithFormat:@"land_pink0%d.png", i]])) {
        [monster1s addObject:spriteFrame];
        i++;
    }
    
    spriteFrame = nil;
    
    CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:monster1s delay:.3f];
    id walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]];
    [monster runAction:walkAction];
    [monster schedule:@selector(healthBarLogic:)];
    [monster schedule:@selector(monsterLogic:)];
    return monster;
}

@end
@implementation LandStarMonster

+ (id)monster
{
    LandStarMonster *monster = nil;
    
    if (( monster = [Monster spriteWithSpriteFrameName:@"land_star01.png"])) {
        monster.curHp = monster.totalHp = 20;
        monster.moveDuration = 4;
		monster.curWaypoint = 0;
    }
    
    NSMutableArray *monster1s = [NSMutableArray array];
    CCSpriteFrame *spriteFrame;
    int i = 1;
    while ((spriteFrame =  [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                            [NSString stringWithFormat:@"land_star0%d.png", i]])) {
        [monster1s addObject:spriteFrame];
        i++;
    }
    
    spriteFrame = nil;
    
    CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:monster1s delay:.3f];
    id walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]];
    [monster runAction:walkAction];
    [monster schedule:@selector(healthBarLogic:)];
    [monster schedule:@selector(monsterLogic:)];
    return monster;
}

@end


