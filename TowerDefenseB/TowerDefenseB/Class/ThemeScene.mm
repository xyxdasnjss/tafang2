//
//  ThemeScene.m
//  TowerDefenseB
//
//  Created by xyxd on 12-12-1.
//
//

#import "ThemeScene.h"
#import "cocos2d.h"
#import "ThemeStagesScene.h"
#import "MainScene.h"
#import "AppDelegate.h"
enum nodeTags
{
	kScrollLayer = 256,
	
};

enum mTagNode {
    kTagLeft = 1001,
    kTagRight,
};

@interface ThemeScene (ScrollLayerCreation)


- (NSArray *) scrollLayerPages;
- (CCScrollLayer *) scrollLayer;


@end



@implementation ThemeScene


+(CCScene *) scene
{

    
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ThemeScene *layer = [ThemeScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
    
    
}

- (id) init
{
    if ((self = [super init])) {
        
        [Flurry logEvent:@"ThemeScene"];
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"themescene.plist"];
        
        CCSpriteBatchNode *spritesBgNode;
        spritesBgNode = [CCSpriteBatchNode batchNodeWithFile:@"themescene.pvr.ccz"];
        [self addChild:spritesBgNode z:-10];
        
        
        CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"theme_bg.png"];
        bg.anchorPoint = CGPointMake(0, 0);
        [spritesBgNode addChild:bg];
        
        
        CCSprite *home = [CCSprite spriteWithSpriteFrameName:@"theme_home_normal.png"];
        CCSprite *home1 = [CCSprite spriteWithSpriteFrameName:@"theme_home_pressed.png"];
        CCMenuItemSprite *homeItem = [CCMenuItemSprite itemWithNormalSprite:home selectedSprite:home1 block:^(id sender) {
            [[CCDirector sharedDirector] replaceScene:[MainScene scene]];
        }];
        
        CCSprite *help = [CCSprite spriteWithSpriteFrameName:@"ss_help_normal.png"];
        CCSprite *help1 = [CCSprite spriteWithSpriteFrameName:@"ss_help_pressed.png"];
        
        CCMenuItemSprite *helpItem = [CCMenuItemSprite itemWithNormalSprite:help selectedSprite:help1 block:^(id sender) {
            
        }];
        
        CCMenu *menu = [CCMenu menuWithItems:homeItem,helpItem, nil];
        [self addChild:menu];
        

         [menu alignItemsHorizontallyWithPadding:(winSize.width - homeItem.contentSize.width*.5 - helpItem.contentSize.width*.5 ) *.5];
        
        menu.position = ccp(winSize.width*.5, winSize.height - help.contentSize.height *.5);
        
        

        
        
        
        
        CCSprite *left = [CCSprite spriteWithSpriteFrameName:@"theme_pointleft_normal.png"];
        CCSprite *left1 = [CCSprite spriteWithSpriteFrameName:@"theme_pointleft_pressed.png"];
        leftItem = [CCMenuItemSprite itemWithNormalSprite:left selectedSprite:left1 block:^(id sender) {
            [self LRClick:kTagLeft];
        }];
       
        CCSprite *right = [CCSprite spriteWithSpriteFrameName:@"theme_pointright_normal.png"];
        CCSprite *right1 = [CCSprite spriteWithSpriteFrameName:@"theme_pointright_pressed.png"];
        
        rightItem = [CCMenuItemSprite itemWithNormalSprite:right selectedSprite:right1 block:^(id sender) {
             [self LRClick:kTagRight];
        }];

        LR = [CCMenu menuWithItems:leftItem,rightItem, nil];
        [self addChild:LR];
        
        [LR alignItemsHorizontallyWithPadding:380];//(winSize.width - leftItem.contentSize.width - rightItem.contentSize.width - 10 ) *.5];


        LR.position = ccp(winSize.width*.5, (winSize.height - help.contentSize.height *.5)*.5);
        

       		// Do initial positioning & create scrollLayer.
		[self updateForScreenReshape];
        
        

        
    }
    
    return self;
    
}




// Positions children of CCScrollLayerTestLayer.
// ScrollLayer is updated via deleting old and creating new one.
// (Cause it's created with pages - normal CCLayer, which contentSize = winSize)
- (void) updateForScreenReshape
{

	
	// ReCreate Scroll Layer for each Screen Reshape (slow, but easy).
	CCScrollLayer *scrollLayer = (CCScrollLayer *)[self getChildByTag:kScrollLayer];
	if (scrollLayer)
	{
		[self removeChild:scrollLayer cleanup:YES];
	}
	
	scrollLayer = [self scrollLayer];
	[self addChild: scrollLayer z: 0 tag: kScrollLayer];
    _currentPage = 1;
	[scrollLayer selectPage: _currentPage];
	scrollLayer.delegate = self;
}

#pragma mark ScrollLayer Creation

// Returns array of CCLayers - pages for ScrollLayer.
- (NSArray *) scrollLayerPages
{
	CGSize screenSize = [CCDirector sharedDirector].winSize;
	
    
    NSMutableArray *layers = [[NSMutableArray alloc]init];
	// PAGE 1 - Simple Label in the center.
    
    
    //i<=5
    for (int i = 0; i <= 3; i++) {
        CCLayer *page = [CCLayer node];
        CCSprite *theme;
        if (i == 0) {
            theme = [CCSprite spriteWithSpriteFrameName:@"giftthisapp.png"];
        }else{
            theme = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"theme_pack%02d.png",i ]];
        }
       
        CCMenuItemSprite *item1 = [CCMenuItemSprite itemWithNormalSprite:theme selectedSprite:nil block:^(id sender) {
            
            [AppController sharedAppDelegate].typeTheme = i;
            [[CCDirector sharedDirector] replaceScene:[ThemeStagesScene sceneWithType:i]];
            DLog(@"ddddd,%d",i);
        }];
        
       
        
        CCMenu *mTheme1 = [CCMenu menuWithItems:item1, nil];
        mTheme1.position = ccp(screenSize.width/2, screenSize.height/2);
        [page addChild:mTheme1];
        
        [layers addObject:page];

    }
	
	return layers;
}

// Creates new Scroll Layer with pages returned from scrollLayerPages.
- (CCScrollLayer *) scrollLayer
{
	CGSize screenSize = [CCDirector sharedDirector].winSize;
	
	// Create the scroller and pass-in the pages (set widthOffset to 0 for fullscreen pages).
	CCScrollLayer *scroller = [CCScrollLayer nodeWithLayers: [self scrollLayerPages] widthOffset: 0 ];//0.48f * screenSize.width
	scroller.pagesIndicatorPosition = ccp(screenSize.width * 0.5f, 15.0f);
    
    // New feature: margin offset - to slowdown scrollLayer when scrolling out of it contents.
    // Comment this line or change marginOffset to screenSize.width to disable this effect.
    scroller.marginOffset = screenSize.width;
	
	return scroller;
}

- (void) LRClick: (int) tag
{
	CCScrollLayer *scroller = (CCScrollLayer *)[self getChildByTag:kScrollLayer];
	if (tag == kTagLeft && _currentPage > 0) {
        _currentPage --;
        
    }else if (tag == kTagRight && _currentPage < 5){
        _currentPage ++;
    }else {
        return;
    }
    
    

    
     [scroller moveToPage:_currentPage];
    
	
}


#pragma mark Scroll Layer Callbacks

- (void) scrollLayerScrollingStarted:(CCScrollLayer *) sender
{
	NSLog(@"CCScrollLayerTestLayer#scrollLayerScrollingStarted: %@", sender);
}

- (void) scrollLayer: (CCScrollLayer *) sender scrolledToPageNumber: (int) page
{
   
    _currentPage = page;
	NSLog(@"CCScrollLayerTestLayer#scrollLayer:scrolledToPageNumber: %@ %d", sender, page);
}


@end
