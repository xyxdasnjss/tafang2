//
//  ThemeScene.h
//  TowerDefenseB
//
//  Created by xyxd on 12-12-1.
//
//

#import "CCScene.h"
#import "CCLayer.h"

#import "CCScrollLayer.h"
@interface ThemeScene : CCLayer
<CCScrollLayerDelegate>
{
    int _currentPage;
    CCMenuItemSprite *leftItem;
    CCMenuItemSprite *rightItem;
    CCMenu *LR;
}

+(CCScene *) scene;

@end
