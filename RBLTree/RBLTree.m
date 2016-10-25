//
//  RBLTree.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/24/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "RBLTree.h"
#import "Stack.h"

@interface RBLTree()

@property(strong, nonatomic)RBLNode *root;
@property(strong, nonatomic)RBLNode *sentinelParent;

@end

@implementation RBLTree

- (instancetype)initWithValue:(NSNumber *)num {
    self = [super init];
    RBLNode *node = [[RBLNode alloc] initWithValue:num parent:nil left:nil right:nil color:RBLNodeColorBlack];
    
    RBLNode *sentinel = [[RBLNode alloc] initWithValue:@(NSNotFound) parent:node left:nil right:nil color:RBLNodeColorBlack];
    node.left = sentinel;
    node.right = sentinel.copy;
    

    
    if(self){
        _root = node;
        _sentinelParent = sentinel.copy;
        _sentinelParent.right = node;
        node.parent = _sentinelParent;
    }
    return self;
}

- (void)insertNumber:(NSNumber *)number {
    
    RBLNode *nodeToInsert = [[RBLNode alloc] initWithValue:number parent:nil left:nil right:nil color:RBLNodeColorRed];
    RBLNode *sentinel = [[RBLNode alloc] initWithValue:@(NSNotFound) parent:nodeToInsert left:nil right:nil color:RBLNodeColorBlack];
    nodeToInsert.left = sentinel;
    nodeToInsert.right = sentinel.copy;
    
    RBLNode *sentinelParent = sentinel.copy;
    sentinelParent.right = nodeToInsert;
    nodeToInsert.parent = sentinelParent;
    
    RBLNode *currentNode = self.root;
    RBLNode *temp = nil;
    while(currentNode){
        if([currentNode.value compare:number] == NSOrderedAscending) {
            temp = currentNode.right;
        }
        else {
            temp = currentNode.left;
        }
        if([temp.value isEqualToNumber:@(NSNotFound)]) {
            break;
        }
        else {
            currentNode = temp;
        }
    }
    
    if([currentNode.value compare:number] == NSOrderedAscending) {
        currentNode.right = nodeToInsert;
    }
    else {
        currentNode.left = nodeToInsert;
    }
    nodeToInsert.parent = currentNode;

    [self RBLInsertFixupAtNode:nodeToInsert];
}

- (void)RBLInsertFixupAtNode:(RBLNode *)node {
 
    while(node.parent.color == RBLNodeColorRed) {
        
        if(node.parent.parent.right == node.parent) {
            //Right Path
            if(node.parent.parent.left.color == RBLNodeColorRed) {
                node.parent.color = RBLNodeColorBlack;
                node.parent.parent.color = RBLNodeColorRed;
                node.parent.parent.left.color = RBLNodeColorBlack;
            }
            else {
                if(node.parent.left == node) {
                    node = node.parent;
                    [self rightRotateAroundNode:node];
                }
                node.parent.color = RBLNodeColorBlack;
                node.parent.parent.color = RBLNodeColorRed;
                [self leftRotateAroundNode:node.parent.parent];
            }
        }
        else {
            //Left
            if(node.parent.parent.right.color == RBLNodeColorRed) {
                node.parent.color = RBLNodeColorBlack;
                node.parent.parent.color = RBLNodeColorRed;
                node.parent.parent.right.color = RBLNodeColorBlack;
            }
            else {
                if(node.parent.right == node) {
                    node = node.parent;
                    [self leftRotateAroundNode:node];
                }
                node.parent.color = RBLNodeColorBlack;
                node.parent.parent.color = RBLNodeColorRed;
                [self rightRotateAroundNode:node.parent.parent];
            }
        }
    }
    self.root.color = RBLNodeColorBlack;
}

- (void)inorderTreeTraversal {
    [self inorderTreeTraversalFromNode:self.root];
}

- (void)inorderTreeTraversalFromNode:(RBLNode *)node {
    
    if(!node) {
        return;
    }
    
    [self inorderTreeTraversalFromNode:node.left];
    
    Log(@"%@ - %@", node.value, node.color == RBLNodeColorBlack ? @"B" : @"R");
    
    [self inorderTreeTraversalFromNode:node.right];
}

- (void)leftRotateAroundNode:(RBLNode *)node {

    node.right.parent = node.parent;
    if(node.parent.right == node) {
        node.parent.right = node.right;
    }
    else {
        node.parent.left = node.right;
    }
    node.parent = node.right;
    node.right = node.right.left;
    node.parent.left = node;
    
    if([node.parent.parent.value isEqualToNumber:@(NSNotFound)]) {
        self.root = node.parent;
    }
}

- (void)rightRotateAroundNode:(RBLNode *)node {
    
    node.left.parent = node.parent;
    if(node.parent.right == node) {
        node.parent.right = node.left;
    }
    else {
        node.parent.left = node.left;
    }
    node.parent = node.left;
    node.left = node.left.right;
    node.parent.right = node;
    if([node.parent.parent.value isEqualToNumber:@(NSNotFound)]) {
        self.root = node.parent;
    }
}

@end
