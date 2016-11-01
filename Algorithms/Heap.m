//
//  Heap.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/2/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "Heap.h"

@interface Heap()

@property(nonatomic, strong) NSMutableArray<NSNumber *> *mutableArray;
@property(nonatomic, assign) BOOL shouldSortInAcendingOrder;

@end

@implementation Heap

- (instancetype)initWithArray:(NSArray<NSNumber *> *)array shouldSortInAcendingOrder:(BOOL)shouldSortInAcendingOrder {
    if(self = [super init]){
        _mutableArray = array.mutableCopy;
        _shouldSortInAcendingOrder = shouldSortInAcendingOrder;
    }
    [self buildHeap];
    return self;
}

- (instancetype)initWithSortingOrder:(BOOL)shouldSortInAcendingOrder {

    self = [super init];
    if (self) {
        _mutableArray = @[].mutableCopy;
        _shouldSortInAcendingOrder = shouldSortInAcendingOrder;
    }
    return self;
}

- (void)deleteRoot {
    if(self.mutableArray.count == 0) {
        return;
    }
    else {
        NSNumber *lastNum = self.mutableArray.lastObject;
        self.mutableArray[0] = lastNum;
        [self.mutableArray removeLastObject];
        [self.mutableArray insertObject:@(NSNotFound) atIndex:0];
        [self heapifyOnArray:self.mutableArray atIndex:1 count:self.mutableArray.count];
        [self.mutableArray removeObjectAtIndex:0];
    }
}

- (void)insertNumber:(NSNumber *)num {
    [self.mutableArray addObject:num];
    
    if(self.mutableArray.count > 0) {
        [self heapifyUpFromIndex:self.mutableArray.count - 1];
    }
}

- (void)heapifyUpFromIndex:(NSUInteger)idx {
    
    NSUInteger indexToSwap = NSNotFound;
    if(self.mutableArray[(NSUInteger)floor(idx/2)] > self.mutableArray[idx] && self.shouldSortInAcendingOrder) {
        NSNumber *num = self.mutableArray[(NSUInteger)floor(idx/2)];
        self.mutableArray[(NSUInteger)floor(idx/2)] = self.mutableArray[idx];
        self.mutableArray[idx] = num;
        indexToSwap = (NSUInteger)floor(idx/2);
    }
    
    else if(self.mutableArray[(NSUInteger)floor(idx/2)] < self.mutableArray[idx] && !self.shouldSortInAcendingOrder) {
        NSNumber *num = self.mutableArray[(NSUInteger)floor(idx/2)];
        self.mutableArray[(NSUInteger)floor(idx/2)] = self.mutableArray[idx];
        self.mutableArray[idx] = num;
        indexToSwap = (NSUInteger)floor(idx/2);
    }
    
    if (indexToSwap != NSNotFound) {
        [self heapifyUpFromIndex:indexToSwap];
    }
}

- (NSArray<NSNumber *> *)array{
    return [NSArray arrayWithArray:self.mutableArray];
}

//Time Complexity = O(nlogn), Space Complexity = O(1)
- (NSArray<NSNumber *> *)heapSort {
    [self buildHeap];
    [self.mutableArray insertObject:@(NSIntegerMax) atIndex:0];
    
    NSUInteger count = self.mutableArray.count;

    while(count >= 2) {
        
        NSNumber *firstObject = self.mutableArray[1];
        //Swap
        [self.mutableArray removeObjectAtIndex:1];
        [self.mutableArray addObject:firstObject];
        count--;
        [self heapifyOnArray:self.mutableArray atIndex:1 count:count];
    }
    [self.mutableArray removeObjectAtIndex: 0];
    return [NSArray arrayWithArray:self.mutableArray];
}

//Time Complexity = O(logn), Space Complexity = O(1)
- (void)heapifyOnArray:(NSMutableArray<NSNumber *> *)mutArray atIndex:(NSUInteger)idx count:(NSUInteger)count {
    NSUInteger indexToSwap = idx;
    NSNumber *val = mutArray[idx];
    if(!self.shouldSortInAcendingOrder) {
        //MaxHeapify
        if(2*idx < count && val.integerValue < mutArray[2*idx].integerValue) {
            indexToSwap = 2 * idx;
            val = mutArray[indexToSwap];
        }
        if(((2*idx) + 1) < count && val.integerValue < mutArray[(2 * idx) + 1].integerValue) {
            indexToSwap = (2 * idx) + 1;
            val = mutArray[indexToSwap];
        }
    }
    else {
        //MinHeapify
        if(2*idx < count && val.integerValue > mutArray[2*idx].integerValue) {
            indexToSwap = 2 * idx;
            val = mutArray[indexToSwap];
        }
        if(((2*idx) + 1) < count && val.integerValue > mutArray[(2 * idx) + 1].integerValue) {
            indexToSwap = (2 * idx) + 1;
            val = mutArray[indexToSwap];
        }
    }
    
    if(indexToSwap != idx) {
        mutArray[indexToSwap] = mutArray[idx];
        mutArray[idx] = val;
        [self heapifyOnArray:mutArray atIndex:indexToSwap count:count];
    }
}

//Time Complexity = O(nlogn), Space Complexity = O(1)
- (NSMutableArray<NSNumber *> *)buildHeap {
    [self.mutableArray insertObject:@(NSIntegerMax) atIndex:0];
    
    NSUInteger index = self.mutableArray.count / 2;
    while(index >= 1) {
        [self heapifyOnArray:self.mutableArray atIndex:index count:self.mutableArray.count];
        index--;
    }
    [self.mutableArray removeObjectAtIndex:0];
    return self.mutableArray;
}
@end
