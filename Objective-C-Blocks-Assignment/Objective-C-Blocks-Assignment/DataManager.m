#import "DataManager.h"

// Question 3)

@implementation DataManager

- (void)fetchData {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC),
                   dispatch_get_main_queue(), ^{
        
        NSData *data = [@"Sample Data" dataUsingEncoding:NSUTF8StringEncoding];
        
        if (self.completion) {
            self.completion(data, nil);
        }
    });
}

@end
