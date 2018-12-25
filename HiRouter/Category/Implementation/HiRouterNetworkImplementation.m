//
//  HiRouterNetworkImplementation.m
//  RouterDemo
//
//  Created by four on 2018/12/22.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRouterCategory.h"
#import "HiRouter+Filter.h"

@implementation HiRouter (Network)

- (id<HiNetworkFilterProtocol>)performURL:(NSString *)url parameters:(id)parameters {
    
    id<HiNetworkFilterProtocol> filter = [self networkFilterWithURLString:url];
    
    filter.parameters = parameters;
    
    return filter;
}

@end
