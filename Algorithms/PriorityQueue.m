//
//  PriorityQueue.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/2/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "PriorityQueue.h"

@interface MaxPriorityQueue()


@end

@implementation MaxPriorityQueue

- (instancetype)initMaxPriorityQueueWithArray:(NSArray<NSNumber *> *)arr {
    
    if(self = [super initWithArray:arr shouldSortInAcendingOrder: NO]) {
        [self buildHeap];
        self.mutArray = self.array.mutableCopy;
    }
    return self;
}

- (NSNumber *)maximum {
    return self.mutArray[0];
}

- (NSNumber *)extractMaximum {
    NSNumber *max = self.mutArray[0];
    self.mutArray[0] = self.mutArray.lastObject;
    self.mutArray[self.mutArray.count - 1] = max;
    [self.mutArray removeLastObject];
    
    [self.mutArray insertObject:@(NSIntegerMax) atIndex:0];
    
    [self heapifyOnArray:self.mutArray atIndex:1 count:self.mutArray.count];
    [self.mutArray removeObjectAtIndex:0];
    return max;
}

- (void)upwardHeapificationFromIndex:(NSUInteger)idx {
    
    NSUInteger parentIndex = idx/2;
    NSNumber *val = self.mutArray[idx];
    if(self.mutArray[parentIndex] < self.mutArray[idx]) {
        self.mutArray[idx] = self.mutArray[parentIndex];
        self.mutArray[parentIndex] = val;
        [self upwardHeapificationFromIndex:parentIndex];
    }
}

- (void)icrementNumberAtIndex:(NSUInteger)idx withNumber:(NSNumber *)num {
    if(self.mutArray[idx].integerValue > num.integerValue) {
        return;
    }
    self.mutArray[idx] = num;
    [self upwardHeapificationFromIndex:idx];
}

- (void)insertNumber:(NSNumber *)num {
    [self.mutArray addObject:num];
    [self upwardHeapificationFromIndex:self.mutArray.count - 1];
}

@end
