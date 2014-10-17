//
//  GameOverLayer.h
//  TowerDefenseB
//
//  Created by xyxd on 12-12-11.
//  Copyright (c) 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import "CCLayer.h"

typedef enum _gameResultType{
    
    kResultTypeWin = 1,
    kResultTypeLose,
    
}gameResultType;

@interface GameOverLayer : CCLayer
<CCTargetedTouchDelegate>
{
    CCSprite *_bg;
    CCLabelTTF *_title;
    CCMenu *_menu;
}

@property (nonatomic, retain) CCSprite *bg;
@property (nonatomic, retain) CCLabelTTF *title;
@property (nonatomic, retain) CCMenu *menu;

- (id) initWithResultType:(gameResultType)type;
@end
