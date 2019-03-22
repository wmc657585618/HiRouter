//
//  NSObjectHiCategory.m
//  RouterDemo
//
//  Created by four on 2018/12/25.
//  Copyright © 2018 Four. All rights reserved.
//

#import "NSObjectHiCategory.h"

@implementation NSObject (HiRouter)

- (void)hi_bindObject:(NSObject<HiRouterViewModel> *)object {
    
    [HiRouter.instance buildViewModelInDynamic:self objectB:object];
}

- (void)hi_postData:(id)data {
    
    [HiRouter.instance invork:self postData:data];
}

@end

@implementation NSString (HiPredicate)

-(BOOL)isValidateRegularByExpression:(NSString *)strExpression {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strExpression];
    
    return [predicate evaluateWithObject:self];
}

@end

@implementation UIViewController (HiRouter)

- (void)hi_pushPath:(NSString *)path animated:(BOOL)animated {
    
    [[HiRouter.instance build:path fromViewController:self action:HiRouterTransitioningActionPush] buildAnimated:animated completion:nil];
}

- (void)hi_pushPath:(NSString *)path withParameters:(id)parameters animated:(BOOL)animated {
    
    [[HiRouter.instance build:path fromViewController:self withParameters:parameters action:HiRouterTransitioningActionPush] buildAnimated:animated completion:nil];
}

- (void)hi_presentPath:(NSString *)path withParameters:(id)parametes animated:(BOOL)animated completion:(void(^)(void))completion{
    
    [[HiRouter.instance build:path fromViewController:self withParameters:parametes action:HiRouterTransitioningActionPresent] buildAnimated:animated completion:completion];
}

- (void)hi_presentPath:(NSString *)path animated:(BOOL)animated completion:(void(^)(void))completion{
    
    [[HiRouter.instance build:path fromViewController:self action:HiRouterTransitioningActionPresent] buildAnimated:animated completion:completion];
}

- (void)hi_callBackParameters:(id)callBackParameters {
    
    [HiRouter.instance routerCallBackFromViewController:self callBackParameters:callBackParameters];
}

- (NSError *)hi_popToPath:(NSString *)path animated:(BOOL)animated {
    return [HiRouter.instance popToPath:path parameters:nil animated:animated];
}

- (NSError *)hi_popToPath:(NSString *)path parameters:(id)parameters animated:(BOOL)animated {
    return [HiRouter.instance popToPath:path parameters:parameters animated:animated];
}

- (NSError *)hi_removePath:(NSString *)path {
    return [HiRouter.instance removePath:path parameters:nil];
}

- (NSError *)hi_removePath:(NSString *)path parameters:(id)parameters {
    return [HiRouter.instance removePath:path parameters:parameters];
}

- (NSError *)hi_postParameters:(id)parameters toPath:(NSString *)path {
    return [HiRouter.instance postParameters:parameters toPath:path];
}

- (UIViewController<HiRouterPageProtocol> *)hi_topViewControllerForPath:(NSString *)path {
    return [HiRouter.instance topViewControllerForPath:path];
}

@end
