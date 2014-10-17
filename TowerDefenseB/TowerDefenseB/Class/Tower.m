//
//  Tower.m
//  TowerDefenseB
//
//  Created by xyxd mac on 12-12-5.
//  Copyright (c) 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import "Tower.h"
#import "Monster.h"
#import "DataModel.h"
#import "Projectile.h"
#import "SimpleAudioEngine.h"

@implementation Tower
@synthesize range = _range;
@synthesize bottom = _bottom;
@synthesize target = _target;
@synthesize projectiles = _projectiles;
@synthesize nextProjectile = _nextProjectile;
@synthesize gameLayer = _gameLayer;

- (Monster *)getClosestTarget
{
	Monster *closestMonster = nil;
	double maxDistant = 99999;
    
	DataModel *m = [DataModel getModel];
    
	for (CCSprite *target in m.targets) {
		Monster *monster = (Monster *)target;
		double curDistance = ccpDistance(self.position, monster.position);
        
		if (curDistance < maxDistant) {
			closestMonster = monster;
			maxDistant = curDistance;
		}
	}
	if (maxDistant < self.range)
		return closestMonster;
	return nil;
}


- (void) towerLogic:(ccTime)dt
{
    
	self.target = [self getClosestTarget];
    
	if (self.target != nil) {
        
		// Rotate player to face shooting direction
		CGPoint shootVector = ccpSub(self.target.position, self.position);
		CGFloat shootAngle = ccpToAngle(shootVector);
		CGFloat cocosAngle = CC_RADIANS_TO_DEGREES(-1 * shootAngle) + 90;//90,是tower是竖直向上的,90°
        
		float rotateSpeed = 0.1 / M_PI; // 1/10 second to roate 180 degrees
		float rotateDuration = fabs(shootAngle * rotateSpeed);
        
		[self runAction:[CCSequence actions:
                         [CCRotateTo actionWithDuration:rotateDuration angle:cocosAngle],
                         [CCCallFunc actionWithTarget:self selector:@selector(finishMove)],
                         nil]];
	}
}



- (void)finishMove {
	
	DataModel *m = [DataModel getModel];
	
	self.nextProjectile = [BottleProjectile projectile];
	self.nextProjectile.position = self.position;
	
    [self.parent addChild:self.nextProjectile z:kZMapChild];
    [m.projectiles addObject:self.nextProjectile];
    
	ccTime delta = 1.0;
	CGPoint shootVector = ccpSub(self.target.position, self.position);
	CGPoint normalizedShootVector = ccpNormalize(shootVector);
	CGPoint overshotVector = ccpMult(normalizedShootVector, 320);
	CGPoint offscreenPoint = ccpAdd(self.position, overshotVector);
    
    [self playEffect:self.tag];
    
   	
	[self.nextProjectile runAction:[CCSequence actions:
                                    [CCMoveTo actionWithDuration:delta position:offscreenPoint],
                                    [CCCallFuncN actionWithTarget:self selector:@selector(finishFiring:)],
                                    nil]];
	
	self.nextProjectile.tag = 2;
	
    self.nextProjectile = nil;
    
}


-(void)finishFiring:(id)sender {
    
	DataModel * m = [DataModel getModel];
	
	CCSprite *sprite = (CCSprite *)sender;
	[self.parent removeChild:sprite cleanup:YES];
	
	[m.projectiles removeObject:sprite];
	
}


- (void) playEffect:(int)tag
{
    switch (tag) {
        case kTowerBottle:
        {
            
            [[SimpleAudioEngine sharedEngine] playEffect:@"Bottle.caf"];
            
        }break;
        case kTowerArrow:
        {
            
            [[SimpleAudioEngine sharedEngine] playEffect:@"Arrow.caf"];
            
        }break;
        case kTowerBall:
        {
            
            [[SimpleAudioEngine sharedEngine] playEffect:@"Ball.caf"];
            
        }break;
        case kTowerBlueStar:
        {
            
            [[SimpleAudioEngine sharedEngine] playEffect:@"Star.caf"];
            
        }break;
        case kTowerFan:
        {
            
            [[SimpleAudioEngine sharedEngine] playEffect:@"PFan.caf"];
            
        }break;
        case kTowerFireBottle:
        {
            
            [[SimpleAudioEngine sharedEngine] playEffect:@"FireBottle.caf"];
            
        }break;
        case kTowerPin:
        {
            
            [[SimpleAudioEngine sharedEngine] playEffect:@"Pin.caf"];
            
        }break;
        case kTowerPlane:
        {
            
            [[SimpleAudioEngine sharedEngine] playEffect:@"Plane.caf"];
            
        }break;
        case kTowerRocket:
        {
            
            [[SimpleAudioEngine sharedEngine] playEffect:@"Rocket.caf"];
            
        }break;
        case kTowerShit:
        {
            
            [[SimpleAudioEngine sharedEngine] playEffect:@"Shit.caf"];
            
        }break;
        case kTowerSnow:
        {
            
            [[SimpleAudioEngine sharedEngine] playEffect:@"Snow.caf"];
            
        }break;
        case kTowerStar:
        {
            
            [[SimpleAudioEngine sharedEngine] playEffect:@"Star.caf"];
            
        }break;
        case kTowerSun:
        {
            
            [[SimpleAudioEngine sharedEngine] playEffect:@"Sun.caf"];
            
        }break;
            
        default:
        {
            NSAssert(1<0, @"tower sound is error");
        }break;
            
    };

}



@end

@implementation TBottle
+ (id)tower {
    
    
    //加载Tower 根据不同的bg加载的不同
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"TBottle.plist"];
    //    CCSpriteBatchNode *towers = [CCSpriteBatchNode batchNodeWithFile:@"TBottle.pvr.ccz"];
    //    [self.parent addChild:towers z:kZMapChild];
    
    TBottle *tower = nil;
    
    if (( tower = [Tower spriteWithSpriteFrameName:@"Bottle11.png"]))
    {
        tower.range = 50;
        
        tower.bottom = [CCSprite spriteWithSpriteFrameName:@"Bottle-11.png"];
        tower.bottom.position = tower.position;
        tower.tag = kTowerBottle;
        
        if ([tower respondsToSelector:@selector(towerLogic:)])
        {
            [tower schedule:@selector(towerLogic:) interval:0.8];
        }
		
    }
    return tower;
}
@end

@implementation TShit
+ (id)tower {
    
    
    //加载Tower 根据不同的bg加载的不同
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"TShit.plist"];
    
    
    TBottle *tower = nil;
    
    if (( tower = [Tower spriteWithSpriteFrameName:@"Shit11.png"]))
    {
        tower.range = 50;
        
        tower.bottom = [CCSprite spriteWithSpriteFrameName:@"Shit-11.png"];
        tower.bottom.position = tower.position;
        tower.tag = kTowerShit;
        if ([tower respondsToSelector:@selector(towerLogic:)])
        {
            [tower schedule:@selector(towerLogic:) interval:0.8];
        }
		
    }
    return tower;
}
@end


@implementation TArrow
+ (id)tower {
    
    
    //加载Tower 根据不同的bg加载的不同
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"TArrow.plist"];
    
    
    TBottle *tower = nil;
    
    if (( tower = [Tower spriteWithSpriteFrameName:@"Arrow11.png"]))
    {
        tower.range = 80;
        
        tower.bottom = [CCSprite spriteWithSpriteFrameName:@"Arrow-11.png"];
        tower.bottom.position = tower.position;
        tower.tag = kTowerArrow;
        if ([tower respondsToSelector:@selector(towerLogic:)])
        {
            [tower schedule:@selector(towerLogic:) interval:0.8];
        }
		
    }
    return tower;
}
@end


@implementation TBall
+ (id)tower {
    
    
    //加载Tower 根据不同的bg加载的不同
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"TBall.plist"];
    
    
    TBottle *tower = nil;
    
    if (( tower = [Tower spriteWithSpriteFrameName:@"Ball11.png"]))
    {
        tower.range = 70;
        
        tower.bottom = [CCSprite spriteWithSpriteFrameName:@"Ball11.png"];
        tower.bottom.position = tower.position;
        tower.tag = kTowerBall;
        if ([tower respondsToSelector:@selector(towerLogic:)])
        {
            [tower schedule:@selector(towerLogic:) interval:0.8];
        }
		
    }
    return tower;
}
@end

@implementation TBlueStar
+ (id)tower {
    
    
    //加载Tower 根据不同的bg加载的不同
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"TBlueStar.plist"];
    
    
    TBottle *tower = nil;
    
    if (( tower = [Tower spriteWithSpriteFrameName:@"BStar11.png"]))
    {
        tower.range = 70;
        
        tower.bottom = [CCSprite spriteWithSpriteFrameName:@"BStar-11.png"];
        tower.bottom.position = tower.position;
        tower.tag = kTowerBlueStar;
        if ([tower respondsToSelector:@selector(towerLogic:)])
        {
            [tower schedule:@selector(towerLogic:) interval:0.8];
        }
		
    }
    return tower;
}
@end


@implementation TFan
+ (id)tower {
    
    
    //加载Tower 根据不同的bg加载的不同
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"TFan.plist"];
    
    
    TBottle *tower = nil;
    
    if (( tower = [Tower spriteWithSpriteFrameName:@"Fan11.png"]))
    {
        tower.range = 70;
        
        tower.bottom = [CCSprite spriteWithSpriteFrameName:@"Fan-11.png"];
        tower.bottom.position = tower.position;
        tower.tag = kTowerFan;
        if ([tower respondsToSelector:@selector(towerLogic:)])
        {
            [tower schedule:@selector(towerLogic:) interval:0.8];
        }
		
    }
    return tower;
}
@end


@implementation TFireBottle
+ (id)tower {
    
    
    //加载Tower 根据不同的bg加载的不同
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"TFireBottle.plist"];
    
    
    TBottle *tower = nil;
    
    if (( tower = [Tower spriteWithSpriteFrameName:@"FBottle11.png"]))
    {
        tower.range = 70;
        
        tower.bottom = [CCSprite spriteWithSpriteFrameName:@"FBottle-11.png"];
        tower.bottom.position = tower.position;
        tower.tag = kTowerBottle;
        if ([tower respondsToSelector:@selector(towerLogic:)])
        {
            [tower schedule:@selector(towerLogic:) interval:0.8];
        }
		
    }
    return tower;
}
@end


@implementation TPin
+ (id)tower {
    
    
    //加载Tower 根据不同的bg加载的不同
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"TPin.plist"];
    
    
    TBottle *tower = nil;
    
    if (( tower = [Tower spriteWithSpriteFrameName:@"Pin11.png"]))
    {
        tower.range = 70;
        
        tower.bottom = [CCSprite spriteWithSpriteFrameName:@"Pin-11.png"];
        tower.bottom.position = tower.position;
        tower.tag = kTowerPin;
        if ([tower respondsToSelector:@selector(towerLogic:)])
        {
            [tower schedule:@selector(towerLogic:) interval:0.8];
        }
		
    }
    return tower;
}
@end


@implementation TPlane
+ (id)tower {
    
    
    //加载Tower 根据不同的bg加载的不同
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"TPlane.plist"];
    
    
    TBottle *tower = nil;
    
    if (( tower = [Tower spriteWithSpriteFrameName:@"Plane11.png"]))
    {
        tower.range = 80;
        
        tower.bottom = [CCSprite spriteWithSpriteFrameName:@"Plane-11.png"];
        tower.bottom.position = tower.position;
        tower.tag = kTowerPlane;
        if ([tower respondsToSelector:@selector(towerLogic:)])
        {
            [tower schedule:@selector(towerLogic:) interval:0.8];
        }
		
    }
    return tower;
}
@end



@implementation TRocket
+ (id)tower {
    
    
    //加载Tower 根据不同的bg加载的不同
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"TRocket.plist"];
    
    
    TBottle *tower = nil;
    
    if (( tower = [Tower spriteWithSpriteFrameName:@"Rocket11.png"]))
    {
        tower.range = 100;
        
        tower.bottom = [CCSprite spriteWithSpriteFrameName:@"Rocket-11.png"];
        tower.bottom.position = tower.position;
        tower.tag = kTowerRocket;
        if ([tower respondsToSelector:@selector(towerLogic:)])
        {
            [tower schedule:@selector(towerLogic:) interval:0.8];
        }
		
    }
    return tower;
}
@end



@implementation TSnow
+ (id)tower {
    
    
    //加载Tower 根据不同的bg加载的不同
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"TSnow.plist"];
    
    
    TBottle *tower = nil;
    
    if (( tower = [Tower spriteWithSpriteFrameName:@"Snow11.png"]))
    {
        tower.range = 80;
        
        tower.bottom = [CCSprite spriteWithSpriteFrameName:@"Snow-11.png"];
        tower.bottom.position = tower.position;
        tower.tag = kTowerSnow;
        if ([tower respondsToSelector:@selector(towerLogic:)])
        {
            [tower schedule:@selector(towerLogic:) interval:0.8];
        }
		
    }
    return tower;
}
@end



@implementation TStar
+ (id)tower {
    
    
    //加载Tower 根据不同的bg加载的不同
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"TStar.plist"];
    
    
    TBottle *tower = nil;
    
    if (( tower = [Tower spriteWithSpriteFrameName:@"Star11.png"]))
    {
        tower.range = 60;
        
        tower.bottom = [CCSprite spriteWithSpriteFrameName:@"Star-11.png"];
        tower.bottom.position = tower.position;
        tower.tag = kTowerStar;
        if ([tower respondsToSelector:@selector(towerLogic:)])
        {
            [tower schedule:@selector(towerLogic:) interval:0.8];
        }
		
    }
    return tower;
}
@end



@implementation TSun
+ (id)tower {
    
    
    //加载Tower 根据不同的bg加载的不同
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"TSun.plist"];
    
    
    TBottle *tower = nil;
    
    if (( tower = [Tower spriteWithSpriteFrameName:@"Sun11.png"]))
    {
        tower.range = 80;
        
        tower.bottom = [CCSprite spriteWithSpriteFrameName:@"Sun-11.png"];
        tower.bottom.position = tower.position;
        tower.tag = kTowerSun;
        if ([tower respondsToSelector:@selector(towerLogic:)])
        {
            [tower schedule:@selector(towerLogic:) interval:0.8];
        }
		
    }
    return tower;
}
@end

