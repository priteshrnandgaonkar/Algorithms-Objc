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

/*
 There are N coins with coordinates (x, y) where x >0 and y >0
 You start at (0, 0) and you can only do steps of form (dx, dy) where dx > 0 and dy > 0
 Print the maximum number of coins that you can collect.
 
 Clarification: you can do as many moves as you wish, the point is to collect maximum number of coins. If you are located at position (a, b) you may jump to position (a+dx, b+dy) for all dx > 0 and dy > 0
 */
+ (NSUInteger)maxNumberOfCoinsFromMatrix:(NSArray<NSArray<NSNumber *> *> *)arr;

/*
 GIven a string "str" and pair of "N" swapping indices, generate a lexicographically largest string. Swapping indices can be reused any number times.
 
 Eg 1)
 
 String = "abdc"
 
 Indices:
 
 (1,4)
 
 (3,4)
 
 Answer:
 
 cdba, cbad, dbac,dbca
 
 ​you should print only "dbca" which is lexicographically largest.
 
 Solution:- 
    Consider indices as vertices.
    Connect two vertices with an edge if swapping is allowed between them
 
    Now for each connected component in graph sort the characters represented by the indices(vertex) and place them from highest value to lowest value in those indices.
 
    Result would be a lexicographically largest string.
 */


/*
 A museum was represented by a square matrix that was filled with O, G, and W where O represented open space G represented guards, and W represented walls. Write a function that accepts the square matrix and returns another square matrix where all of the O's in the matrix are replaced with the number of how many spaces they are away from a guard, without being able to go through any walls.
 */

+ (void)distanceFromGuardsAtOpenPlacesInMat:(NSMutableArray<NSMutableArray<NSString *> *> *)mat;

@end
