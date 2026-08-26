#import <Foundation/Foundation.h>

// Question 1)


// 1. Used by filter:
typedef BOOL (^FilterPredicateBlock)(NSInteger value);

// 2. Used by reduce:withInitial:
typedef NSInteger (^ReduceBlock)(NSInteger partial, NSInteger value);

// 3. Used by sortedArrayUsingBlock:
typedef NSComparisonResult (^SortComparisonBlock)(NSInteger a, NSInteger b);

// 4. Used by forEach:
typedef void (^ForEachBlock)(NSInteger value);

@interface CustomIntegerArray : NSObject

- (instancetype)initWithValues:(NSArray<NSNumber *> *)values
NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

// 1. Filter
- (CustomIntegerArray *)filter:(FilterPredicateBlock)block;

// 2. Reduce
- (NSInteger)reduce:(ReduceBlock)block
        withInitial:(NSInteger)initial;

// 3. Sort
- (CustomIntegerArray *)sortedArrayUsingBlock:(SortComparisonBlock)block;

// 4. For each
- (void)forEach:(ForEachBlock)block;

@end
