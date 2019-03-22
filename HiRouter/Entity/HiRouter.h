//
//  Router.h
//  Router
//
//  Created by Four on 2018/7/10.
//  Copyright © 2018年 Four. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HiRouterBuilder.h"
#import "HiRouterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface HiRouter : NSObject

/**
 * instance
 */
@property (readonly, nonatomic, class) HiRouter *instance;

@property (readonly, nonatomic) NSDictionary<NSString *, NSString *> *routeDictionary;
@property (readonly, nonatomic) NSDictionary<NSString *, id<HiPageFilterProtocol>> *pageFilters;
@property (readonly, nonatomic) NSDictionary<NSString *, id<HiNetworkFilterProtocol>> *networkFilters;

@property (readonly, nonatomic) NSMapTable<NSString *, UIViewController<HiRouterPageProtocol> *> *viewControllers;

- (void) registRoute:(NSDictionary<NSString *, NSString *> *)routeDictionary;

/**
 regist filer
 */
- (void) registPageFilter:(id<HiPageFilterProtocol>)filter;

- (void) registNetworkFilter:(id<HiNetworkFilterProtocol>)filter;

@end

NS_ASSUME_NONNULL_END
