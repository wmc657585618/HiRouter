//
//  RouterProtocol.h
//  RouterView
//
//  Created by Four on 2018/7/11.
//  Copyright © 2018年 Four. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HiRouterDefine.h"

#pragma mark - page
@protocol HiRouterPageProtocol <NSObject>

@optional
- (void)recivedParameters:(id)parameters;

- (void)recivedCallBack:(id)callBack;

@end

#pragma mark - view model
@protocol HiRouterViewModel <NSObject>

@optional
- (void) received:(id)receive;

@end

#pragma mark - filter
@protocol HiFilterProtocol <NSObject>

@property (nonatomic,readonly) NSUInteger priority;
@property (nonatomic,readonly) NSString *filterRegex;

@property (nonatomic,copy) NSString *originPath;
@property (nonatomic,readonly) NSString *forwardPath;

@property (nonatomic,strong) id parameters;

@end

@protocol HiPageFilterProtocol <HiFilterProtocol>

@property (nonatomic,readonly) HiRouterNavigationAction navigationAction;

@end

@protocol HiNetworkFilterProtocol <HiFilterProtocol>

@property (nonatomic,readonly) NSString *result; // like method: get post put ...

@end
