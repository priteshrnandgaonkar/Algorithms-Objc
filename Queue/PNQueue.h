//
//  PNQueue.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/29/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PNQueue<ObjectType: NSObject *> : NSObject

- (instancetype)init;
- (instancetype)initWithObject:(ObjectType)object;
- (void)enqueue:(ObjectType)object;
- (ObjectType)dequeue;
- (NSUInteger)count;
- (void)print;

@end
