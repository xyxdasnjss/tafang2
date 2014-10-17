//
//  Wave.m
//  TowerDefenseB
//
//  Created by xyxd mac on 12-12-5.
//  Copyright 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import "Wave.h"
#import "Monster.h"

@implementation Wave

@synthesize spawnRate = _spawnRate;
@synthesize totalMonsters = _totalMonsters;
@synthesize monsterType = _monsterType;

-(id) init
{
	if( (self=[super init]) ) {
		
	}
	
	return self;
}

- (id)initWithMonster:(MonsterType)monster
            SpawnRate:(float)spawnrate
        TotalMonsters:(int)totalMonsters
{
    
	if( (self = [self init]) )
	{
		_monsterType = monster;
		_spawnRate = spawnrate;
		_totalMonsters = totalMonsters;
	}
	return self;
}

@end
