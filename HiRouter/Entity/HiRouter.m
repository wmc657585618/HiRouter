//
//  Router.m
//  Router
//
//  Created by Four on 2018/7/10.
//  Copyright © 2018年 Four. All rights reserved.
//

#import "HiRouter.h"

@interface HiRouter ()<NSCopying,NSMutableCopying>

/**
 route dictionary
 */
@property (strong, nonatomic) NSMutableDictionary<NSString *, NSString *> *pRouteDictionary;

@property (strong, nonatomic) NSMutableDictionary<NSString *, id<HiPageFilterProtocol>> *pPageFilters;
@property (strong, nonatomic) NSMutableDictionary<NSString *, id<HiNetworkFilterProtocol>> *pNetworFilters;
@property (nonatomic,strong) NSMapTable<NSString *, UIViewController<HiRouterPageProtocol> *> *pViewControllers;

@property (strong, nonatomic) NSLock *pageFilterLock;
@property (strong, nonatomic) NSLock *networkFilterLock;
@property (strong, nonatomic) NSLock *routerLock;

@end

static HiRouter *_instance = nil;

@implementation HiRouter

/*********** instance router ***********/
+ (instancetype)instance {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        _instance = (HiRouter *) [[super allocWithZone:NULL] init];
    });

    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {

    return HiRouter.instance;
}

- (id)copyWithZone:(NSZone *)zone {

    return HiRouter.instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {

    return HiRouter.instance;
}

/*********** instance router ***********/

/****************** lazy ******************/
- (NSMutableDictionary<NSString *,NSString *> *)pRouteDictionary {
    
    if (!_pRouteDictionary) {
        _pRouteDictionary = [NSMutableDictionary dictionary];
    }
    return _pRouteDictionary;
}

- (NSMutableDictionary *)pPageFilters {
    
    if (!_pPageFilters) {
        _pPageFilters = [[NSMutableDictionary alloc] init];
    }
    return _pPageFilters;
}

- (NSMutableDictionary *)pNetworFilters {
    
    if (!_pNetworFilters) {
        _pNetworFilters = [[NSMutableDictionary alloc] init];
    }
    return _pNetworFilters;
}

- (NSLock *)pageFilterLock {
    
    if (!_pageFilterLock) {
        _pageFilterLock = [[NSLock alloc] init];
    }
    return _pageFilterLock;
}

- (NSLock *)networkFilterLock {
    
    if (!_networkFilterLock) {
        _networkFilterLock = [[NSLock alloc] init];
    }
    return _networkFilterLock;
}

- (NSLock *)routerLock {
    
    if (!_routerLock) {
        _routerLock = [[NSLock alloc] init];
    }
    return _routerLock;
}

- (NSMapTable *)pViewControllers {
    if (!_pViewControllers) _pViewControllers = [NSMapTable mapTableWithKeyOptions:NSHashTableStrongMemory valueOptions:NSHashTableWeakMemory];
    return _pViewControllers;
}

/****************** lazy ******************/

#pragma mark - public
/*********** regist router ***********/
- (void) registRoute:(NSDictionary<NSString *, NSString *> *)routeDictionary {
    
    [self.routerLock lock];
    
    [self.pRouteDictionary addEntriesFromDictionary:routeDictionary];
    
    [self.routerLock unlock];
}

- (void)registPageFilter:(id<HiPageFilterProtocol>)filter {
    
    [self.pageFilterLock lock];
    
    if ([filter conformsToProtocol:@protocol(HiPageFilterProtocol)] && filter.filterRegex.length > 0) {
        [self.pPageFilters setObject:filter forKey:filter.filterRegex];
    }
    
    [self.pageFilterLock unlock];
}

- (void)registNetworkFilter:(id<HiNetworkFilterProtocol>)filter {

    [self.networkFilterLock lock];
    
    if ([filter conformsToProtocol:@protocol(HiNetworkFilterProtocol)] && filter.filterRegex > 0) {
        [self.pNetworFilters setObject:filter forKey:filter.filterRegex];
    }
    
    [self.networkFilterLock unlock];
}

- (NSDictionary<NSString *,NSString *> *)routeDictionary {
    
    return self.pRouteDictionary;
}

- (NSDictionary *)pageFilters {
    
    return self.pPageFilters;
}

- (NSDictionary<NSString *,id<HiNetworkFilterProtocol>> *)networkFilters {
    
    return self.pNetworFilters;
}

- (NSMapTable<NSString *,UIViewController<HiRouterPageProtocol> *> *)viewControllers {
    
    return self.pViewControllers;
}
@end
