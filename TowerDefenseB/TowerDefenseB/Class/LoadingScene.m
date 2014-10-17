//
//  LoadingScene.m
//  TowerDefenseB
//
//  Created by xyxd mac on 12-12-17.
//  Copyright (c) 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import "LoadingScene.h"
#import "GameScene.h"
#import "AppDelegate.h"
#import "ThemeStagesScene.h"

@implementation LoadingScene




+(id) sceneWithTargetScene:(TargetScenes)targetScene
{
    // 以下代码生成了一个当前类的自动释放对象 (self == LoadingScene)
    return [[self alloc] initWithTargetScene:targetScene];
}

-(id) initWithTargetScene:(TargetScenes)targetScene
{
    {
        if ((self = [super init]))
        {
            
            
//            [[CCDirector sharedDirector] resume];
//            [[CCDirector sharedDirector] startAnimation];
            

            
            targetScene_ = targetScene;
            
            
            
            CCLabelTTF* label = [CCLabelTTF labelWithString:@"Loading ..."
                                             fontName:@"Marker Felt" fontSize:64];
            CGSize size = [[CCDirector sharedDirector] winSize];
            label.position = CGPointMake(size.width / 2, size.height / 2);
            [self addChild:label];
            
            
            // 必须在下一帧才加载目标场景!
            [self scheduleUpdate];
        }
            
    }
    return self;
}

-(void) update:(ccTime)delta
{
    [self unscheduleAllSelectors];
    
    
    // 通过TargetScenes这个枚举类型来决定加载哪个场景
    switch (targetScene_)
    {
    case TargetSceneGameScene:
        {
            int _typeTheme = [AppController sharedAppDelegate].typeTheme;
            int i = [AppController sharedAppDelegate].typeBg;
            
            [[CCDirector sharedDirector] replaceScene:[GameScene sceneWithTheme:_typeTheme withBg:i]];
            

        }break;
    case TargetSceneThemeStages:
        {
            int typeTheme = [AppController sharedAppDelegate].typeTheme;
            [[CCDirector sharedDirector] replaceScene:[ThemeStagesScene sceneWithType:typeTheme]];
        }break;
    default:
        // 如果使用了没有指定的枚举类型,发出警告信息
        NSAssert2(nil, @"%@: unsupported TargetScene %i",NSStringFromSelector(_cmd), targetScene_);
        break;
        
    }
}


@end
