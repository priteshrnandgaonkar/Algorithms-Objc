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
@end
