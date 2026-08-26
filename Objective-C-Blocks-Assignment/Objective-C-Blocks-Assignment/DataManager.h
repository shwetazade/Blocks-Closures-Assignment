#import <Foundation/Foundation.h>

// Question 3)

NS_ASSUME_NONNULL_BEGIN

typedef void (^FetchDataCompletion)(NSData * _Nullable data,
                                    NSError * _Nullable error);


@interface DataManager : NSObject

/** The 'copy' attribute is used because the block is stored in a property and executed later. Blocks are initially created on the stack within the scope where they are defined. Using 'copy' copies the block to the heap, allowing it to remain in memory even after its original scope has ended. This is important here because the completion block is executed after a 1-second delay. Without 'copy', the block may no longer be valid when we try to execute it later.
 */
@property (nonatomic, copy) FetchDataCompletion completion;

- (void)fetchData;

@end

NS_ASSUME_NONNULL_END
