//
//  RouterBuilder.h
//  Router
//
//  Created by Four on 2018/7/10.
//  Copyright © 2018年 Four. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HiRouterDefine.h"

@interface HiRouterBuilder : NSObject

@property (weak, nonatomic) UIViewController *fromViewController;
@property (strong, nonatomic) UIViewController *toViewController;

@property (nonatomic,assign) HiRouterNavigationAction navigationAction;

// fromviewcontroller present or push toviewcontroller
// completion just for present
- (void)buildAnimated:(BOOL)animated completion:(void(^)(void))completion;

@end
