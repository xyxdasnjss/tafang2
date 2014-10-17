//
//  TowerMenuLayer.m
//  TowerDefenseB
//
//  Created by xyxd mac on 12-11-28.
//
//

#import "TowerMenuLayer.h"
#import "GameScene.h"
#import "Tower.h"
#import "BaseAttributes.h"
#import "GameMenuLayer.h"
#import "Tower.h"

@interface TowerMenuLayer ()
{
    
    id walkAction;
    CGPoint _towerPosition;
    CCMenuItemSprite *sprite1;
    CCMenuItemSprite *sprite2;
}
@property (nonatomic, assign) CGPoint towerPosition;
@end


@implementation TowerMenuLayer
@synthesize select = _select;
@synthesize menu = _menu;
@synthesize gameLayer = _gameLayer;
@synthesize towerPosition = _towerPosition;
@synthesize mTower = _mTower;

static TowerMenuLayer *_sharedContext = nil;

+ (TowerMenuLayer*) sharedLayer
{
	if (!_sharedContext) {
		_sharedContext = [[self alloc] init];
	}
	
	return _sharedContext;
}


- (id) init
{
    if ((self = [super init])) {
        _select = [CCSprite spriteWithSpriteFrameName:@"select_00.png"];
        [self addChild:_select];
        
        
        NSMutableArray *selects = [NSMutableArray array];
        CCSpriteFrame *spriteFrame;
        int i = 1;
        while ((spriteFrame =  [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
                                [NSString stringWithFormat:@"select_0%d.png", i]])) {
            [selects addObject:spriteFrame];
            i++;
        }
        
        spriteFrame = nil;
        
        CCAnimation *walkAnim = [CCAnimation animationWithSpriteFrames:selects delay:.3f];
        walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim]];
        [_select runAction:walkAction];
        
        
//        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"TBottle.plist"];
//        
//        sprite1 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"Bottle01.png"]
//                                          selectedSprite:nil
//                                          disabledSprite:[CCSprite spriteWithSpriteFrameName:@"Bottle00.png"]
//                                                   block:^(id sender)
//                   {
//                       
//                       DLog(@"menu1");
//                      
//                       
//                       
//                   }];
//        
//        
//        
//        
//        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"TShit.plist"];
//        sprite2 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"Shit01.png"]
//                                          selectedSprite:nil
//                                          disabledSprite:[CCSprite spriteWithSpriteFrameName:@"Shit00.png"]
//                                                   block:^(id sender)
//                   {
//                       DLog(@"menu2");
//                      
//                       
//                   }];
//        
//        
//       
//        
//        _menu = [CCMenu menuWithItems:sprite1,sprite2, nil];
//        [_menu alignItemsHorizontally];
//        [self addChild:_menu];
        
        
       
        
    }
    
    return self;
}

//- (void) onEnter
//{
//    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kPriorityTowerMenu swallowsTouches:YES];
//    [super onEnter];
//}
//
//- (void)onExit
//{
//    //取消触摸协议
//    [[[CCDirector sharedDirector] touchDispatcher]removeDelegate:self];
//    [super onExit];
//}

- (void) setMPosition:(CGPoint)mPosition
{
    self.towerPosition = mPosition;
    
    _select.position = ccpAdd(mPosition, ccp(_select.contentSize.width*.5, -_select.contentSize.height*.5));//mPosition;
    [_menu setPosition:ccpAdd(_select.position, ccp(0, _select.contentSize.height))];
    [_select stopAllActions];//fix CRASH: runAction: Action already running
    [_select runAction:walkAction];
}

-(void)draw
{
     [super draw];
    glColorMask(255, 255, 255, 255);
    ccDrawCircle(ccpAdd(self.towerPosition, ccp(self.mTower.contentSize.width*.5, -self.mTower.contentSize.height*.5)), self.mTower.range, 360, 30, false);

   
}

@end

