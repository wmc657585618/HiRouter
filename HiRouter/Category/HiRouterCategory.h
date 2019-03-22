//
//  HiRouterCategory.h
//  RouterDemo
//
//  Created by four on 2018/12/20.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRouter.h"
#import "HiRouterProtocol.h"

/******************** page ********************/
@interface HiRouter (Page)

- (HiRouterBuilder *) build:(NSString *)path;

- (HiRouterBuilder *) build:(NSString *)path action:(HiRouterTransitioningAction)action;

- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController action:(HiRouterTransitioningAction)action;

- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController withParameters:(id)parameters action:(HiRouterTransitioningAction)action;

- (BOOL) routerCallBackFromViewController:(UIViewController<HiRouterPageProtocol> *)viewController callBackParameters:(id)callBackParameters;

@end

/******************** view model ********************/
@interface HiRouter (VM)

/**
 build view and model in dynamic
 */
- (void) buildViewModelInDynamic:(NSObject<HiRouterViewModel> *)objectA objectB:(NSObject<HiRouterViewModel> *)objectB;

- (BOOL) invork:(NSObject<HiRouterViewModel> *)invork postData:(id)data;

@end

/******************** Network ********************/
@interface HiRouter (Network)

// maybe nil
- (id<HiNetworkFilterProtocol>)performURL:(NSString *)url parameters:(id)parameters;

@end

/******************** ViewController ********************/
@interface HiRouter (ViewController)

/**
 pop to last viewController for path
 get parameters if viewController responds recivedParameters:
 @return nil or code:0 is no error.
 */
- (NSError *)popToPath:(NSString *)path parameters:(id)parameters animated:(BOOL)animated;

/**
 remove viewController
 get parameters if viewController responds recivedParameters:
 @return nil or code:0 is no error.
 */
- (NSError *)removePath:(NSString *)path parameters:(id)parameters;

/**
 post parameters to path
 get parameters if viewController responds recivedParameters:
 @return nil or code:0 is no error.
 */
- (NSError *)postParameters:(id)parameters toPath:(NSString *)path;

/**
 top viewController

 @return last created viewController for path
 */
- (UIViewController<HiRouterPageProtocol> *)topViewControllerForPath:(NSString *)path;
@end
