//
//  HiRouter+Filter.m
//  RouterDemo
//
//  Created by four on 2018/11/12.
//  Copyright © 2018 Four. All rights reserved.
//

#import "HiRouter+Filter.h"
#import "NSObjectHiCategory.h"

@implementation HiRouter (Filter)

- (id)filterWithString:(NSString *)string filterArray:(NSArray *)filterArray {
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        
        id<HiFilterProtocol> filter = evaluatedObject;
        
        return [string isValidateRegularByExpression:filter.filterRegex];
    }];
    
    NSArray *array = [filterArray filteredArrayUsingPredicate:predicate];
    
    NSArray *result = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        id<HiFilterProtocol> filter1 = obj1;
        id<HiFilterProtocol> filter2 = obj2;
        
        if (filter1.priority > filter2.priority) return NSOrderedAscending;
        if (filter1.priority < filter2.priority) return NSOrderedDescending;
        return  NSOrderedSame;
    }];
    
    id<HiFilterProtocol> filter = result.firstObject;
    filter.originPath = string;
    return filter;
}

- (id<HiPageFilterProtocol>)pageFilterWithPath:(NSString *)path {
    
    return [self filterWithString:path filterArray:self.pageFilters.allValues];
}

- (id<HiNetworkFilterProtocol>)networkFilterWithURLString:(NSString *)urlString {
    
    return [self filterWithString:urlString filterArray:self.networkFilters.allValues];
}

@end
