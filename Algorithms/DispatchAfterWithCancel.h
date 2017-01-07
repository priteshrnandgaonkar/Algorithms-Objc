//
//  DispatchAfterWithCancel.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 12/28/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#ifndef DispatchAfterWithCancel_h
#define DispatchAfterWithCancel_h


#endif /* DispatchAfterWithCancel_h */


typedef void(^dispatch_after_cancel_t)(BOOL shouldCancel);


dispatch_after_cancel_t dispatch_after_cancellable(NSTimeInterval time, dispatch_block_t block) {
    
    dispatch_block_t originalBlock = [block copy];
    
    dispatch_after_cancel_t cancellable = ^(BOOL shouldCancel) {
        
        if (!shouldCancel && originalBlock) {
            originalBlock();
        }
    };
    
    return cancellable;
};


void cancel_block(dispatch_after_cancel_t block) {
    block(YES);
}
