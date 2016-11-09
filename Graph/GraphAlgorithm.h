//
//  GraphAlgorithm.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/22/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GraphEdge.h"

@interface GraphAlgorithm : NSObject

/*
 Single Source Shortest path
 Bellman - Ford Algorithm
 
 The Bellman-Ford algorithm solves the single-source shortest-paths problem in the general case in which edge weights may be negative.
 The Bellman-Ford algorithm runs in time O(V*E)
 
 Pseudo-code
 BELLMAN-FORD(G, w, s)
    INITIALIZE-SINGLE-SOURCE(G, s) 
    fori←1to|V[G]|−1
        do for each edge (u,v) ∈ E[G]
            do RELAX(u,v,w)
    
    foreachedge(u,v)∈E[G]
        do if d[v] > d[u] + w(u, v)
            then return FALSE 
 return TRUE
 
 By relaxing the edges of a weighted dag (directed acyclic graph) G = (V, E) according to a topological sort of its vertices, we can compute shortest paths from a single source in  (V + E) time. Shortest paths are always well defined in a dag, since even if there are negative-weight edges, no negative-weight cycles can exist.
 
 DAG-SHORTEST-PATHS (G, w, s)
    topologically sort the vertices of G 
    INITIALIZE-SINGLE-SOURCE(G, s)
    for each vertex u, taken in topologically sorted order
        do for each vertex v ∈ Adj[u] 
            do RELAX(u,v,w)
 
 DIJKSTRA(G,w,s)
    INITIALIZE-SINGLE-SOURCE(G, s) 
    S←∅
    Q←V[G]
    whileQ̸=∅
        do u ← EXTRACT-MIN(Q) S ← S ∪ {u}
        for each vertex v ∈ Adj[u] 
            do RELAX(u,v,w)
 
 AWESOME QUESTION
 
 A d-dimensional box with dimensions (x1, x2, … , xd) nests within another box with
 dimensions (y1, y2, … , yd) if there exists a permutation π on {1,2,…,d} such that xπ(1) <
 y1, xπ(2) < y2, … , xπ(d) < yd. In this paper, we shall see that this relation is transitive and
 we will devise an algorithm that checks whether or not one box can be nested within
 another when the d-dimensions of the two boxes are given. Later, using the transitivity
 relation and our algorithm that checks for nesting of two boxes, we will determine the
 longest sequence of boxes ‹Bi1, Bi2,…, Bik› from a pool of n d-dimensional boxes such
 that Bij nests within Bij+1 for j = 1, 2, … , k-1.
 
 Paper/solution :- http://people.cs.ksu.edu/~pradeep/paper_cis775.pdf
 
 Awesome Graph Questions
 http://courses.csail.mit.edu/6.046/spring04/handouts/ps7sol.pdf
 
*/

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

+ (NSMutableArray<GraphEdge *> *)minimumSpanningTreePrimsMat:(NSArray<NSArray<NSNumber *> *> *)mat;

@end
