//
//  HiRouterVMImplementation.m
//  RouterDemo
//
//  Created by four on 2018/12/20.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRouterCategory.h"
#import <objc/runtime.h>

// release observer
@interface HiObjectReleaseObserver : NSObject

@property (nonatomic,weak) NSObject *observer;
- (instancetype)initWithObsever:(NSObject *)observer;

@end

@interface NSObject (hi_delegate)<HiRouterViewModel>

@property (nonatomic,weak) NSObject<HiRouterViewModel> * hi_private_delegate;
@property (nonatomic,strong) HiObjectReleaseObserver *releaseObserver;

@end

@implementation NSObject (hi_delegate)

- (void)setReleaseObserver:(HiObjectReleaseObserver *)releaseObserver {
    objc_setAssociatedObject(self, @selector(releaseObserver), releaseObserver, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (HiObjectReleaseObserver *)releaseObserver {
    return objc_getAssociatedObject(self, @selector(releaseObserver));
}

- (void)setHi_private_delegate:(NSObject<HiRouterViewModel> *)hi_private_delegate {
    
    if (hi_private_delegate) {
        hi_private_delegate.releaseObserver = [[HiObjectReleaseObserver alloc] initWithObsever:self];
    }
    
    objc_setAssociatedObject(self, @selector(hi_private_delegate), hi_private_delegate, OBJC_ASSOCIATION_ASSIGN);
}

- (NSObject<HiRouterViewModel> *)hi_private_delegate {
    return objc_getAssociatedObject(self, @selector(hi_private_delegate));
}

@end


@implementation HiObjectReleaseObserver

- (instancetype)initWithObsever:(NSObject *)observer
{
    self = [super init];
    if (self) {
        _observer = observer;
    }
    return self;
}

- (void)dealloc {

    self.observer.hi_private_delegate = nil;
}

@end

@implementation HiRouter (VM)

+ (void) bind:(NSObject<HiRouterViewModel> *)objcA objcB:(NSObject<HiRouterViewModel> *)objcB {
    
    objcA.hi_private_delegate = objcB;
    objcB.hi_private_delegate = objcA;
}

+(BOOL)objc:(NSObject<HiRouterViewModel> *)objc postData:(id)data {
    
    if ([objc.hi_private_delegate respondsToSelector:@selector(received:)]) {
        
        [objc.hi_private_delegate received:data];

        return true;
    }

    return false;
}

#pragma mark - public
/**
 build view and model in dynamic
 */

- (void) buildViewModelInDynamic:(NSObject<HiRouterViewModel> *)objectA objectB:(NSObject<HiRouterViewModel> *)objectB {
    
    [HiRouter bind:objectA objcB:objectB];
}

- (BOOL) invork:(NSObject<HiRouterViewModel> *)invork postData:(id)data {

    return [HiRouter objc:invork postData:data];
}

@end
