//
//  ThemeStagesScene.m
//  TowerDefenseB
//
//  Created by xyxd on 12-12-3.
//
//

#import "ThemeStagesScene.h"
#import "cocos2d.h"
#import "GameScene.h"
#import "ThemeScene.h"
#import "AppDelegate.h"
#import "LoadingScene.h"

enum nodeTags
{
	kScrollLayer = 256,
	
};

@interface ThemeStagesScene (ScrollLayerCreation)


- (NSArray *) scrollLayerPages;
- (CCScrollLayer *) scrollLayer;


@end
@implementation ThemeStagesScene

@synthesize typeTheme = _typeTheme;
+(CCScene *) scene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ThemeStagesScene *layer = [ThemeStagesScene node];

	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

+(CCScene *) sceneWithType:(int)type
{
	
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ThemeStagesScene *layer = [ThemeStagesScene node];
    layer.typeTheme = type;
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;

}


- (id) init
{
    if ((self = [super init])) {
        
        [Flurry logEvent:@"ThemeStagesScene"];

        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"themescene.plist"];
        
        CCSpriteBatchNode *spritesBgNode;
        spritesBgNode = [CCSpriteBatchNode batchNodeWithFile:@"themescene.pvr.ccz"];
        [self addChild:spritesBgNode z:-10];

        
        CCSprite *bg = [CCSprite spriteWithSpriteFrameName:@"theme_bg.png"];
        bg.anchorPoint = CGPointMake(0, 0);
        [spritesBgNode addChild:bg];

        
        
        
              
        
        
    }
    
    return self;
    
}

- (void) onEnter
{
    [super onEnter];
    
    switch (_typeTheme) {
        case kTypeSkyLine:
        {
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"stages_theme1.plist"];
            
            CCSpriteBatchNode *spritesBgNode;
            spritesBgNode = [CCSpriteBatchNode batchNodeWithFile:@"stages_theme1.pvr.ccz"];
            [self addChild:spritesBgNode z:-10];
            
        }break;
        case kTypeJungle:
        {
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"stages_theme2.plist"];
            
            CCSpriteBatchNode *spritesBgNode;
            spritesBgNode = [CCSpriteBatchNode batchNodeWithFile:@"stages_theme2.pvr.ccz"];
            [self addChild:spritesBgNode z:-10];
            
        }break;
        case kTypeDesert:
        {
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"stages_theme3.plist"];
            
            CCSpriteBatchNode *spritesBgNode;
            spritesBgNode = [CCSpriteBatchNode batchNodeWithFile:@"stages_theme3.pvr.ccz"];
            [self addChild:spritesBgNode z:-10];
            
        }break;
        case kTypeExtreme:
        {
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"stages_theme5.plist"];
            
            CCSpriteBatchNode *spritesBgNode;
            spritesBgNode = [CCSpriteBatchNode batchNodeWithFile:@"stages_theme5.pvr.ccz"];
            [self addChild:spritesBgNode z:-10];
            
        }break;
        case kTypeDeepSea:
        {
            //                [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"themescene.plist"];
            //
            //                CCSpriteBatchNode *spritesBgNode;
            //                spritesBgNode = [CCSpriteBatchNode batchNodeWithFile:@"themescene.pvr.ccz"];
            //                [self addChild:spritesBgNode z:-10];
            
        }break;
            
        default:
        {
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"stages_theme1.plist"];
            
            CCSpriteBatchNode *spritesBgNode;
            spritesBgNode = [CCSpriteBatchNode batchNodeWithFile:@"stages_theme1.pvr.ccz"];
            [self addChild:spritesBgNode z:-10];
        }break;
    }
    
    
    CCSprite *home = [CCSprite spriteWithSpriteFrameName:@"ss_back_normal.png"];
    CCSprite *home1 = [CCSprite spriteWithSpriteFrameName:@"ss_back_pressed.png"];
    CCMenuItemSprite *homeItem = [CCMenuItemSprite itemWithNormalSprite:home selectedSprite:home1 block:^(id sender) {
        [[CCDirector sharedDirector] replaceScene:[ThemeScene scene]];
    }];
    
    CCSprite *help = [CCSprite spriteWithSpriteFrameName:@"ss_help_normal.png"];
    CCSprite *help1 = [CCSprite spriteWithSpriteFrameName:@"ss_help_pressed.png"];
    
    CCMenuItemSprite *helpItem = [CCMenuItemSprite itemWithNormalSprite:help selectedSprite:help1 block:^(id sender) {
        
    }];
    
    CCMenu *menu = [CCMenu menuWithItems:homeItem,helpItem, nil];
    [self addChild:menu];
    CGSize winSize = [[CCDirector sharedDirector] winSize];

    
    [menu alignItemsHorizontallyWithPadding:(winSize.width - homeItem.contentSize.width*.5 - helpItem.contentSize.width*.5 ) *.5];
    
    menu.position = ccp(winSize.width*.5, winSize.height - help.contentSize.height *.5);
    
    
    
    
    
    
    
//    // Do initial positioning & create scrollLayer.
    [self updateForScreenReshape];
//


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
    _currentPage = 0;
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
    
    
    
    for (int i = 1; i <= 12; i++) {
        CCLayer *page = [CCLayer node];
        CCSprite *theme = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"ss_map%02d.png",i ]];
        
        CCMenuItemSprite *item1 = [CCMenuItemSprite itemWithNormalSprite:theme selectedSprite:nil block:^(id sender) {
            
            [AppController sharedAppDelegate].typeTheme = _typeTheme;
            [AppController sharedAppDelegate].typeBg = i;
            
            [[CCDirector sharedDirector] replaceScene:[LoadingScene sceneWithTargetScene:TargetSceneGameScene]];
            
            
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
	CCScrollLayer *scroller = [CCScrollLayer nodeWithLayers: [self scrollLayerPages] widthOffset: 0.48f * screenSize.width];//
	scroller.pagesIndicatorPosition = ccp(screenSize.width * 0.5f, 15.0f);
    
    // New feature: margin offset - to slowdown scrollLayer when scrolling out of it contents.
    // Comment this line or change marginOffset to screenSize.width to disable this effect.
    scroller.marginOffset = screenSize.width;
	
	return scroller;
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