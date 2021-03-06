//
//  HiRouterPageImplementation.m
//  RouterDemo
//
//  Created by four on 2018/12/20.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRouterCategory.h"
#import "HiRouter+Filter.h"
#import <objc/runtime.h>

// for release delegate
@interface HiRouterPageReleasObserver : NSObject

@property (nonatomic,weak) UIViewController *observer;

- (instancetype)initWithObserver:(UIViewController *)observer;

@end

// private delegate
@interface UIViewController (HiRouter_page_delegate)<HiRouterPageProtocol>

@property (nonatomic,weak) UIViewController<HiRouterPageProtocol> *hi_private_page_delegate;
@property (nonatomic,strong) HiRouterPageReleasObserver *pReleaseObserver;

@end

@implementation UIViewController (HiRouter_page_delegate)
- (void)setPReleaseObserver:(HiRouterPageReleasObserver *)pReleaseObserver{
    objc_setAssociatedObject(self, @selector(pReleaseObserver), pReleaseObserver, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (HiRouterPageReleasObserver *)pReleaseObserver {
    return objc_getAssociatedObject(self, @selector(pReleaseObserver));
}

- (void)setReleaseObserver:(UIViewController *)observer {
    self.pReleaseObserver = [[HiRouterPageReleasObserver alloc] initWithObserver:observer];
}

- (void)setHi_private_page_delegate:(UIViewController<HiRouterPageProtocol> *)hi_private_page_delegate {
    
    // if hi_private_page_delegate released, self.hi_private_page_delegate will set nil;
    if (hi_private_page_delegate) {
        [hi_private_page_delegate setReleaseObserver:self];
    }
    objc_setAssociatedObject(self, @selector(hi_private_page_delegate), hi_private_page_delegate, OBJC_ASSOCIATION_ASSIGN);
}

- (UIViewController<HiRouterPageProtocol> *)hi_private_page_delegate {
    return objc_getAssociatedObject(self, @selector(hi_private_page_delegate));
}

@end

#pragma mark - ReleasObserver implementation
@implementation HiRouterPageReleasObserver

- (instancetype)initWithObserver:(UIViewController *)observer
{
    self = [super init];
    if (self) {
        _observer = observer;
    }
    return self;
}

- (void)dealloc {

    self.observer.hi_private_page_delegate = nil;
}

@end


@implementation HiRouter (Page)

// get viewcontroller with path
- (UIViewController<HiRouterPageProtocol> *) viewControllerWithPath:(NSString *)path {
    
    NSString *className = [self.routeDictionary objectForKey:path];
    
    NSAssert(className.length > 0, @"⚠️ no path match : %@!",path);
    
    Class class = NSClassFromString(className);
    
    NSAssert(class != nil, @"⚠️ has no class : %@!",className);
    
    id vc = [[class alloc] init];
    
    NSAssert([vc isKindOfClass:UIViewController.class], @"⚠️ class is not UIViewController!");
    
    if ([vc isKindOfClass:UIViewController.class]) {
        return vc;
    }
    
    return nil;
}

// post parameters to viewcontroller
- (UIViewController<HiRouterPageProtocol> *) viewControllerWithPath:(NSString *)path parameters:(id)parameters {
    
    UIViewController<HiRouterPageProtocol> *pViewController = [self viewControllerWithPath:path];
    
    if (pViewController && [pViewController respondsToSelector:@selector(recivedParameters:)] && parameters) {
        
        [pViewController recivedParameters:parameters];
    }
    
    return pViewController;
}

#pragma mark - public
- (HiRouterBuilder *) build:(NSString *)path {
    
    return [self build:path action:HiRouterTransitioningActionNone];
}

- (HiRouterBuilder *) build:(NSString *)path action:(HiRouterTransitioningAction)action {
    
    return [self build:path fromViewController:nil action:action];
}

- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController action:(HiRouterTransitioningAction)action {
    
    return [self build:path fromViewController:viewController withParameters:nil action:action];
}

- (HiRouterBuilder *) build:(NSString *)path fromViewController:(UIViewController<HiRouterPageProtocol> *)viewController withParameters:(id)parameters action:(HiRouterTransitioningAction)action{
    
    // check filter
    id<HiPageFilterProtocol> pageFilter = [self pageFilterWithPath:path];
    
    NSString *realPath = path;
    id realParameters = parameters;
    
    HiRouterBuilder *builder = [[HiRouterBuilder alloc] init];
    builder.transitioningAction = action;
    
    if (pageFilter) {
        realPath = pageFilter.forwardPath ? : path;
        realParameters = pageFilter.parameters ? : parameters;
        builder.transitioningAction = pageFilter.transitioningAction;
    }
    
    UIViewController<HiRouterPageProtocol> *targetViewController = [self viewControllerWithPath:realPath parameters:realParameters];
    
    // set delegate,then can callback
    targetViewController.hi_private_page_delegate = viewController;
    
    builder.targetViewController = targetViewController;
    builder.sourceViewController = viewController;
    
    // record
    [self.viewControllers setObject:targetViewController forKey:path];
    
    return builder;
}

- (BOOL) routerCallBackFromViewController:(UIViewController<HiRouterPageProtocol> *)viewController callBackParameters:(id)callBackParameters {
    
    if ([viewController.hi_private_page_delegate respondsToSelector:@selector(recivedCallBack:)]) {
        
        // post data to delegate
        [viewController.hi_private_page_delegate recivedCallBack:callBackParameters];
        
        return true;
    }
    
    return false;
}

@end
