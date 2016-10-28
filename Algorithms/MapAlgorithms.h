//
//  MapAlgorithms.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/14/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapNode.h"
#import "Map.h"

@interface MapAlgorithms : NSObject

+ (void)inorderTreeTraversalWithRoot:(MapNode *)root;
+ (MapNode *)binarySearchTreeWithRoot:(MapNode *)node number:(NSNumber *)num;
+ (void)depthFirstSearch:(Map *)map;
+ (NSDictionary<NSNumber *, MapNode *> *)firstUnmachedLeafPairForTreeOne:(Map *)rootOne treeTwo:(Map *)rootTwo;
+ (MapNode *)minimumIterativelyForTreeRoot:(MapNode *)root;
+ (MapNode *)minimumForTreeRoot:(MapNode *)root;
+ (MapNode *)maximumIterativelyForTreeRoot:(MapNode *)root;
+ (MapNode *)predecessorForNode:(MapNode *)node;
+ (MapNode *)searchNumber:(NSNumber *)num root:(MapNode *)root;

@end
