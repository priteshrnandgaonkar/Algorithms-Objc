//
//  CareerCupAlgorithms.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/8/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CareerCupAlgorithms : NSObject

// Given the sorted array, return an array with squared elements in the sorted order. The numbers can be negative.
// Complexity:- O(n) Space-complexity:- O(1)
+ (void)squareAndSortArray:(NSMutableArray<NSNumber *> *)array;

+ (BOOL)doesThereExistSubsequenceInArray:(NSArray<NSNumber *> *)array withSum:(NSInteger)sum;

+ (void)doubleGraphTraversalWithAdjacencyMatrix:(NSArray<NSArray<NSNumber *> *> *)mat root:(NSUInteger)i;
@end
