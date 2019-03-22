//
//  HiRouterViewControllerImplementation.m
//  RouterDemo
//
//  Created by four on 2019/03/19.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRouterCategory.h"

@implementation HiRouter (ViewController)

- (NSError *)errorWithCode:(NSInteger)code description:(NSString *)description {
    
    NSString *des = description ? : @"no error";
    return [NSError errorWithDomain:@"HiRouterViewControllerErrorDomain" code:code userInfo:@{NSLocalizedDescriptionKey:des}];
}

- (NSError *)popToPath:(NSString *)path parameters:(id)parameters animated:(BOOL)animated {
    
    UIViewController<HiRouterPageProtocol> *viewController = [self.viewControllers objectForKey:path];
    
    if ([viewController isEqual:viewController.navigationController.topViewController]) {
        NSString *des = @"viewController for path is topViewController in navigation stack";
        return [self errorWithCode:1 description:des];
    }
    
    if (viewController) {
        if ([viewController respondsToSelector:@selector(recivedParameters:)] && parameters) {
            [viewController recivedParameters:parameters];
        }
        
        [viewController.navigationController popToViewController:viewController animated:animated];
        return nil;
    }
    
    NSString *des = @"viewController for path is nil";
    return [self errorWithCode:1 description:des];
}

- (NSError *)removePath:(NSString *)path parameters:(id)parameters {

    UIViewController<HiRouterPageProtocol> *viewController = [self.viewControllers objectForKey:path];
    
    if (viewController) {
        
        UINavigationController *nav = viewController.navigationController;
        NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:nav.viewControllers];
        
        if ([viewController respondsToSelector:@selector(recivedParameters:)] && parameters) {
            [viewController recivedParameters:parameters];
        }
        
        if (viewControllers.count > 1) {
            
            if ([viewController isEqual:nav.topViewController]) {
                [nav popViewControllerAnimated:false];
            } else {
                
                [viewControllers removeObject:viewController];
                nav.viewControllers = viewControllers;
            }
            
        }else {
            
            NSString *des = @"the stack is one viewController";
            return [self errorWithCode:1 description:des];
        }
    }
    
    return nil;
}

- (NSError *)postParameters:(id)parameters toPath:(NSString *)path {
    UIViewController<HiRouterPageProtocol> *viewController = [self.viewControllers objectForKey:path];
    
    if ([viewController respondsToSelector:@selector(recivedParameters:)] && parameters) {
        [viewController recivedParameters:parameters];
        return nil;
    }
    
    NSString *des = @"no method recivedParameters: for viewController";
    return [self errorWithCode:1 description:des];
}

- (UIViewController<HiRouterPageProtocol> *)topViewControllerForPath:(NSString *)path {
    return [self.viewControllers objectForKey:path];
}

@end
