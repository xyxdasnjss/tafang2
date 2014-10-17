//
//  CCAnimation+Helper.m
//  TowerDefenseB
//
//  Created by xyxd mac on 12-12-18.
//  Copyright (c) 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import "CCAnimation+Helper.h"

@implementation CCAnimation (Helper)

// 使用单个文件生成动画
+(CCAnimation*) animationWithFile:(NSString*)name
                       frameCount:(int)frameCount
                            delay:(float)delay
                            begin:(int)begin
{
    // 把动画帧作为贴图进行加载,然后生成精灵动画帧
    NSMutableArray* frames = [NSMutableArray arrayWithCapacity:frameCount];
    for (int i = begin; i < frameCount; i++)
    {
        // 假设所有动画帧文件的名字是”nameX.png”
        NSString* file = [NSString stringWithFormat:@"%@%02d.png", name, i];
        
        [frames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:file]];
    }
    // 使用所有的精灵动画帧,返回一个动画对象
    return [CCAnimation animationWithSpriteFrames:frames delay:delay];
}


@end
