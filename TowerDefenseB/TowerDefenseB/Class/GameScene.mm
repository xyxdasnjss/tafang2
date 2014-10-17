//
//  GameScene.m
//  TowerDefenseB
//
//  Created by xyxd mac on 12-11-22.
//
//
/**
 ====================================
 2012年12月06日11:15:01
 准备,点击后,添加addTower层
 ====================================
 */

#import "GameScene.h"
#import "WayPoint.h"
#import "Monster.h"
#import "DataModel.h"
#import "Wave.h"
#import "Tower.h"
#import "ReadyLayer.h"
#import "HelloWorldLayer.h"
#import "AddTowerLayer.h"
#import "MyObject.h"
#import "GameMenuLayer.h"
#import "Projectile.h"
#import "GameOverLayer.h"
#import "BaseAttributes.h"
#import "SimpleAudioEngine.h"
#import "TowerMenuLayer.h"

@interface GameScene ()
{
    CCSpriteBatchNode *items;//资源文件
    CCSpriteBatchNode *object01;
    
    
    CGSize winSize;
    ReadyLayer *ready;
    
    CCSprite *stop;
    CCSprite *stop1;
}

@end

@implementation GameScene

@synthesize tileMap = _tileMap;

@synthesize typeBG = _typeBG;
@synthesize typeTheme = _typeTheme;
@synthesize currentLevel = _currentLevel;
@synthesize isShowTowerLayer = _isShowTowerLayer;
@synthesize isShowTowerMenu = _isShowTowerMenu;
@synthesize gameMenu = _gameMenu;


+(CCScene *) scene
{
    
    
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameScene *layer = [GameScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

+(CCScene *) sceneWithTheme:(int)themeType withBg:(int)bg
{
    
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameScene *layer = [GameScene node];
    layer.typeTheme = themeType;
    layer.typeBG = bg;
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


- (id) init
{
    if ((self = [super init])) {
        
        
        [Flurry logEvent:@"GameScene" timed:YES];
        
        [BaseAttributes reset];
        [DataModel reset];
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"BGMusic01.mp3"];
        
        self.isTouchEnabled = YES;
        
        winSize = [CCDirector sharedDirector].winSize;
        
        
        
        _gameMenu = [[GameMenuLayer alloc]init];
        [self addChild:_gameMenu z:kZMenuBg];
        
        
        
        
        //test
        //        CCSprite *test = [CCSprite spriteWithSpriteFrameName:@"targetscleard_CN.png"];
        //        test.position = ccp(winSize.width*.5, winSize.height*.5);
        //        [self addChild:test z:kZMapChild];
        //honor_0  "
        //menublood_01      长条 渐变
        //point01           目标选择,红色的
        //select_01         选择的,白方块
        //targetscleard_CN.png 所有道具都被清空了
        
        
        
        
    }
    
    return self;
    
}

- (void) onEnter
{
    [super onEnter];
    
    
    //加载 地图 文件TMX============================
    NSString *path = [[NSBundle mainBundle] pathForResource:@"themes" ofType:@"plist"];
    NSDictionary* themeDictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    DLog(@"path:%@",path);DLog(@"%@",[themeDictionary description]);
    
    NSString *themePath;
    switch (_typeTheme) {
        case kTypeSkyLine:
        {
            //actual theme path
            themePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[themeDictionary objectForKey:@"Theme1"]];
        }break;
        case kTypeJungle:
        {
            //actual theme path
            themePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[themeDictionary objectForKey:@"Theme2"]];
        }break;
        case kTypeDesert:
        {
            //actual theme path
            themePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[themeDictionary objectForKey:@"Theme3"]];
        }break;
        case kTypeExtreme:
        {
            //actual theme path
            themePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[themeDictionary objectForKey:@"Theme5"]];
        }break;
        case kTypeDeepSea:
        {
            
        }break;
            
        default:
        {
            themePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[themeDictionary objectForKey:@"Theme1"]];
        }break;
    }
    
    NSString *pathBg = [NSString stringWithFormat:@"BG%d",_typeBG];
    pathBg = [themePath stringByAppendingPathComponent:pathBg];
    DLog(@"%@",pathBg);
    
    
    _tileMap = [CCTMXTiledMap tiledMapWithTMXFile:[pathBg stringByAppendingPathComponent:@"BGPath.tmx"]];
    [self addChild:_tileMap z:kZMapBg];
    
    
    
    
    
    //加载 地图 背景图片============================
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[pathBg stringByAppendingPathComponent:@"BG.plist"]];
    CCSpriteBatchNode *mapBgNode = [CCSpriteBatchNode batchNodeWithFile:[pathBg stringByAppendingPathComponent:@"BG.pvr.ccz"]];
    [self addChild:mapBgNode z:kZMapBg];
    
    DLog(@"%@",[themePath stringByAppendingPathComponent:@"BG.plist"]);
    
    
    
    CCSprite *mapBg;
    switch (_typeTheme) {
        case kTypeSkyLine:
        {
            mapBg = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"skymap%02d.png",_typeBG]];//
        }break;
        case kTypeJungle:{
            mapBg = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"grassmap%02d.png",_typeBG]];//
        }break;
        case kTypeDesert:{
            mapBg = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"desertmap%02d.png",_typeBG]];//
        }break;
        case kTypeExtreme:{
            mapBg = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%d.png",_typeBG]];//
        }break;
        case kTypeDeepSea:{
            
        }break;
            
        default:
        {
            mapBg = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"skymap%02d.png",_typeBG]];//
        }break;
    }
    
    mapBg.position = ccp(winSize.width/2,winSize.height/2);
    [mapBgNode addChild:mapBg z:kZMapBg];
    
    
    
    NSString *pathItems = [themePath stringByAppendingPathComponent:@"Items"];
    
    DLog(@"%@",pathItems);
    
    
    
    //加载 地图 上的 可攻击的物品,如:云彩,宝箱============================
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[pathItems stringByAppendingPathComponent:@"Object01.plist"]];
    
    object01 = [CCSpriteBatchNode batchNodeWithFile:[pathItems stringByAppendingPathComponent:@"Object01.pvr.ccz"]];
    [self addChild:object01 z:kZMenuChild];
    
    
    
    //加载 路线点
    [self addWaypoint];
    
    
    //添加 开始点
    CCSprite *start = [CCSprite spriteWithSpriteFrameName:@"start01.png"];
    start.position = ccpAdd([self getFirstWayPoint].position, ccp(start.contentSize.width*.5, 0));
    [object01 addChild:start z:kZMapChild];
    
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Items02.plist"];
    items = [CCSpriteBatchNode batchNodeWithFile:@"Items02.pvr.ccz"];
    [self addChild:items z:kZMenuBg];
    
    
    
    int hlbHp = [BaseAttributes sharedAttributes].baseHealth;
    
    NSAssert(hlbHp == 10, @"未初始化");
    
    //添加 结束点 (在 Items02.pvr.ccz里)
    stop = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"hlb%d.png",hlbHp]];
    stop.position = ccpAdd([self getLastWayPoint:1].position, ccp(stop.contentSize.width*.3, 0));
    [items addChild:stop z:kZMapChild];
    
    
    
    
    
    stop1 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"BossHP%02d.png",hlbHp]];
    stop1.position = ccpAdd([self getLastWayPoint:0].position, ccp(stop1.contentSize.width*.5, 0));
    [items addChild:stop1 z:kZMapChild];
    
    
    
    
    
    
    
    ready = [[ReadyLayer alloc]init];
    ready.gameLayer = self;
    [self addChild:ready z:kZMapChild tag:15];
    
    
    
    
    
    
    
    //加载 Monster
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[pathItems stringByAppendingPathComponent:@"Monsters01.plist"]];
    CCSpriteBatchNode *monsters = [CCSpriteBatchNode batchNodeWithFile:[pathItems stringByAppendingPathComponent:@"Monsters01.pvr.ccz"]];
    [self addChild:monsters z:kZMapChild];
    
    [self addWaves];
    
    DataModel *m = [DataModel getModel];
    [_gameMenu.waveTotalCountLabel setString:[NSString stringWithFormat:@"%d",m.waves.count]];
    
    
    [self addObjects];//object
    [self addObjectsInMap];//objects
    [self addInitTowerInMap];//towers
    
    
}

- (void) onExit
{
    [super onExit];
    DLog(@"GameScene onExit");
    [Flurry endTimedEvent:@"GameScene" withParameters:nil];
}



-(void)addWaves
{
	DataModel *m = [DataModel getModel];
	
	Wave *wave = nil;
    
    wave = [[Wave alloc] initWithMonster:kMonsterTypeBossBig SpawnRate:2.5 TotalMonsters:1];
	[m.waves addObject:wave];
	wave = nil;

    wave = [[Wave alloc] initWithMonster:kMonsterTypeFatBossGreen SpawnRate:2.35 TotalMonsters:3];
	[m.waves addObject:wave];
	wave = nil;
    
    wave = [[Wave alloc] initWithMonster:kMonsterTypeFatGreen SpawnRate:1.5 TotalMonsters:3];
	[m.waves addObject:wave];
	wave = nil;
    
    wave = [[Wave alloc] initWithMonster:kMonsterTypeFlyBlue SpawnRate:1.5 TotalMonsters:3];
	[m.waves addObject:wave];
	wave = nil;
    
    wave = [[Wave alloc] initWithMonster:kMonsterTypeFlyBossBlue SpawnRate:1.5 TotalMonsters:3];
	[m.waves addObject:wave];
	wave = nil;
    
    wave = [[Wave alloc] initWithMonster:kMonsterTypeFlyBossYellow SpawnRate:1.5 TotalMonsters:3];
	[m.waves addObject:wave];
	wave = nil;
    
    wave = [[Wave alloc] initWithMonster:kMonsterTypeFlyYellow SpawnRate:1.5 TotalMonsters:3];
	[m.waves addObject:wave];
	wave = nil;
    
    wave = [[Wave alloc] initWithMonster:kMonsterTypeLandBossNima SpawnRate:2.5 TotalMonsters:3];
	[m.waves addObject:wave];
	wave = nil;
    
    wave = [[Wave alloc] initWithMonster:kMonsterTypeLandBossPink SpawnRate:2.5 TotalMonsters:3];
	[m.waves addObject:wave];
	wave = nil;
    
    wave = [[Wave alloc] initWithMonster:kMonsterTypeLandBossStar SpawnRate:2.5 TotalMonsters:3];
	[m.waves addObject:wave];
	wave = nil;
    
    wave = [[Wave alloc] initWithMonster:kMonsterTypeLandNima SpawnRate:2.0 TotalMonsters:3];
	[m.waves addObject:wave];
	wave = nil;
    
    wave = [[Wave alloc] initWithMonster:kMonsterTypeLandPink SpawnRate:2.5 TotalMonsters:3];
	[m.waves addObject:wave];
	wave = nil;
    
    wave = [[Wave alloc] initWithMonster:kMonsterTypeLandStar SpawnRate:2.5 TotalMonsters:3];
	[m.waves addObject:wave];
	wave = nil;
    
    //=======================================
}




- (void) addWaypoint
{
    DataModel *m = [DataModel getModel];
    
	CCTMXObjectGroup *objects = [self.tileMap objectGroupNamed:@"PATH"];
    
	WayPoint *wp = nil;
	
	int wayPointCounter = 1;
	NSMutableDictionary *wayPoint;
	while ((wayPoint = [objects objectNamed:[NSString stringWithFormat:@"PT%d", wayPointCounter]])) {
		int x = [[wayPoint valueForKey:@"x"] intValue];
		int y = [[wayPoint valueForKey:@"y"] intValue];
		
        if (WINSCALE == 1) {
            x = x * .5;
            y = y * .5;
        }
        
        
		wp = [WayPoint node];
		wp.position = ccp(x, y);
        
		[m.waypoints addObject:wp];
		wayPointCounter++;
	}
	
	NSAssert([m.waypoints count] > 0, @"Waypoint objects missing");
	wp = nil;
}


- (WayPoint*) getFirstWayPoint
{
    DataModel *m = [DataModel getModel];
    WayPoint *wp = [m.waypoints objectAtIndex:0];
    return wp;
}

- (WayPoint*) getLastWayPoint:(int)index//0,倒数第一个,1倒数第二个
{
    DataModel *m = [DataModel getModel];
    WayPoint *wp = [m.waypoints objectAtIndex:m.waypoints.count-1-index];
    return wp;
}


- (Wave *)getCurrentWave
{
	
	DataModel *m = [DataModel getModel];
    if (m.waves.count <= self.currentLevel)
    {
        return nil;
    }
	Wave * wave = (Wave *) [m.waves objectAtIndex:self.currentLevel];
	
	return wave;
}

- (Wave *)getNextWave
{
	
	DataModel *m = [DataModel getModel];
	
	self.currentLevel++;
	
	if (self.currentLevel == (m.waves.count-1))
    {
        DLog(@"最后一波");
    }else if (self.currentLevel > (m.waves.count-1))
    {
        return nil;
        
    }
    
	
    Wave * wave = (Wave *) [m.waves objectAtIndex:self.currentLevel];
    
    return wave;
}

-(void)addTarget {
    
	DataModel *m = [DataModel getModel];
	Wave * wave = [self getCurrentWave];
    
    
	if (wave.totalMonsters == 0) {
		return;
	}
    
    
    
	wave.totalMonsters--;
    
	Monster *target = nil;
    
    switch (wave.monsterType) {
        case kMonsterTypeBossBig:
        {
            target = [BossBigMonster monster];
        }break;
        case kMonsterTypeFatBossGreen:
        {
            target = [FatBossGreenMonster monster];
        }break;
        case kMonsterTypeFatGreen:
        {
            target = [FatGreenMonster monster];
        }break;
        case kMonsterTypeFlyBlue:
        {
            target = [FlyBlueMonster monster];
        }break;
        case kMonsterTypeFlyBossBlue:
        {
            target = [FlyBossBlueMonster monster];
        }break;
        case kMonsterTypeFlyBossYellow:
        {
            target = [FlyBossYellowMonster monster];
        }break;
        case kMonsterTypeFlyYellow:
        {
            target = [FlyYellowMonster monster];
        }break;
        case kMonsterTypeLandBossNima:
        {
            target = [LandBossNimaMonster monster];
        }break;
        case kMonsterTypeLandBossPink:
        {
            target = [LandBossPinkMonster monster];
        }break;
        case kMonsterTypeLandBossStar:
        {
            target = [LandBossStarMonster monster];
        }break;
        case kMonsterTypeLandNima:
        {
            target = [LandNimaMonster monster];
        }break;
        case kMonsterTypeLandPink:
        {
            target = [LandPinkMonster monster];
        }break;
        case kMonsterTypeLandStar:
        {
            target = [LandStarMonster monster];
        }break;
            
            
        default:
            break;
    }
    
    
    
    
    
    //    target.scaleX = self.tileMap.tileSize.width/target.contentSize.width;
    //    target.scaleY = self.tileMap.tileSize.height/target.contentSize.height;
    
    //    DLog(@"self.tileMap.tileSize.width:%f",self.tileMap.tileSize.width);
    //    DLog(@"target.contentSize.width:%f",target.contentSize.width);
    //
    //    DLog(@"self.tileMap.tileSize.height:%f",self.tileMap.tileSize.height);
    //    DLog(@"target.contentSize.height:%f",target.contentSize.height);
    
    
    float tScale = self.tileMap.tileSize.width/target.contentSize.width*.5;
    target.scale = tScale;
    
    
	WayPoint *waypoint = [target getCurrentWaypoint];
	target.position = ccpAdd(waypoint.position, ccp(target.contentSize.width*.5*tScale,0));//waypoint.position;
	waypoint = [target getNextWaypoint ];
    
	[self addChild:target z:kZMapChild];
    
    
    
    //血条背景
    CCSprite *backGroundSprite = [CCSprite spriteWithSpriteFrameName:@"MonsterHP02.png"];
    target.healthBarBg = [CCProgressTimer progressWithSprite:backGroundSprite];
    target.healthBarBg.percentage = 100;
    target.healthBarBg.position = ccp(target.position.x, (target.position.y+20));
    [self addChild:target.healthBarBg z:kZMapChild];
    
    
    //血条血量
    CCSprite *planeHPSprite = [CCSprite spriteWithSpriteFrameName:@"MonsterHP01.png"];
    target.healthBar = [CCProgressTimer progressWithSprite:planeHPSprite];
    target.healthBar.type = kCCProgressTimerTypeBar;
    target.healthBar.midpoint = ccp(0, 0.5);
    target.healthBar.barChangeRate = ccp(1, 0);
    target.healthBar.percentage = 100;
    target.healthBar.position = target.healthBarBg.position;//ccp(target.position.x,(target.position.y+20));
    [self addChild:target.healthBar z:kZMapChild];
    
    
    
    
	int moveDuration = target.moveDuration;
	id actionMove = [CCMoveTo actionWithDuration:moveDuration position:ccpAdd(waypoint.position, ccp(target.contentSize.width*.5*tScale, -target.contentSize.height*.5*tScale))];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(FollowPath:)];
	[target runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
    
	// Add to targets array
	target.tag = 1;
	[m.targets addObject:target];
}

-(void)addObjects
{
    
    DataModel *m = [DataModel getModel];
	CCTMXObjectGroup *objects = [self.tileMap objectGroupNamed:@"PATH"];
    
    
    for (int i = 1; i <= 7; i++) {
        
        MyObject *myObject;
        int objCounter = 1;
        NSMutableDictionary *objectPoint;
        while ((objectPoint = [objects objectNamed:[NSString stringWithFormat:@"%dOb%d",i,objCounter]])) {
            
            int x = [[objectPoint valueForKey:@"x"] intValue];
            int y = [[objectPoint valueForKey:@"y"] intValue];
            int width = [[objectPoint valueForKey:@"width"] intValue];
            int height = [[objectPoint valueForKey:@"height"] intValue];
            
            if (WINSCALE == 1) {
                x = x * .5;
                y = y * .5;
                width = width *.5;
                height = height *.5;
            }
            
            myObject = [MyObject node];
            myObject.position = ccp(x, y);
            myObject.contentSize = CGSizeMake(width, height);
            
            
            
            CCSprite *cloud = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"cloud0%d.png",i ]];
            [object01 addChild:cloud z:10];
            cloud.position = ccpAdd(CGPointMake(x, y), CGPointMake(cloud.contentSize.width*.5, cloud.contentSize.height*.5));
            
            
            //            DLog(@"size1:%@",NSStringFromCGSize(myObject.contentSize));
            //            DLog(@"size2:%@",NSStringFromCGSize(cloud.contentSize));
            
            
            
            [m.mObjectsIn addObject:myObject];
            objCounter ++;
            
            
            
        }
        
        NSAssert(m.mObjectsIn.count>0, @"526objects missing");
        objectPoint = nil;
        
        
    }
    
    
    //cloud10是宝箱,11,12
    //hlb0,萝卜的底座
    CCSprite *hlb = [CCSprite spriteWithSpriteFrameName:@"hlb0.png"];
    hlb.position = ccpAdd([self getLastWayPoint:1].position, ccp(hlb.contentSize.width*.5, 0));
    [object01 addChild:hlb];
    
    
    
    
}

-(void)addObjectsInMap
{
    
    DataModel *m = [DataModel getModel];
	CCTMXObjectGroup *objects = [self.tileMap objectGroupNamed:@"PATH"];
    
    
    MyObject *myObject;
    int objCounter = 1;
    NSMutableDictionary *objectPoint;
    while ((objectPoint = [objects objectNamed:[NSString stringWithFormat:@"Obj%d",objCounter]])) {
        
        int x = [[objectPoint valueForKey:@"x"] intValue];
        int y = [[objectPoint valueForKey:@"y"] intValue];
        int width = [[objectPoint valueForKey:@"width"] intValue];
        int height = [[objectPoint valueForKey:@"height"] intValue];
        
        if (WINSCALE == 1) {
            x = x * .5;
            y = y * .5;
            width = width *.5;
            height = height *.5;
        }
        
        myObject = [MyObject node];
        myObject.position = ccp(x, y);
        myObject.contentSize = CGSizeMake(width, height);
        
        
        
        [m.mObjects addObject:myObject];
        objCounter ++;
        
        
        
    }
    
    NSAssert(m.mObjects.count>0, @"738objects missing");
    objectPoint = nil;
}

-(void)addInitTowerInMap
{
    
    DataModel *m = [DataModel getModel];
	CCTMXObjectGroup *objects = [self.tileMap objectGroupNamed:@"PATH"];
    
    
    MyObject *myObject;
    NSMutableDictionary *objectPoint;

    for (int objCounter = 1; objCounter < 10;objCounter++)
    {
        
        if ((objectPoint = [objects objectNamed:[NSString stringWithFormat:@"%dT1",objCounter]])) {
            int x = [[objectPoint valueForKey:@"x"] intValue];
            int y = [[objectPoint valueForKey:@"y"] intValue];
            int width = [[objectPoint valueForKey:@"width"] intValue];
            int height = [[objectPoint valueForKey:@"height"] intValue];
            
            if (WINSCALE == 1) {
                x = x * .5;
                y = y * .5;
                width = width *.5;
                height = height *.5;
            }
            
            myObject = [MyObject node];
            myObject.position = ccp(x, y);
            myObject.contentSize = CGSizeMake(width, height);

            //放置 初始化的 tower
            [m.towers addObject:myObject];

        }
    }

    objectPoint = nil;
}


-(void)FollowPath:(id)sender
{
    
	Monster *monster = (Monster *)sender;
    
	WayPoint * waypoint = [monster getNextWaypoint];
    
	int moveDuration = monster.moveDuration;
    float tScale = self.tileMap.tileSize.width/monster.contentSize.width*.5;
	id actionMove = [CCMoveTo actionWithDuration:moveDuration position:ccpAdd(waypoint.position, ccp(monster.contentSize.width*.5*tScale, -monster.contentSize.height*.5*tScale))];
	id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(FollowPath:)];
    //fix 走第二段路时,静态了,stopAllAction的目的是???
    //	[monster stopAllActions];
	[monster runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
}



- (CGPoint) tileCoordForPosition:(CGPoint) position
{
    
    int x,y;
    if (WINSCALE == 1)
    {
        
        x = (position.x * 2) / self.tileMap.tileSize.width;
        y = ((self.tileMap.mapSize.height * self.tileMap.tileSize.height) - (position.y * 2)) / self.tileMap.tileSize.height;
        y = y < 0 ? 0 : y;
        
    }else
    {
        x = position.x / self.tileMap.tileSize.width;
        y = ((self.tileMap.mapSize.height * self.tileMap.tileSize.height) - position.y) / self.tileMap.tileSize.height;
        
    }
    
    
	return ccp(x,y);
}


- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}

- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch * touch = [touches anyObject];
    CGPoint mapLocation = [self.tileMap convertTouchToNodeSpace:touch];
    DLog("mapLocation:%@",NSStringFromCGPoint(mapLocation));
    
    
    CGPoint towerLoc = [self tileCoordForPosition: mapLocation];
    DLog("towerLoc:%@",NSStringFromCGPoint(towerLoc));
    
    
    CGPoint loc ;
    if (WINSCALE) {
        loc  = CGPointMake(towerLoc.x * self.tileMap.tileSize.width*.5, winSize.height - towerLoc.y * self.tileMap.tileSize.height*.5);
    }else{
        loc  = CGPointMake(towerLoc.x * self.tileMap.tileSize.width, winSize.height - towerLoc.y * self.tileMap.tileSize.height);
    }
    
    
    //无塔时,点击 objects,显示forbidden
    //有塔时,点击 objects,选择第一攻击对象
    //object被干掉后,可以放塔
    //点击塔,显示 tower菜单,(范围,升级,出售)
    //非objects区域不可以点击
    
    /**
     可以点击:
     
     objects里 无object区域 可以点击
     
     
     不可以点击:
     无塔时:
     1.objects里 有object区域 不可以点击
     2.非objects,不可以点击
     有塔时:
     1.非objects,不可以点击
     
     
     
     */
    
    if (_isShowTowerMenu == YES) {
        
        [self removeChild:[TowerMenuLayer sharedLayer] cleanup:YES];
        _isShowTowerMenu = NO;
        return;
    }
    
    if (_isShowTowerLayer == YES) {
        [self removeChild:[AddTowerLayer sharedLayer] cleanup:YES];
        [AddTowerLayer mReset];
        _isShowTowerLayer = NO;
        return;
    }
    
    
    
    
    if ([self canBuildOnTilePosition:mapLocation]) {
        //可以建造,显示 建造menu,menuitem点击后,建tower
        
        //ttttttt
        //        [self addTower:loc withType:kTowerTypeBottle];
        //ttttttt
        
        
        
        
        //点击addTowerLayer menu后,无反应,,,
        if (_isShowTowerLayer == NO) {
            
            
            [self addChild:[AddTowerLayer sharedLayer] z:kZMapChild];
            [AddTowerLayer sharedLayer].gameLayer = self;
            [[AddTowerLayer sharedLayer] setMPosition:loc];
            _isShowTowerLayer = YES;
            
        }else{
            [self removeChild:[AddTowerLayer sharedLayer] cleanup:YES];
            [AddTowerLayer mReset];
            _isShowTowerLayer = NO;
        }
        
        
        
    }else{
        
        DataModel *m = [DataModel getModel];
        //有塔的地方,不能建造
        for (Tower *tower in m.towers) {
            if (CGRectContainsPoint(tower.boundingBox, mapLocation)) {
                
                //
                if (_isShowTowerMenu == NO) {
                    
                    [self addChild:[TowerMenuLayer sharedLayer] z:kZMapChild];
                    [TowerMenuLayer sharedLayer].gameLayer = self;
                    [TowerMenuLayer sharedLayer].mTower = tower;
                    [[TowerMenuLayer sharedLayer] setMPosition:loc];
                    _isShowTowerMenu = YES;
                }

                
                DLog(@"show tower layer");
                return;
            }
            
        }
        
        
        //不 可以,显示 ×
        CCSprite *noAllowBuild = [CCSprite spriteWithSpriteFrameName:@"forbidden.png"];
        
        [self addChild:noAllowBuild z:kZMapChild];
        noAllowBuild.position = ccpAdd(loc, ccp(noAllowBuild.contentSize.width*.5,-noAllowBuild.contentSize.height*.5));
        
        id fadeAction = [CCFadeOut actionWithDuration:.3];
        id fadeFinish = [CCCallFuncN actionWithTarget:self selector:@selector(fadeFinish:)];
        [noAllowBuild runAction:[CCSequence actionOne:fadeAction two:fadeFinish]];
        
        
    }
    
    
    
    
    
    
    
    
    
    //    [self addTower:mapLocation];
    
    
    //        //btn
    //        CCSprite *adventure_normal = [CCSprite spriteWithSpriteFrameName:@"hlb10.png"];
    //        CCSprite *adventure_pressed = [CCSprite spriteWithSpriteFrameName:@"hlb11.png"];
    //
    //
    //
    //        //btn
    //        CCSprite *bose_locked = [CCSprite spriteWithSpriteFrameName:@"hlb12.png"];
    //        CCSprite *bose_pressed = [CCSprite spriteWithSpriteFrameName:@"hlb13.png"];
    //
    //
    //        CCSprite *bose_locked1 = [CCSprite spriteWithSpriteFrameName:@"hlb14.png"];
    //        CCSprite *bose_pressed1 = [CCSprite spriteWithSpriteFrameName:@"hlb15.png"];
    //
    //
    //        CCSprite *bose_locked11 = [CCSprite spriteWithSpriteFrameName:@"hlb17.png"];
    //        CCSprite *bose_pressed12 = [CCSprite spriteWithSpriteFrameName:@"hlb18.png"];
    //
    //
    ////    CCSprite *hlb11 = [CCSprite spriteWithSpriteFrameName:@"hlb11.png"];
    ////    CCSprite *hlb12 = [CCSprite spriteWithSpriteFrameName:@"hlb12.png"];
    ////
    ////
    ////
    ////    CCSprite *hlb13 = [CCSprite spriteWithSpriteFrameName:@"hlb13.png"];
    ////    CCSprite *hlb14 = [CCSprite spriteWithSpriteFrameName:@"hlb14.png"];
    ////
    ////    CCSprite *hlb15 = [CCSprite spriteWithSpriteFrameName:@"hlb15.png"];
    ////    CCSprite *hlb17 = [CCSprite spriteWithSpriteFrameName:@"hlb17.png"];
    //
    //
    //
    //        CCMenuItemSprite *test = [CCMenuItemSprite itemWithNormalSprite:adventure_normal
    //                                                         selectedSprite:adventure_pressed
    //                                                                  block:^(id sender) {
    //
    //
    //
    //
    //                                                                  }];
    //        CCMenuItemSprite *test1 = [CCMenuItemSprite itemWithNormalSprite:bose_locked
    //                                                          selectedSprite:bose_pressed
    //                                                                   block:^(id sender) {
    //
    //                                                                   }];
    //
    //        CCMenuItemSprite *test11 = [CCMenuItemSprite itemWithNormalSprite:bose_locked1
    //                                                           selectedSprite:bose_pressed1
    //                                                                    block:^(id sender) {
    //
    //                                                                    }];
    //
    //        CCMenuItemSprite *test12 = [CCMenuItemSprite itemWithNormalSprite:bose_locked11
    //                                                           selectedSprite:bose_pressed12
    //                                                                    block:^(id sender) {
    //
    //                                                                    }];
    //
    //
    //
    //
    //
    //
    //        CCMenu *menu =  [CCMenu menuWithItems:test,test1,test11,test12, nil];
    //
    //        [menu alignItemsHorizontally];
    //        [menu setPosition:loc];
    //
    //
    //        [self addChild: menu z:10];
    
    
    
    //    for( CCSpriteBatchNode* child in [self.tileMap children] ) {
    //        DLog(@"%@",child);
    //        [[child texture] setAntiAliasTexParameters];
    //    }
    
    
    
    //	int tileGid = [self.background tileGIDAt:towerLoc];
    //	NSDictionary *props = [self.tileMap propertiesForGID:tileGid];
    //	NSString *type = [props valueForKey:@"buildable"];
    
    
    
}

- (void) addTower: (CGPoint)pos withType:(int)towerType
{
	DataModel *m = [DataModel getModel];
    Tower *tower = nil;
    switch (towerType) {
        case kTowerBottle:
        {
            
            tower = [TBottle tower];
            
        }break;
        case kTowerArrow:
        {
            
            tower = [TArrow tower];
            
        }break;
        case kTowerBall:
        {
            
            tower = [TBall tower];
            
        }break;
        case kTowerBlueStar:
        {
            
            tower = [TBlueStar tower];
            
        }break;
        case kTowerFan:
        {
            
            tower = [TFan tower];
            
        }break;
        case kTowerFireBottle:
        {
            
            tower = [TFireBottle tower];
            
        }break;
        case kTowerPin:
        {
            
            tower = [TPin tower];
            
        }break;
        case kTowerPlane:
        {
            
            tower = [TPlane tower];
            
        }break;
        case kTowerRocket:
        {
            
            tower = [TRocket tower];
            
        }break;
        case kTowerShit:
        {
            
            tower = [TShit tower];
            
        }break;
        case kTowerSnow:
        {
            
            tower = [TSnow tower];
            
        }break;
        case kTowerStar:
        {
            
            tower = [TStar tower];
            
        }break;
        case kTowerSun:
        {
            
            tower = [TSun tower];
            
        }break;
            
        default:
        {
            tower = [TBottle tower];
        }break;
    }
    //    DLog(@"%@",NSStringFromCGSize(tower.contentSize));
    ////ttttttttt
    tower.position = ccpAdd(pos, ccp(tower.contentSize.width*.5, -tower.contentSize.height*.5));
    //tttttttt
    //    tower.position = pos;//[self locAddContentSize:pos withSprite:tower withType:-1];
    DLog(@"111%@",NSStringFromCGPoint(pos));
    DLog(@"111%@",NSStringFromCGPoint(tower.position));
    
    
    
    [self addChild:tower.bottom z:kZMapChild];
    [self addChild:tower z:kZMapChild];
    
    [m.towers addObject:tower];
	
    
    
    
}


- (BOOL) canBuildOnTilePosition:(CGPoint) pos
{
    DataModel *m = [DataModel getModel];
    
    
    
    
    
    //第一个塔,objects的地方不能建造,
    //之后,点击objects后,选择第一个攻击对象
    //    if (m.towers.count == 0) {
    
    for (CCSprite *sprite in m.mObjectsIn) {
        if (CGRectContainsPoint(sprite.boundingBox, pos)) {
            return NO;
        }
    }
    
    
    //有塔的地方,不能建造
    for (CCSprite *tower in m.towers) {
        if (CGRectContainsPoint(tower.boundingBox, pos)) {
            return  NO;
        }
        
    }
    
    
    for (CCSprite *object in m.mObjects) {
        if (CGRectContainsPoint(object.boundingBox, pos)) {
            return YES;
        }
    }
    
    
    
    //
    //        return NO;
    //    }else{
    //
    //        //有塔的地方,不能建造
    //        for (CCSprite *tower in m.towers) {
    //            if (CGRectContainsPoint(tower.boundingBox, pos)) {
    //                return  NO;
    //            }
    //
    //        }
    //    }
    //
    
    DLog(@"需要判断,,,,,");
	
	return NO;
}


- (void) fadeFinish:(id)sender
{
    CCSprite *sprite = (CCSprite*)sender;
    [self removeChild:sprite cleanup:YES];
}

- (void) gameLogic:(ccTime)dt {
    
    int hp = [BaseAttributes sharedAttributes].baseHealth;
    if (hp != 7 && hp != 5 && hp != 0) {
        [stop setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"hlb%d.png",hp]]];
        
    }
    if (hp != 0) {
        [stop1 setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"BossHP%02d.png",hp]]];
    }
    
    
    if (hp == 0) {
        
        [self unscheduleAllSelectors];
        
//        [[CCDirector sharedDirector] pause];
        
        _gameOver = [[GameOverLayer alloc] initWithResultType:kResultTypeLose];
        [self addChild:_gameOver z:kZHigh];
        
        
        [BaseAttributes reset];
    }
    
	Wave * wave = [self getCurrentWave];
	static double lastTimeTargetAdded = 0;
    double now = [[NSDate date] timeIntervalSince1970];
    if(lastTimeTargetAdded == 0 || now - lastTimeTargetAdded >= wave.spawnRate) {
        [self addTarget];
        lastTimeTargetAdded = now;
    }
    
    
    if (hp == 10) {
        [self schedule:@selector(hlbHero) interval:10.0];
    }
    
}



- (CGFloat) glPositionHeightToPositionHeight:(CGFloat)mHeight withSprite:(CCNode*)mSprite
{
    
    CGFloat height;
    if (mSprite == nil) {
        height = (winSize.height - mHeight);
    }else{
        height = (winSize.height - mSprite.contentSize.height*.5 - mHeight);
    }
    
    return height;
}

- (CGPoint) locAddContentSize:(CGPoint)point withSprite:(CCSprite*)sprite withType:(int)type
{
    //    if (type == 0) {
    //        return ccpAdd(point, ccp(sprite.contentSize.width*.5, 0));
    //    }else if (type == 1){
    //        return ccpAdd(point, ccp(sprite.contentSize.width*.5, sprite.contentSize.height*.5));
    //    }else if (type == -1){
    //        return ccpAdd(point, ccp(sprite.contentSize.width*.5, -sprite.contentSize.height*.5));
    //    }else
    return point;
    
}

- (void) begin
{
    [self removeChild:ready cleanup:YES];
    
    
    // Call game logic about every second
    [self schedule:@selector(update:)];
    [self schedule:@selector(gameLogic:) interval:1.0];
    self.currentLevel = 0;
}

- (void) reBegin
{
    [self schedule:@selector(update:)];
    [self schedule:@selector(gameLogic:) interval:1.0];
}


- (void)update:(ccTime)dt
{
	DataModel *m = [DataModel getModel];
	NSMutableArray *projectilesToDelete = [[NSMutableArray alloc] init];
    
	for (Projectile *projectile in m.projectiles) {
        //		CGRect projectileRect = CGRectMake(projectile.position.x - (projectile.contentSize.width/2),
        //										   projectile.position.y - (projectile.contentSize.height/2),
        //										   projectile.contentSize.width,
        //										   projectile.contentSize.height);
        
		NSMutableArray *targetsToDelete = [[NSMutableArray alloc] init];
        
		for (CCSprite *target in m.targets) {
            //			CGRect targetRect = CGRectMake(target.position.x - (target.contentSize.width/2),
            //										   target.position.y - (target.contentSize.height/2),
            //										   target.contentSize.width,
            //										   target.contentSize.height);
            //            DLog(@"%@",NSStringFromCGRect(targetRect));
            //            DLog(@"%@",NSStringFromCGRect(target.boundingBox));
            
            //敌人与子弹 碰撞检测
			if (CGRectIntersectsRect(projectile.boundingBox, target.boundingBox)) {
                
                //撞上了,子弹clean
				[projectilesToDelete addObject:projectile];
                
				Monster *monster = (Monster *)target;
				monster.curHp--;
                
                //                DLog(@"curHp:%d",monster.curHp);
                
				if (monster.curHp <= 0) {
                    
                    [self.gameMenu updateMoney:40];
				    [targetsToDelete addObject:target];
 				}
				break;
			}
		}
        
		for (Monster *target in targetsToDelete) {
			[m.targets removeObject:target];
            
			[self removeChild:target cleanup:YES];
            [self removeChild:target.healthBar cleanup:YES];
            [self removeChild:target.healthBarBg cleanup:YES];
		}
        
		
	}
    
	for (CCSprite *projectile in projectilesToDelete) {
		[m.projectiles removeObject:projectile];
		[self removeChild:projectile cleanup:YES];
	}
    
    
    
    
    Wave *wave = [self getCurrentWave];
    
    //    DLog(@"m.targets.count:%d",m.targets.count);
    //    DLog(@"wave.totalMonsters:%d",wave.totalMonsters);
    
    if ([m.targets count] == 0 && wave.totalMonsters <= 0) {
        if (self.currentLevel == m.waves.count-1) {
            DLog(@"ooooookkkkkkkk!!!!! :D");
            
//            [[CCDirector sharedDirector] pause];
            [self unscheduleAllSelectors];
            
            _gameOver = [[GameOverLayer alloc] initWithResultType:kResultTypeWin];
            [self addChild:_gameOver z:kZHigh];
        }
        else
        {
            [self schedule:@selector(waveWait) interval:1.0];
            [_gameMenu newWaveApproaching];
        }
    }
    
	
}


- (void) waveWait
{
    [self unschedule:@selector(waveWait)];
    [self getNextWave];
    [_gameMenu updateWaveCount];
    [_gameMenu newWaveApproachingEnd];
}

- (void) hlbHero
{
    [self unschedule:@selector(hlbHero)];
    int hp = [BaseAttributes sharedAttributes].baseHealth;
    if (hp == 10) {
        NSMutableArray *hlbs = [NSMutableArray array];
        
        CCSpriteFrame *spriteFrame;
        int i = 1;
        while ((spriteFrame =  [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                                [NSString stringWithFormat:@"hlb1%d.png", i]])) {
            [hlbs addObject:spriteFrame];
            i++;
        }
        
        spriteFrame = nil;
        
        CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:hlbs delay:.3f];
        id hlbAction = [CCAnimate actionWithAnimation:walkAnim];
        //        id walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]];
        [stop runAction:hlbAction];
    }
    
    
}




@end

