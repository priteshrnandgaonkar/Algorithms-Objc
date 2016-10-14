//
//  Arrays-Algorithms.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/5/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Arrays_Algorithms : NSObject

+ (NSArray<NSNumber *> *)permuteArray:(NSArray<NSNumber *> *)array;
+ (void)sortArray1:(NSMutableArray<NSNumber *> *)array1 basedOnArray2:(NSMutableArray<NSNumber *> *)array2 withStartIndex:(NSUInteger)startIndex andEndIndex:(NSUInteger)endIndex;

// Complexity:- O(n) space complexity:- O(1), worst-case:- O(n^2)
+ (NSNumber *)ithSmallestNumberinArray:(NSArray<NSNumber *> *)array fori:(NSUInteger)index withStartIndex:(NSUInteger)startIndex andEndIndex:(NSUInteger)endIndex ;

@end
