//
//  RBLTree.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/24/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBLNode.h"

@interface RBLTree : NSObject

@property(strong, nonatomic, readonly)RBLNode *root;

- (instancetype)initWithValue:(NSNumber *)num;
- (void)insertNumber:(NSNumber *)number;
- (RBLNode *)predecessorOfNode:(RBLNode *)node;
- (RBLNode *)searchNumber:(NSNumber *)number;
- (void)deleteNumber:(RBLNode *)node;
- (void)inorderTreeTraversal;

@end
