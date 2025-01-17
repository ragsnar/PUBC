//
//  PUBGControllerManager.h
//  pubc
//
//  Created by Kevin Bradley on 6/15/19.
//  Copyright © 2019 nito. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PUBGDefines.h"
#import <GameController/GameController.h>
#import "RKDropdownAlert/RKDropdownAlert.h"


@interface PUBGControllerManager : NSObject <RKDropdownAlertDelegate>

@property (nonatomic, strong) GCController *gameController;
@property (nonatomic, strong) NSArray <GCController*> *gameControllers;
@property (nonatomic, strong) NSDictionary *gamePlayDictionary;

- (void)resetToDefaults;
- (float)panningSpeed ;
- (float)aimPanningSpeed ;
- (BOOL)invertedControl ;
- (void)appWasActivated;
- (UIViewController *)topViewController;
- (UIView *)IOSView;
- (CGPoint)convertPointForScreen:(CGPoint)inputPoint;
- (CGPoint)pointForActionType:(PGBActionType)type;
- (NSDictionary *)controllerPreferences;
- (NSDictionary *)drivingControls;
- (PGBActionType)actionTypeFromConstant:(NSString *)constant;
- (PGBActionType)actionTypeForControllerButton:(NSString *)constantString;
+ (id)sharedManager;
- (void)listenForControllers;
- (void)updateDrivingVaLue:(id)value forKey:(NSString *)theKey;
- (void)updateGamplayValue:(id)value forKey:(NSString *)theKey;
@end


