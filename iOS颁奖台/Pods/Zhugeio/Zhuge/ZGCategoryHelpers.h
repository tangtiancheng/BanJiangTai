#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface UIView (ZGHelpers)

- (UIImage *)zg_snapshotImage;
- (UIImage *)zg_snapshotForBlur;
- (int)zg_fingerprintVersion;

@end

