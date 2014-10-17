//
//  ThemeStagesScene.h
//  TowerDefenseB
//
//  Created by xyxd on 12-12-3.
//
//

#import "CCScene.h"
#import "CCLayer.h"
#import "CCScrollLayer.h"

@interface ThemeStagesScene : CCLayer
<CCScrollLayerDelegate>
{
   
    int _typeTheme;
    int _currentPage;
}

@property (assign, nonatomic) int typeTheme;

+(CCScene *) scene;
+(CCScene *) sceneWithType:(int)type;
@end
