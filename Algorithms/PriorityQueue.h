//
//  PriorityQueue.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/2/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "Heap.h"

//INSERT(S, x) inserts the element x into the set S. This operation could be written as S ← S ∪ {x}.
//MAXIMUM(S) returns the element of S with the largest key.
//EXTRACT-MAX(S) removes and returns the element of S with the largest key.
//INCREASE-KEY (S, x, k) increases the value of element x’s key to the new value k, which is assumed to be at least as large as x’s current key value.

@interface MaxPriorityQueue: Heap

@property(nonnull, strong) NSMutableArray<NSNumber *> *mutArray;

- (instancetype)initMaxPriorityQueueWithArray:(NSArray<NSNumber *> * _Nonnull)arr;
- (void)icrementNumberAtIndex:(NSUInteger)idx withNumber:(NSNumber * _Nonnull)num;

- (void)insertNumber:( NSNumber * _Nonnull )num;
- ( NSNumber * _Nonnull )maximum;
- ( NSNumber * _Nonnull )extractMaximum;


@end
