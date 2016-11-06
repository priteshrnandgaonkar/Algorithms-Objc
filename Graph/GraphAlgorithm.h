//
//  GraphAlgorithm.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/22/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GraphAlgorithm : NSObject

+ (void)doubleGraphTraversalWithAdjacencyMatrix:(NSArray<NSArray<NSNumber *> *> *)mat root:(NSUInteger)i;

+ (void)DFSWithAdjacencyMatrix:(NSArray<NSArray<NSNumber *> *> *)mat;

+ (void)topologicalSortWithAdjacencyMatrix:(NSArray<NSArray<NSNumber *> *> *)mat;

/*
 Give a linear-time algorithm that takes as input a directed acyclic graph G = (V, E) and two vertices s and t, and returns the number of paths from s to t in G. For example, in the directed acyclic graph of Figure 22.8, there are exactly four paths from vertex p to vertex v: pov, poryv, posryv, and psryv. (Your algo- rithm only needs to count the paths, not list them.)
 */

+ (NSUInteger)numberOfPathsFromSource:(NSUInteger)source destination:(NSUInteger)destination adjacencyMatrix:(NSArray<NSArray<NSNumber *> *> *)mat;

/*
 Give an algorithm that determines whether or not a given undirected graph G = (V, E) contains a cycle. Your algorithm should run in O(V ) time, independent of |E|.
 */
+ (BOOL)doesUndirectedGraphHasLoopMatrix:(NSArray<NSArray<NSNumber *> *> *)mat;

+ (void)stronglyConnectedComponent:(NSArray<NSArray<NSNumber *> *> *)mat;

+ (NSSet<NSNumber *> *)minimumSpanningTreeKruskal:(NSArray<NSArray<NSNumber *> *> *)mat;
@end
