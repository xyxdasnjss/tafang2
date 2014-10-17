//
//  DataModel.m
//  TowerDefenseB
//
//  Created by xyxd mac on 12-12-5.
//  Copyright (c) 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel
@synthesize targets = _targets;
@synthesize waypoints = _waypoints;
@synthesize waves = _waves;
@synthesize towers = _towers;
@synthesize mObjects = _mObjects;//地图上objects
@synthesize mObjectsIn = _mObjectsIn;//
@synthesize projectiles = _projectiles;

static DataModel *_sharedContext = nil;

+(DataModel*)getModel
{
	if (!_sharedContext) {
		_sharedContext = [[self alloc] init];
	}
	
	return _sharedContext;
}


- (id) init
{
	if ((self = [super init])) {
        
		_targets = [[NSMutableArray alloc] init];
		_waypoints = [[NSMutableArray alloc] init];
		_waves = [[NSMutableArray alloc] init];
        _towers = [[NSMutableArray alloc] init];
        _mObjects = [[NSMutableArray alloc] init];
        _mObjectsIn = [[NSMutableArray alloc] init];
        _projectiles = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)dealloc
{
	
	_targets = nil;
	_waypoints = nil;
	_waves = nil;
    _towers = nil;
    _mObjects = nil;
    _mObjectsIn = nil;
    _projectiles = nil;
    

}

+ (void) reset
{
    _sharedContext = nil;
}
@end
