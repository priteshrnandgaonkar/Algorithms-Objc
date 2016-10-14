//
//  Heap.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/2/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>

// A heap(is a complete binary tree) of size n, has at most ceil(n/pow(2, h+1))
// nodes with height h. Therefore the max no. of leaf nodes are ceil(n/2)
// Thus in an array the indexes starting from ceil(n/2), ceil(n/2) + 1, ceil(n/2) + 2 ....n corresponds to leaf nodes

// For a tree with a root node and a left subtree and right subtree,
// Maximum no. of nodes in any of the two subtree is bounded by 2n/3 where n is the thotal no. of nodes in a tree.
//Lets prove this Lemma:-
//                root
//            / \      / \
//           /___\    /___\
//           * * *
//

@interface Heap : NSObject

@property(nonatomic, readonly, strong) NSArray<NSNumber *> *array;
@property(nonatomic, readonly, assign) BOOL shouldSortInAcendingOrder;

- (instancetype)initWithArray:(NSArray<NSNumber *> *)array shouldSortInAcendingOrder:(BOOL)shouldSortInAcendingOrder;

//Time Complexity = O(nlogn), Space Complexity = O(1)
- (NSArray<NSNumber *> *)heapSort;

//Time Complexity = O(nlogn), Space Complexity = O(1)
- (NSMutableArray<NSNumber *> *)buildHeap;

//Before calling this method add a dummy entry at 0th position
- (void)heapifyOnArray:(NSMutableArray<NSNumber *> *)mutArray atIndex:(NSUInteger)idx count:(NSUInteger)count;
@end
