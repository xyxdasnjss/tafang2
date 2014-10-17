//
//  DataModel.h
//  TowerDefenseB
//
//  Created by xyxd mac on 12-12-5.
//  Copyright (c) 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject
{
//    CCLayer *_gameLayer;
	NSMutableArray *_targets;
	NSMutableArray *_waypoints;
	NSMutableArray *_waves;
    NSMutableArray *_towers;
    
    NSMutableArray *_mObjects;//地图上的object
    NSMutableArray *_mObjectsIn;//地图上object的 云,宝箱等
    NSMutableArray *_projectiles;
}
@property (nonatomic, retain) NSMutableArray * targets;
@property (nonatomic, retain) NSMutableArray * waypoints;
@property (nonatomic, retain) NSMutableArray * waves;
@property (nonatomic, retain) NSMutableArray * towers;
@property (nonatomic, retain) NSMutableArray * projectiles;
@property (nonatomic, retain) NSMutableArray * mObjects;
@property (nonatomic, retain) NSMutableArray * mObjectsIn;

+(DataModel*)getModel;
+ (void) reset;
@end
