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
- (void)inorderTreeTraversal;

@end
