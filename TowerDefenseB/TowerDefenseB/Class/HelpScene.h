//
//  HelpScene.h
//  TowerDefenseB
//
//  Created by xyxd mac on 12-12-3.
//
//

#import "CCScene.h"
#import "CCScrollLayer.h"
@interface HelpLayer : CCLayer
<CCScrollLayerDelegate>
{
    
}

@end


@interface HelpScene : CCScene
{
    HelpLayer *_helpLayer;
}
@property (retain, nonatomic) HelpLayer *helpLayer;

+(CCScene *) scene;
@end
