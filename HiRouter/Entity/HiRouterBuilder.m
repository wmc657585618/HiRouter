//
//  RouterBuilder.m
//  Router
//
//  Created by Four on 2018/7/10.
//  Copyright © 2018年 Four. All rights reserved.
//

#import "HiRouterBuilder.h"

@implementation HiRouterBuilder

- (void)buildAnimated:(BOOL)animated completion:(void(^)(void))completion {
    
    switch (self.transitioningAction) {
        case HiRouterTransitioningActionPush:
            [self.sourceViewController.navigationController pushViewController:self.targetViewController animated:animated];
            break;
        case HiRouterTransitioningActionPresent:
            [self.sourceViewController presentViewController:self.targetViewController animated:animated completion:completion];
            break;
        case HiRouterTransitioningActionNone:
            
            break;
    }
}
@end
