//
//  MainScene.m
//  TowerDefenseB
//
//  Created by xyxd mac on 12-11-22.
//
//

#import "MainScene.h"
#import "GameScene.h"
#import "ThemeScene.h"
#import "SimpleAudioEngine.h"

@interface MainScene ()
{
    CGSize winSize;
}

@end

@implementation MainScene


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainScene *layer = [MainScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


- (id) init
{
    if ((self = [super init])) {
        
        [Flurry logEvent:@"MainScene"];
        
        winSize = [CCDirector sharedDirector].winSize;
        
        
        // Start up the background music
		[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"BGMusic.mp3"];
        
        
        CCSpriteBatchNode *spritesBgNode;
        spritesBgNode = [CCSpriteBatchNode batchNodeWithFile:@"mainscene1.pvr.ccz"];
        [self addChild:spritesBgNode z:-10];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"mainscene1.plist"];
        
        
        CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"mainbg.png"];
        CGPoint spriteOffset = ccp(winSize.width*.5, winSize.height*.5);
        bg.position = spriteOffset;
        [spritesBgNode addChild:bg];
        
        
        CCSprite *corner = [CCSprite spriteWithSpriteFrameName:@"btn_bg.png"];//右上角的图片
        corner.position = ccp(winSize.width-corner.contentSize.width*.5+5, winSize.height-corner.contentSize.height*.5+5);
        [spritesBgNode addChild:corner z:-8];
        
        
        
        
        
        //btn冒险模式
        CCSprite *adventure_normal = [CCSprite spriteWithSpriteFrameName:@"btn_adventure_normal_CN.png"];
        CCSprite *adventure_pressed = [CCSprite spriteWithSpriteFrameName:@"btn_adventure_pressed_CN.png"];
        
        
        //btn Boss模式
        CCSprite *bose_locked = [CCSprite spriteWithSpriteFrameName:@"btn_bose_locked_CN.png"];
        CCSprite *bose_pressed = [CCSprite spriteWithSpriteFrameName:@"btn_bose_pressed_CN.png"];
        
        
        CCMenuItemSprite *test = [CCMenuItemSprite itemWithNormalSprite:adventure_normal
                                                         selectedSprite:adventure_pressed
                                                                  block:^(id sender)
                                  {
                                      
                                      
                                      // Play a sound!
                                      [[SimpleAudioEngine sharedEngine] playEffect:@"Select.caf"];
                                      
                                      [[CCDirector sharedDirector] replaceScene:[ThemeScene scene]];
                                      
                                  }];
        CCMenuItemSprite *test1 = [CCMenuItemSprite itemWithNormalSprite:bose_locked
                                                          selectedSprite:bose_pressed
                                                                   block:^(id sender)
                                   {
                                       // Play a sound!
                                       [[SimpleAudioEngine sharedEngine] playEffect:@"Select.caf"];
                                   }];
        
        
        CCMenu *menu =  [CCMenu menuWithItems:test,test1, nil];
        
        [menu alignItemsHorizontally];
        
        
        [menu setPosition:ccp( winSize.width/2, bose_locked.contentSize.height*.5 +10)];
        
        
        [self addChild: menu z:10];
        
        
        
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_Default];
        
        
        
        
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"mainscene2.plist"];
        CCSpriteBatchNode *batchNode = [CCSpriteBatchNode batchNodeWithFile:@"mainscene2.pvr.ccz"];
        
		
        CCSprite *animating = [CCSprite spriteWithSpriteFrameName:@"carrotshow-1.png"];
        [animating setPosition:ccp(winSize.width*.5, (winSize.height-animating.contentSize.height*.5) )];
        [batchNode addChild:animating];
        [self addChild:batchNode];
        
        
        CCAnimation *anim = [CCAnimation animation];
        for(int i = 1; i < 35; ++i) {
            
            [anim addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"carrotshow-%d.png",i]]];
            
            
        }
        anim.restoreOriginalFrame = YES;
        anim.delayPerUnit = .05;
        
        
        
        id animAction = [CCAnimate actionWithAnimation:anim];
        
        id repeatAnimation = [CCRepeatForever actionWithAction:animAction];
        
        [animating runAction:repeatAnimation];
        
        
        
        
        
        
        
        //云彩
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"mainscene3.plist"];
        CCSpriteBatchNode *cloud = [CCSpriteBatchNode batchNodeWithFile:@"mainscene3.pvr.ccz"];
        
        [self addChild:cloud z:-9];
        
        CCSprite *cloud1 = [CCSprite spriteWithSpriteFrameName:@"cloud1.png"];
        cloud1.position = ccp(cloud1.contentSize.width*.5, winSize.height- cloud1.contentSize.height*.5);
        [cloud addChild:cloud1 ];
        
        
        id actionMove = [CCMoveTo actionWithDuration:25.5 position:ccp(winSize.width+cloud1.contentSize.width*.5, cloud1.position.y)];
        
        id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(cloudFinished:)];
        
        [cloud1 runAction:[CCSequence actions:actionMove,actionMoveDone, nil]];
        
        
        
        CCSprite *cloud2 = [CCSprite spriteWithSpriteFrameName:@"cloud2.png"];
        cloud2.position = ccp(cloud2.contentSize.width*.5, winSize.height- cloud2.contentSize.height*.5);
        [cloud addChild:cloud2 ];
        
        
        id actionMove2 = [CCMoveTo actionWithDuration:50.5 position:ccp(winSize.width+cloud2.contentSize.width*.5, cloud2.position.y)];
        
        id actionMoveDone2 = [CCCallFuncN actionWithTarget:self selector:@selector(cloudFinished:)];
        
        [cloud2 runAction:[CCSequence actions:actionMove2,actionMoveDone2, nil]];
        
        
        
        
        
        //视差视图
        // 从背景到前景,依次为每一个parallax层加载精灵
        CCSprite* para1 = [CCSprite spriteWithSpriteFrameName:@"cloud2.png"];
        CCSprite* para2 = [CCSprite spriteWithSpriteFrameName:@"cloud2.png"];
        CCSprite* para3 = [CCSprite spriteWithSpriteFrameName:@"cloud1.png"];
        CCSprite* para4 = [CCSprite spriteWithSpriteFrameName:@"cloud1.png"];
        //根据屏幕和图片大小来设置正确的偏移
        para1.anchorPoint = CGPointMake(0, 1);
        para2.anchorPoint = CGPointMake(0, 1);
        para3.anchorPoint = CGPointMake(0, 0.6f);
        para4.anchorPoint = CGPointMake(0, 0);
        CGPoint topOffset = CGPointMake(0, winSize.height-para1.contentSize.height);
        //        CGPoint midOffset = CGPointMake(0, winSize.height*.5);
        //        CGPoint downOffset = CGPointZero;
        // 生成一个parallax节点用于储存各种精灵
        CCParallaxNode* paraNode = [CCParallaxNode node];
        [paraNode addChild:para1 z:1 parallaxRatio:CGPointMake(0.5f, 0) positionOffset:topOffset];
        [paraNode addChild:para2 z:2 parallaxRatio:CGPointMake(1, 0) positionOffset:topOffset];
        [paraNode addChild:para3 z:4 parallaxRatio:CGPointMake(2, 0) positionOffset:topOffset];
        [paraNode addChild:para4 z:3 parallaxRatio:CGPointMake(3, 0) positionOffset:topOffset];
        [self addChild:paraNode z:0];
        // 移动parallax节点以展示“视差”效果
        //        CCMoveBy* move1 = [CCMoveBy actionWithDuration:5 position:CGPointMake(-160, 0)];
        //        CCMoveBy* move2 = [CCMoveBy actionWithDuration:15 position:CGPointMake(160, 0)];
        //        CCSequence* sequence = [CCSequence actions:move1, move2, nil];
        
        id actionMove3 = [CCMoveTo actionWithDuration:50.5 position:ccp(winSize.width+para1.contentSize.width*.5, para1.position.y)];
        id actionMoveDone3 = [CCCallFuncN actionWithTarget:self selector:@selector(cloud1Finished:)];
        CCSequence * sequence = [CCSequence actions:actionMove3,actionMoveDone3, nil];
        CCRepeatForever* repeat = [CCRepeatForever actionWithAction:sequence];
        [paraNode runAction:repeat];
        
    }
    
    return self;
    
}


- (void) cloudFinished:(id)sender
{
    CCSprite *cloud1 = (CCSprite*)sender;
    
    
    cloud1.position = ccp(cloud1.contentSize.width*.5, winSize.height- cloud1.contentSize.height*.5);
    
    id actionMove = [CCMoveTo actionWithDuration:25.5 position:ccp(winSize.width+cloud1.contentSize.width*.5, cloud1.position.y)];
    
    id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(cloudFinished:)];
    
    [cloud1 runAction:[CCSequence actions:actionMove,actionMoveDone, nil]];
    
}

- (void) cloud1Finished:(id)sender
{
    CCParallaxNode* paraNode = (CCParallaxNode*)sender;
    id actionMove3 = [CCMoveTo actionWithDuration:50.5 position:ccp(winSize.width+paraNode.contentSize.width*.5, paraNode.position.y)];
    id actionMoveDone3 = [CCCallFuncN actionWithTarget:self selector:@selector(cloud1Finished:)];
    CCSequence * sequence = [CCSequence actions:actionMove3,actionMoveDone3, nil];
    CCRepeatForever* repeat = [CCRepeatForever actionWithAction:sequence];
    [paraNode runAction:repeat];
    
    
    
}




@end



