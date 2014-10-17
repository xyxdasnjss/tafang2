//
//  MenuPauseLayer.h
//  TowerDefenseB
//
//  Created by xyxd mac on 12-12-10.
//  Copyright (c) 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import "CCLayer.h"

@interface MenuPauseLayer : CCLayer
<CCTargetedTouchDelegate>
{
    CCSprite *_bg;
    CCMenu *_menu;
}
@property (nonatomic, retain) CCSprite *bg;
@property (nonatomic, retain) CCMenu *menu;
@end
