//
//  AppDelegate.mm
//  TowerDefenseB
//
//  Created by xyxd mac on 12-11-22.
//  Copyright __MyCompanyName__ 2012年. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"
#import "IntroLayer.h"
#import "UncaughtExceptionHandler.h"
#import <Parse/Parse.h>
#import "DeviceInfo.h"



@implementation AppController

@synthesize window=window_, navController=navController_, director=director_;
@synthesize typeTheme = _typeTheme;
@synthesize typeBg = _typeBg;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    [Flurry setAppVersion:version];
    [Flurry startSession:kFlurryAppKey];
    
    [Parse setApplicationId:kParseApplicationId
                  clientKey:kParseClientKey];
    
    
    [application registerForRemoteNotificationTypes:
       UIRemoteNotificationTypeBadge
     | UIRemoteNotificationTypeAlert
     | UIRemoteNotificationTypeSound];
    
       
//    InstallUncaughtExceptionHandler();
    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);

    [self readPlist];
    

	// Create the main window
	window_ = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	
	// Create an CCGLView with a RGB565 color buffer, and a depth buffer of 0-bits
	CCGLView *glView = [CCGLView viewWithFrame:[window_ bounds]
								   pixelFormat:kEAGLColorFormatRGB565	//kEAGLColorFormatRGBA8
								   depthFormat:0	//GL_DEPTH_COMPONENT24_OES
							preserveBackbuffer:NO
									sharegroup:nil
								 multiSampling:NO
							   numberOfSamples:0];

	// Enable multiple touches
	[glView setMultipleTouchEnabled:YES];

	director_ = (CCDirectorIOS*) [CCDirector sharedDirector];
	
	director_.wantsFullScreenLayout = YES;
	
	// Display FSP and SPF
	[director_ setDisplayStats:YES];
	
	// set FPS at 60
	[director_ setAnimationInterval:1.0/60];
	
	// attach the openglView to the director
	[director_ setView:glView];
	
	// for rotation and other messages
	[director_ setDelegate:self];
	
	// 2D projection
	[director_ setProjection:kCCDirectorProjection2D];
	//	[director setProjection:kCCDirectorProjection3D];
	
	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	if( ! [director_ enableRetinaDisplay:YES] )
		CCLOG(@"Retina Display Not supported");
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
	
	// If the 1st suffix is not found and if fallback is enabled then fallback suffixes are going to searched. If none is found, it will try with the name without suffix.
	// On iPad HD  : "-ipadhd", "-ipad",  "-hd"
	// On iPad     : "-ipad", "-hd"
	// On iPhone HD: "-hd"
	CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
	[sharedFileUtils setEnableFallbackSuffixes:NO];				// Default: NO. No fallback suffixes are going to be used
	[sharedFileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];		// Default on iPhone RetinaDisplay is "-hd"
	[sharedFileUtils setiPadSuffix:@"-ipad"];					// Default on iPad is "ipad"
	[sharedFileUtils setiPadRetinaDisplaySuffix:@"-ipadhd"];	// Default on iPad RetinaDisplay is "-ipadhd"
	
	// Assume that PVR images have premultiplied alpha
	[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
	
	// and add the scene to the stack. The director will run it when it automatically when the view is displayed.
	[director_ pushScene: [IntroLayer scene]]; 
	
	
	// Create a Navigation Controller with the Director
	navController_ = [[UINavigationController alloc] initWithRootViewController:director_];
	navController_.navigationBarHidden = YES;
	
	// set the Navigation Controller as the root view controller
//	[window_ addSubview:navController_.view];	// Generates flicker.
	[window_ setRootViewController:navController_];
	
	// make main window visible
	[window_ makeKeyAndVisible];
	
	return YES;
}

// Supported orientations: Landscape. Customize it for your own needs
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


// getting a call, pause the game
-(void) applicationWillResignActive:(UIApplication *)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ pause];
}

// call got rejected
-(void) applicationDidBecomeActive:(UIApplication *)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ resume];
}

-(void) applicationDidEnterBackground:(UIApplication*)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ startAnimation];
}

// application will be killed
- (void)applicationWillTerminate:(UIApplication *)application
{
	CC_DIRECTOR_END();
}

// purge memory
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	[[CCDirector sharedDirector] purgeCachedData];
}

// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Tell Parse about the device token.
    [PFPush storeDeviceToken:deviceToken];
    // Subscribe to the global broadcast channel.
    //    [PFPush subscribeToChannelInBackground:@""];
    [PFPush subscribeToChannelInBackground:kPushChannel];

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [PFPush handlePush:userInfo];
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    if ([error code] == 3010) {
        NSLog(@"Push notifications don't work in the simulator!");
    } else {
        NSLog(@"didFailToRegisterForRemoteNotificationsWithError: %@", error);
    }
}




+ (AppController *)sharedAppDelegate
{
    return (AppController *) [UIApplication sharedApplication].delegate;
}

//寫入
- (void)writePlist :(NSMutableDictionary *)dic
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
       
    //plist命名
    NSString *filePath = [documentsDirectory stringByAppendingString:@"/excption.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableDictionary *plistDict;
    
    //檢查檔案是否存在，return false則創建
    if ([fileManager fileExistsAtPath: filePath])
    {
        plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    }else{
        plistDict = [[NSMutableDictionary alloc] init];
    }
    
        [plistDict addEntriesFromDictionary:dic];
    
        //把剛追加之參數寫入file
        if ([plistDict writeToFile:filePath atomically: YES]) {
          
            NSLog(@"writePlist success");
        } else {
            NSLog(@"writePlist fail");
        }
  
   
}

//讀取
- (void)readPlist
{
   
    
    //取得檔案路徑
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingString:@"/excption.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableDictionary *plistDict;
    //檢查檔案是否存在
    if ([fileManager fileExistsAtPath: filePath])
    {
        NSLog(@"File here.");
        //存在的話把plist中的資料取出並寫入動態字典plistDict
        plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        
        
        BOOL isException = [[plistDict objectForKey:@"Exception"] boolValue];
        if (isException == YES) {
            DLog(@"%@",[plistDict description]);
            
            NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
            [plistDict setObject:version forKey:@"SoftVersion"];
            [plistDict setObject:kPushChannel forKey:@"channel"];
            [plistDict setObject:[DeviceInfo deviceString] forKey:@"deviceInfo"];
            [plistDict setObject:[DeviceInfo getOSVersion] forKey:@"OSVersion"];

            
            PFObject *exception = [PFObject objectWithClassName:@"Exception" dictionary:plistDict];
            [exception saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    [plistDict setObject:[NSNumber numberWithBool:NO] forKey:@"Exception"];
                    //把剛追加之參數寫入file
                    if ([plistDict writeToFile:filePath atomically: YES]) {
                        
                        NSLog(@"writePlist success");
                    } else {
                        NSLog(@"writePlist fail");
                    }
                }
            }];
            
            
            
            
        }
        
    }else{
        NSLog(@"File not here.");
//        plistDict = [[NSMutableDictionary alloc] init];
    }
    
   
    
      
}

// Via http://stackoverflow.com/questions/7841610/xcode-4-2-debug-doesnt-symbolicate-stack-call

void uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
    
    NSMutableDictionary *temDic = [[NSMutableDictionary alloc]init];
    
    [temDic setObject:[NSNumber numberWithBool:YES] forKey:@"Exception"];
    [temDic setObject:[NSString stringWithFormat:@"CRASH: %@",exception] forKey:@"Exception1"];
    [temDic setObject:[NSString stringWithFormat:@"Stack Trace: %@", [exception callStackSymbols]] forKey:@"Exception2"];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //plist命名
    NSString *filePath = [documentsDirectory stringByAppendingString:@"/excption.plist"];
    
    DLog(@"%@",filePath);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableDictionary *plistDict;
    
    //檢查檔案是否存在，return false則創建
    if ([fileManager fileExistsAtPath: filePath])
    {
        plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    }else{
        plistDict = [[NSMutableDictionary alloc] init];
    }
    
    [plistDict addEntriesFromDictionary:temDic];
    
    //把剛追加之參數寫入file
    if ([plistDict writeToFile:filePath atomically: YES]) {
        
        NSLog(@"writePlist success");
    } else {
        NSLog(@"writePlist fail");
    }

    
    // Internal error reporting
}


@end

