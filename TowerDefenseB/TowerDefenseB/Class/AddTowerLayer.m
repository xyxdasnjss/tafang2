//
//  AddTowerLayer.m
//  TowerDefenseB
//
//  Created by xyxd mac on 12-12-6.
//  Copyright (c) 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import "AddTowerLayer.h"
#import "GameScene.h"
#import "Tower.h"
#import "BaseAttributes.h"
#import "GameMenuLayer.h"

@interface AddTowerLayer ()
{
    
    id walkAction;
    CGPoint _towerPosition;
    CCMenuItemSprite *sprite1;
    CCMenuItemSprite *sprite2;
}
@property (nonatomic, assign) CGPoint towerPosition;
@end


@implementation AddTowerLayer
@synthesize select = _select;
@synthesize menu = _menu;
@synthesize gameLayer = _gameLayer;
@synthesize towerPosition = _towerPosition;


static AddTowerLayer *_sharedContext = nil;

+ (AddTowerLayer*) sharedLayer
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
        
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"TBottle.plist"];
        
        sprite1 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"Bottle01.png"]
                                                            selectedSprite:nil
                                                            disabledSprite:[CCSprite spriteWithSpriteFrameName:@"Bottle00.png"] 
                                                                     block:^(id sender)
                                     {
                                         
                                         DLog(@"menu1");
                                         int money = [BaseAttributes sharedAttributes].baseMoney;
                                         if (money < 100) {
                                             return;
                                         }
                                        
                                         [self.gameLayer addTower:_towerPosition withType:kTowerBottle];
                                         [self.gameLayer.gameMenu updateMoney:-100];
                                         [self.parent removeChild:self cleanup:YES];
                                         [self reset];
                                         self.gameLayer.isShowTowerLayer = NO;
                                         
                                         
                                     }];

        
        
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"TShit.plist"];
        sprite2 = [CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"Shit01.png"]
                                                            selectedSprite:nil
                                                            disabledSprite:[CCSprite spriteWithSpriteFrameName:@"Shit00.png"] 
                                                                     block:^(id sender)
                                     {
                                         DLog(@"menu2");
                                         int money = [BaseAttributes sharedAttributes].baseMoney;
                                         if (money < 120) {
                                             return;
                                         }
                                         
                                         [self.gameLayer addTower:_towerPosition withType:kTowerShit];
                                         [self.gameLayer.gameMenu updateMoney:-120];
                                         [self.parent removeChild:self cleanup:YES];
                                         [self reset];
                                         self.gameLayer.isShowTowerLayer = NO;
                                         
                                     }];
        
        
        [self updateStatus];
        
        _menu = [CCMenu menuWithItems:sprite1,sprite2, nil];
        [_menu alignItemsHorizontally];
        [self addChild:_menu];
        
        
       [self schedule:@selector(menuLogic:) interval:0.8];
        
    }
    
    return self;
}


- (void) menuLogic:(ccTime)dt
{
    [self updateStatus];
	
}

- (void) updateStatus
{
    int money = [BaseAttributes sharedAttributes].baseMoney;
    if (money >= 120) {
        [sprite1 setIsEnabled:YES];
        [sprite2 setIsEnabled:YES];
    }else if (money >= 100 && money < 120) {
        [sprite1 setIsEnabled:YES];
        [sprite2 setIsEnabled:NO];
    }else {
        [sprite1 setIsEnabled:NO];
        [sprite2 setIsEnabled:NO];
    }
}

- (void) reset
{
    _sharedContext = nil;
}

+ (void) mReset
{
    _sharedContext = nil;
}

- (void) setMPosition:(CGPoint)mPosition
{
    self.towerPosition = mPosition;
    
    _select.position = ccpAdd(mPosition, ccp(_select.contentSize.width*.5, -_select.contentSize.height*.5));//mPosition;
    [_menu setPosition:ccpAdd(_select.position, ccp(0, _select.contentSize.height))];
    [_select stopAllActions];//fix CRASH: runAction: Action already running
    [_select runAction:walkAction];
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView: [touch view]];
    CGPoint pos =  [[CCDirector sharedDirector] convertToGL:touchLocation];
    
    
    if (CGRectContainsPoint(_select.boundingBox, pos)) {
        return  NO;
    }
    
    DLog(@"%@",NSStringFromCGRect(_menu.boundingBox));
    
    if (CGRectContainsPoint(_menu.boundingBox, pos)) {
        return  YES;
    }
    
    return NO;

}
- (void) onEnter
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kPriorityAddTower swallowsTouches:YES];
    [super onEnter];
}

- (void)onExit
{
    //取消触摸协议
    [[[CCDirector sharedDirector] touchDispatcher]removeDelegate:self];
    [super onExit];
}
@end
