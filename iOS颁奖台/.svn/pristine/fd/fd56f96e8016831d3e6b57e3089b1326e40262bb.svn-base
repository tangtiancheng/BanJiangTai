//
//  RACSignal+Extends.h
//  XPApp
//
//  Created by huangxinping on 15/11/13.
//  Copyright © 2015年 ShareMerge. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RACSignal (Extends)

// Begins a long-running background task before subscribing to the receiver,
// then automatically ends the task when the signal terminates.
//
// If running in the background is not possible, the signal will proceed
// normally, but will not continue executing while the app is backgrounded.
//
// Returns a signal which forwards all of the receiver's events. If the
// background task expires before the signal terminates normally, an error with
// code `RACSignalErrorTimedOut` will be sent.
- (RACSignal *)rac_addBackgroundTaskSignal;

// Collects the elements of the receiver into an `NSSet`.
- (RACSignal *)rac_collectSetSignal;

@end
