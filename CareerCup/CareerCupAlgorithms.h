//
//  CareerCupAlgorithms.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/8/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCMutableNumber.h"
#import "Map.h"

@interface CareerCupAlgorithms : NSObject

// Given the sorted array, return an array with squared elements in the sorted order. The numbers can be negative.
// Complexity:- O(n) Space-complexity:- O(1)
+ (void)squareAndSortArray:(NSMutableArray<NSNumber *> *)array;

+ (BOOL)doesThereExistSubsequenceInArray:(NSArray<NSNumber *> *)array withSum:(NSInteger)sum;

+ (NSDictionary<NSNumber *, MapNode *> *)firstNonMatchingLeafPairFromtree:(Map *)treeOne treeTwo:(Map *)treeTwo;

/// Time Complexity: O(n) and Space Complexity: O(n) where n are the no of intervals
/*
  There's a room with a TV and people are coming in and out to watch it. The TV is on only when there's at least a person in the room.
  For each person that comes in, we record the start and end time. We want to know for how long the TV has been on. In other words:
  Given a list of arrays of time intervals, write a function that calculates the total amount of time covered by the intervals.
  For example:
 
  input = [(1,4), (2,3)]
  > 3
  input = [(4,6), (1,2)]
  > 3
  input = [(1,4), (6,8), (2,4), (7,9), (10, 15)]
  > 11

 */
+ (NSUInteger)largestOverlappingLengthAmongstTheGivenIntervals:(NSArray<NSArray<NSNumber *> *> *)arrayOfIntervals;

/// Time complexity O(m * n) and Space Complexity O(m * n)
+ (NSInteger)longestPathFromSourceToDestinationIn:(NSArray<NSArray<NSNumber *> *> *)arr sourceRow:(NSUInteger)sr sourceColumn:(NSUInteger)sc destinationRow:(NSUInteger)dr destinationColumn:(NSUInteger)dc;

+ (NSInteger)shortestPathFromSourceToDestinationIn:(NSArray<NSArray<NSNumber *> *> *)arr sourceRow:(NSUInteger)sr sourceColumn:(NSUInteger)sc destinationRow:(NSUInteger)dr destinationColumn:(NSUInteger)dc;

+ (NSMutableArray<NSString *> *)arrayOfPossibleStringsFromString:(NSString *)str withDict:(NSDictionary<NSString *, NSString *> *)dict;

@end
