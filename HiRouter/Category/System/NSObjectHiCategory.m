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

@implementation UIViewController (HiRouterNavigationAction)

- (void)hi_pushPath:(NSString *)path animated:(BOOL)animated {
    
    [[HiRouter.instance build:path fromViewController:self action:HiRouterNavigationActionPush] buildAnimated:animated completion:nil];
}

- (void)hi_pushPath:(NSString *)path withParameters:(id)parameters animated:(BOOL)animated {
    
    [[HiRouter.instance build:path fromViewController:self withParameters:parameters action:HiRouterNavigationActionPush] buildAnimated:animated completion:nil];
}

- (void)hi_presentPath:(NSString *)path withParameters:(id)parametes animated:(BOOL)animated completion:(void(^)(void))completion{
    
    [[HiRouter.instance build:path fromViewController:self withParameters:parametes action:HiRouterNavigationActionPresent] buildAnimated:animated completion:completion];
}

- (void)hi_presentPath:(NSString *)path animated:(BOOL)animated completion:(void(^)(void))completion{
    
    [[HiRouter.instance build:path fromViewController:self action:HiRouterNavigationActionPresent] buildAnimated:animated completion:completion];
}

- (void)hi_callBackParameters:(id)callBackParameters {
    
    [HiRouter.instance routerCallBackFromViewController:self callBackParameters:callBackParameters];
}

@end
