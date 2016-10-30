//
//  PNQueue.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/29/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "PNQueue.h"

@interface PNQueue()

@property(strong, nonatomic) NSMutableArray<NSObject *> *array;

@end

@implementation PNQueue

- (instancetype)init {
    self = [super init];
    if(self) {
        _array = @[].mutableCopy;
    }
    return self;
}

- (instancetype)initWithObject:(NSObject *)object {
    self = [super init];
    if(self) {
        _array = @[].mutableCopy;
        [_array addObject:object];
    }
    
    return self;
}

- (void)enqueue:(NSObject *)object {
    [self.array addObject:object];
}
- (NSObject *)dequeue {
    NSObject *firstObject = self.array.firstObject;
    [self.array removeObjectAtIndex:0];
    return firstObject;
}

- (NSUInteger)count {
    return self.array.count;
}

- (void)print {
    NSMutableArray<id> *mut = self.array.mutableCopy;
    while(mut.count > 0) {
        Log(@"%@", mut.firstObject);
        [mut removeObjectAtIndex:0];
    }
}


@end
