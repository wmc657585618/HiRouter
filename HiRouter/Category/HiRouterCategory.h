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

- (HiRouterBuilder *) build:(NSString *)path action:(HiRouterNavigationAction)action;

- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController action:(HiRouterNavigationAction)action;

- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController withParameters:(id)parameters action:(HiRouterNavigationAction)action;

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
