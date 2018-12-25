//
//  HiRouter+Filter.h
//  RouterDemo
//
//  Created by four on 2018/11/12.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRouter.h"

NS_ASSUME_NONNULL_BEGIN

@interface HiRouter (Filter)

- (id<HiPageFilterProtocol>)pageFilterWithPath:(NSString *)path;

- (id<HiNetworkFilterProtocol>)networkFilterWithURLString:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
