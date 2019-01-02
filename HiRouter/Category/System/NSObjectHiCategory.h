//
//  NSObjectHiCategory.h
//  RouterDemo
//
//  Created by four on 2018/12/25.
//  Copyright © 2018 Four. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HiRouterCategory.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HiRouter)<HiRouterViewModel>

- (void)hi_bindObject:(NSObject<HiRouterViewModel> *)object;

- (void)hi_postData:(id)data;

@end

@interface NSString (HiPredicate)

-(BOOL)isValidateRegularByExpression:(NSString *)strExpression;

@end

@interface UIViewController (HiRouterTransitioningAction)<HiRouterPageProtocol>

- (void)hi_pushPath:(NSString *)path animated:(BOOL)animated;
- (void)hi_pushPath:(NSString *)path withParameters:(id)parameters animated:(BOOL)animated;

- (void)hi_presentPath:(NSString *)path animated:(BOOL)animated completion:(void(^)(void))completion;
- (void)hi_presentPath:(NSString *)path withParameters:(id)parametes animated:(BOOL)animated completion:(void(^)(void))completion;

- (void)hi_callBackParameters:(id)callBackParameters;

@end

NS_ASSUME_NONNULL_END
