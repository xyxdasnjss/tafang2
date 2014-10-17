//
//  CCAnimation+Helper.h
//  TowerDefenseB
//
//  Created by xyxd mac on 12-12-18.
//  Copyright (c) 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import "CCAnimation.h"

@interface CCAnimation (Helper)

+(CCAnimation*) animationWithFile:(NSString*)name
                       frameCount:(int)frameCount
                            delay:(float)delay
                            begin:(int)begin;

@end
