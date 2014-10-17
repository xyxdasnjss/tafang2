//
//  GameMenuLayer.m
//  TowerDefenseB
//
//  Created by xyxd mac on 12-12-7.
//  Copyright (c) 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import "GameMenuLayer.h"
#import "MenuPauseLayer.h"
#import "BaseAttributes.h"
@interface GameMenuLayer ()
{
    CGSize winSize;
}

@end

@implementation GameMenuLayer

@synthesize menu = _menu;
@synthesize moneyLabel = _moneyLabel;
@synthesize menuBg = _menuBg;
@synthesize waveCountLabel = _waveCountLabel;
@synthesize waveTotalCountLabel = _waveTotalCountLabel;
@synthesize waveCount = _waveCount;
@synthesize waveStatus = _waveStatus;
- (id) init
{
    if ((self = [super init])) {
        
        winSize = [[CCDirector sharedDirector] winSize];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Items02.plist"];
        CCSpriteBatchNode *items = [CCSpriteBatchNode batchNodeWithFile:@"Items02.pvr.ccz"];
        [self addChild:items z:kZMenuBg];
        
        _menuBg = [CCSprite spriteWithSpriteFrameName:@"MenuBG.png"];
        _menuBg.position = ccp(winSize.width * .5, winSize.height - _menuBg.contentSize.height*.5);
        [items addChild:_menuBg];
        
        
        //Wave
        _waveStatus = [CCSprite spriteWithSpriteFrameName:@"MenuCenter_01_CN.png"];
        _waveStatus.position = ccp(winSize.width*.5, winSize.height-_waveStatus.contentSize.height*.5);
        [items addChild:_waveStatus];
        
        

        _waveCount = 1;
        _waveCountLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%02d",_waveCount] fontName:@"Georgia-Bold" fontSize:25];
        _waveCountLabel.position = ccp(winSize.width*.5-_waveCountLabel.contentSize.width-15, winSize.height-_waveCountLabel.contentSize.height*.5-5);
        _waveCountLabel.color = ccc3(255,255,255);
        [self addChild:_waveCountLabel z:kZMenuChild+1];
        
        
        _waveTotalCountLabel = [CCLabelTTF labelWithString:@"12" fontName:@"Courier-BoldOblique" fontSize:20];
        _waveTotalCountLabel.position = ccp(winSize.width*.5+_waveTotalCountLabel.contentSize.width-23, winSize.height-_waveTotalCountLabel.contentSize.height*.5-5);
        [self addChild:_waveTotalCountLabel z:kZMenuChild];
        
        
//        _moneyLabel = [CCLabelAtlas labelWithString:@"300.0" charMapFile:@"fps_images.png" itemWidth:30 itemHeight:28 startCharMap:'.'];
//        _moneyLabel.position = ccp(winSize.width*.5, winSize.height*.5);
//        [self addChild:_moneyLabel z:kZMenuChild];

        BaseAttributes *baseAttributes = [BaseAttributes sharedAttributes];
        _moneyLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",baseAttributes.baseMoney] fontName:@"Marker Felt" fontSize:20];
        _moneyLabel.position = ccp(winSize.width*.15, winSize.height - _moneyLabel.contentSize.height*.5-5);
        
        [self addChild:_moneyLabel z:kZMenuChild+1];
        
        
        //menu speed
        CCSprite *speedBtn1 = [CCSprite spriteWithSpriteFrameName:@"speed11.png"];
        CCSprite *speedBtn1f = [CCSprite spriteWithSpriteFrameName:@"speed12.png"];
        
        CCMenuItemSprite *speedItem1 = [CCMenuItemSprite itemWithNormalSprite:speedBtn1
                                                              selectedSprite:speedBtn1f];
        CCSprite *speedBtn2 = [CCSprite spriteWithSpriteFrameName:@"speed21.png"];
        CCSprite *speedBtn2f = [CCSprite spriteWithSpriteFrameName:@"speed22.png"];
        
        CCMenuItemSprite *speedItem2 = [CCMenuItemSprite itemWithNormalSprite:speedBtn2
                                                              selectedSprite:speedBtn2f];
        
        CCMenuItemToggle *speedToggle =[ CCMenuItemToggle itemWithTarget:self selector:@selector(speedToggleBtn:) items:speedItem1,speedItem2, nil];
        
        
        CCSprite *pauseBtn = [CCSprite spriteWithSpriteFrameName:@"pause11.png"];
        CCSprite *pauseBtn1 = [CCSprite spriteWithSpriteFrameName:@"pause12.png"];
        CCMenuItemSprite *pauseItem = [CCMenuItemSprite itemWithNormalSprite:pauseBtn
                                                              selectedSprite:pauseBtn1
                                                                       block:^(id sender)
                                       {
                                           [[CCDirector sharedDirector] stopAnimation];
                                           
                                       }];
        
        
        CCSprite *runBtn = [CCSprite spriteWithSpriteFrameName:@"pause01.png"];
        CCSprite *runBtn1 = [CCSprite spriteWithSpriteFrameName:@"pause02.png"];
        CCMenuItemSprite *runItem = [CCMenuItemSprite itemWithNormalSprite:runBtn
                                                            selectedSprite:runBtn1
                                                                     block:^(id sender)
                                     {
                                         [[CCDirector sharedDirector] startAnimation];
                                         
                                     }];
        
        CCMenuItemToggle *pauseToggle = [ CCMenuItemToggle itemWithTarget:self selector:@selector(pauseToggleBtn:) items:runItem,pauseItem, nil];
        
        
        
        
        CCSprite *menuBtn = [CCSprite spriteWithSpriteFrameName:@"menu01.png"];
        CCSprite *menuBtn1 = [CCSprite spriteWithSpriteFrameName:@"menu02.png"];
        CCMenuItemSprite *menuItem = [CCMenuItemSprite itemWithNormalSprite:menuBtn
                                                             selectedSprite:menuBtn1
                                                                      block:^(id sender)
                                      {
                                          
                                          MenuPauseLayer *pauseLayer = [[MenuPauseLayer alloc]init];
                                          [self.parent addChild:pauseLayer z:kZHigh];
                                          
                                          
                                          
                                      }];
        
        
        
        CCMenu *menu = [CCMenu menuWithItems:speedToggle,pauseToggle,menuItem, nil];
        [menu alignItemsHorizontally];
        menu.position = ccp(winSize.width *4/5, [self glPositionHeightToPositionHeight:0.f withSprite:speedBtn1]);
        [self addChild:menu z:kZMenuChild];

        
    }
    
    return self;
}

- (void)speedToggleBtn:(CCMenuItemToggle*)sender
{
    if (sender.selectedIndex == 0) {
        DLog(@"1x speed");
        [[[CCDirector sharedDirector] scheduler] setTimeScale:1];
    }else{
        DLog(@"2x speed");
        [[[CCDirector sharedDirector] scheduler] setTimeScale:2];
    }
}

- (void)pauseToggleBtn:(CCMenuItemToggle*)sender
{
    if (sender.selectedIndex == 0) {
        DLog(@"run");
        
        
        [_waveStatus setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"MenuCenter_01_CN.png"]];
        [_waveCountLabel setVisible:YES];
        [_waveTotalCountLabel setVisible:YES];
        
        
        [[CCDirector sharedDirector] resume];
//        [[CCDirector sharedDirector] startAnimation];
    }else{
        DLog(@"pause");
        
        [_waveStatus setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"MenuCenter_02_CN.png"]];
        [_waveCountLabel setVisible:NO];
        [_waveTotalCountLabel setVisible:NO];
        
        
        [[CCDirector sharedDirector] pause];
//        [[CCDirector sharedDirector] stopAnimation];
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






- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInView: [touch view]];
    CGPoint pos =  [[CCDirector sharedDirector] convertToGL:touchLocation];
    
    
    if (CGRectContainsPoint(_menuBg.boundingBox, pos)) {
        return  YES;
    }
    
    return NO;

}



- (void) onEnter
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kPriorityGameMenuBg swallowsTouches:YES];
    [super onEnter];
}

- (void)onExit
{
    //取消触摸协议
    [[[CCDirector sharedDirector] touchDispatcher]removeDelegate:self];
    [super onExit];
}

+(CGPoint) locationFromTouch:(UITouch*)touch
{
    CGPoint touchLocation = [touch locationInView: [touch view]];
    return [[CCDirector sharedDirector] convertToGL:touchLocation];
}




-(void) updateWaveCount
{
    _waveCount++;
    [_waveCountLabel setString:[NSString stringWithFormat:@"%02d",_waveCount]];

}

-(void) newWaveApproaching
{
//    [_waveCountLabel setString:[NSString stringWithFormat: @"HERE THEY COME!"]];
}
-(void) newWaveApproachingEnd
{
//    [_waveCountLabel setString:[NSString stringWithFormat: @" "]];
}

- (void) updateMoney:(int)money
{
    BaseAttributes *baseAttributes = [BaseAttributes sharedAttributes];
    baseAttributes.baseMoney += money;
    [_moneyLabel setString:[NSString stringWithFormat:@"%d",baseAttributes.baseMoney]];
}

- (void) updateHealth
{
    BaseAttributes *baseAttributes = [BaseAttributes sharedAttributes];
    baseAttributes.baseHealth --;

}


@end
