//
//  Map.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/16/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapNode.h"

NS_ASSUME_NONNULL_BEGIN
@interface Map : NSObject

@property(nonatomic, readonly, strong) MapNode *root;
- (instancetype)initWithRoot:(MapNode *)root;
- (instancetype)init;

- (void)inorderTreeTraversal;
- (MapNode *)binarySearchNumber:(NSNumber *)num;
- (void)insertNumber:(NSNumber *)num;
- (void)insertNode:(MapNode *)node;
- (MapNode *)minimum;
- (MapNode *)maximum;
- (MapNode *)predecessorForNode:(MapNode *)node;
- (MapNode *)successorForNode:(MapNode *)node;
- (void)deleteNode:(MapNode *)node;
//+ (MapNode *)searchNumber:(NSNumber *)num root:(MapNode *)root;

//+ (MapNode *)minimumForTreeRoot:(MapNode *)root;
//+ (MapNode *)maximumIterativelyForTreeRoot:(MapNode *)root;



@end
NS_ASSUME_NONNULL_END
