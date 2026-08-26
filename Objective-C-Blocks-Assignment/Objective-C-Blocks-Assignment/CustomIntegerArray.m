#import "CustomIntegerArray.h"

// Question 1)

@implementation CustomIntegerArray {
    NSMutableArray<NSNumber *> *_storage;
}

- (instancetype)initWithValues:(NSArray<NSNumber *> *)values {
    self = [super init];

    if (self) {
        _storage = [values mutableCopy] ?: [NSMutableArray array];
    }

    return self;
}

- (NSArray<NSNumber *> *)allValues {
    return [_storage copy];
}

// MARK: - Filter

- (CustomIntegerArray *)filter:(FilterPredicateBlock)block {
    
    NSMutableArray<NSNumber *> *result = [NSMutableArray array];
    
    for (NSNumber *number in _storage) {
        
        NSInteger value = [number integerValue];
        
        if (block(value)) {
            [result addObject:number];
        }
    }
    
    return [[CustomIntegerArray alloc] initWithValues:result];
}

// MARK: - Reduce

- (NSInteger)reduce:(ReduceBlock)block
        withInitial:(NSInteger)initial {
    
    NSInteger result = initial;
    
    for (NSNumber *number in _storage) {
        
        NSInteger value = [number integerValue];
        
        result = block(result, value);
    }
    
    return result;
}

// MARK: - Sort

- (CustomIntegerArray *)sortedArrayUsingBlock:(SortComparisonBlock)block {
    
    NSArray<NSNumber *> *sortedValues =
    [_storage sortedArrayUsingComparator:^NSComparisonResult(
        NSNumber *a,
        NSNumber *b
    ) {
        return block([a integerValue], [b integerValue]);
    }];
    
    return [[CustomIntegerArray alloc] initWithValues:sortedValues];
}


// MARK: - For Each

- (void)forEach:(ForEachBlock)block {
    
    for (NSNumber *number in _storage) {
        
        NSInteger value = [number integerValue];
        
        block(value);
    }
}

- (NSString *)description {
    return [_storage description];
}

@end
