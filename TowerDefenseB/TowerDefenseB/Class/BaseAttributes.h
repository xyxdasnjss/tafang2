//
//  BaseAttributes.h
//  TowerDefenseB
//
//  Created by xyxd on 12-12-12.
//  Copyright (c) 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseAttributes : NSObject
{
    //GUI & Money attributes
    int _baseHealth;//10滴血
    int _baseMoney;
    
}

@property (nonatomic, assign) int baseHealth;
@property (nonatomic, assign) int baseMoney;


+ (BaseAttributes *)sharedAttributes;
+ (void) reset;
@end
