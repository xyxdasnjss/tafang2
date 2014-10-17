//
//  LoadingScene.h
//  TowerDefenseB
//
//  Created by xyxd mac on 12-12-17.
//  Copyright (c) 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import "CCScene.h"
//#import "cocos2d.h"

typedef enum
{
    TargetSceneINVALID = 0,
    TargetSceneGameScene,
    TargetSceneThemeStages,
    TargetSceneMAX,
} TargetScenes;
// LoadingScene直接继承自CCScene,在这个场景中我们不需要CCLayer
@interface LoadingScene : CCScene
{
    TargetScenes targetScene_;
}
+(id) sceneWithTargetScene: (TargetScenes) targetScene;
-(id) initWithTargetScene: (TargetScenes) targetScene;

@end
