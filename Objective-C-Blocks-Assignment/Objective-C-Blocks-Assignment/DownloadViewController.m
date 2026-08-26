#import "DownloadViewController.h"
#import "NetworkClient.h"

// Question 2)

@interface DownloadViewController ()

@property (nonatomic, strong) NetworkClient *networkClient;
@property (nonatomic, copy) dispatch_block_t completionBlock;

@end

@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)startDownload {
    __weak typeof(self) weakSelf = self;
    [self.networkClient fetchDataWithCompletion:^{
        
      /**  The outer weakSelf / strongSelf pattern is not a problem because the outer block is used only once and is not stored. strongSelf is temporary, so it does not create a retain cycle.**/
        __strong typeof(self) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        
        /** completionBlock is stored as a property of the ViewController.  If we directly use strongSelf inside completionBlock, the block will keep the ViewController strongly. At the same time, the ViewController already keeps completionBlock strongly through its property. So both of them keep each other alive:
         ViewController -> completion, completionBlock -> ViewController. This creates a retain cycle and the ViewController may not  deallocated when it is no longer needed. To avoid this, we use weakSelf inside completionBlock. A weak  does not keep the ViewController alive, so the retain cycle is broken. However, weakSelf can become nil if the ViewController is deallocated before completionBlock runs. Therefore, when completionBlock starts executing, we create innerStrongSelf from weakSelf. innerStrongSelf temporarily keeps the ViewController alive while the code inside the block is running. If the ViewController has already been deallocated, weakSelf will be nil, so innerStrongSelf will also be nil. In that case, we simply return. After the block finishes executing, innerStrongSelf is released because it is only a local variable. Therefore, it does not create another retain cycle. **/
        
        strongSelf.completionBlock = ^{
            __strong typeof(weakSelf) innerStrongSelf = weakSelf;
            if (!innerStrongSelf) return;
            [innerStrongSelf updateUI];
        };
    }];
}
- (void)updateUI {
    NSLog(@"Updating UI");
}


@end
