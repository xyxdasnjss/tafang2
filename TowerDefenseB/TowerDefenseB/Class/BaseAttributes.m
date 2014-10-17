//
//  BaseAttributes.m
//  TowerDefenseB
//
//  Created by xyxd on 12-12-12.
//  Copyright (c) 2012年 Beijing XYXD Technology Co., LTD. All rights reserved.
//

#import "BaseAttributes.h"

@implementation BaseAttributes

@synthesize baseHealth = _baseHealth;
@synthesize baseMoney = _baseMoney;


static BaseAttributes *_sharedAttributes = nil;

+ (BaseAttributes *)sharedAttributes
{
	@synchronized([BaseAttributes class])
	{
		if (!_sharedAttributes)
			_sharedAttributes = [[self alloc] init];
		return _sharedAttributes;
	}
	// to avoid compiler warning
	return nil;
}


+ (id) alloc
{
	@synchronized([BaseAttributes class])
	{
		NSAssert(_sharedAttributes == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedAttributes = [super alloc];
		return _sharedAttributes;
	}
	// to avoid compiler warning
	return nil;
}


- (id) init
{
    if ((self=[super init])) {
        
		_baseHealth = 10;
        _baseMoney = 300;
                
              
    }
    
    
    return self;
}

+ (void) reset
{
    _sharedAttributes = nil;
    
    //speed 1x
     [[[CCDirector sharedDirector] scheduler] setTimeScale:1];
}
@end

