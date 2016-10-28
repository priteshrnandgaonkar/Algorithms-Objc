//
//  Map.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/16/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "Map.h"

@interface Map()

@property(nonatomic, strong)MapNode *root;

@end

@implementation Map

- (instancetype)init {
    self = [super init];
    if(self) {
        _root = nil;
    }
    return self;
}

- (instancetype)initWithRoot:(MapNode *)root {
    self = [super init];
    if(self) {
        self.root = root;
    }
    return self;
}

- (void)inorderTreeTraversal {
    [self inorderTreeTraversalWithRoot:self.root];
}

- (void)inorderTreeTraversalWithRoot:(MapNode *)root {
    if(root == nil) {
        return;
    }
    [self inorderTreeTraversalWithRoot:root.left];
    Log(@"%lu", root.value.integerValue);
    [self inorderTreeTraversalWithRoot:root.right];
}

- (MapNode *)binarySearchNumber:(NSNumber *)num {

    MapNode *currentNode = self.root;
    while(currentNode != nil) {
        if([currentNode.value isEqualToNumber:num]){
            break;
        }
        
        if([currentNode.value compare:num] == NSOrderedAscending) {
            currentNode = currentNode.right;
        }
        else {
            currentNode = currentNode.left;
        }
    }
    
    return currentNode;
}

- (void)insertNumber:(NSNumber *)num {
    MapNode *node = [[MapNode alloc] initWithValue:num parent:nil left:nil right:nil];
    
    if(!self.root) {
        self.root = node;
        return;
    }
    
    MapNode *currentNode = self.root;

    if(!currentNode){
        self.root = node;
    }
    MapNode *temp = nil;
    while(currentNode) {
        if([currentNode.value compare:num] == NSOrderedDescending){
            temp = currentNode.left;
        }
        else {
            temp = currentNode.right;
        }
        
        if(!temp) {
            break;
        }
        else {
            currentNode = temp;
        }
    }
    
    if([currentNode.value compare:num] == NSOrderedDescending) {
        currentNode.left = node;
        node.parent = currentNode;
    }
    else{
        currentNode.right = node;
        node.parent = currentNode;
    }
}

- (void)insertNode:(MapNode *)node {
    
    if(!self.root) {
        self.root = node;
        return;
    }
    
    MapNode *currentNode = self.root;
    
    MapNode *temp = nil;
    while(currentNode) {
        if([currentNode.value compare:node.value] == NSOrderedAscending){
            temp = currentNode.right;
        }
        else {
            temp = currentNode.left;
        }
        
        if(!temp) {
            break;
        }
        else {
            currentNode = temp;
        }
    }
    
    if([currentNode.value compare:node.value] == NSOrderedAscending) {
        currentNode.right = node;
        node.parent = currentNode;
    }
    else{
        currentNode.left = node;
        node.parent = currentNode;
    }
}

- (MapNode *)minimumFromNode:(MapNode *)node {
    MapNode *currentNode = node;
    
    while(currentNode) {
        if(currentNode.left){
            currentNode = currentNode.left;
        }
        else {
            break;
        }
    }
    return currentNode;
}

- (MapNode *)minimum {
   return [self minimumFromNode:self.root];
}

- (MapNode *)maximumFromNode:(MapNode *)node {
    MapNode *currentNode = node;
    
    while(currentNode){
        if(currentNode.right){
            currentNode = currentNode.right;
        }
        else {
            break;
        }
    }
    
    return currentNode;
}

- (MapNode *)maximum {
    return [self maximumFromNode:self.root];
}

- (MapNode *)predecessorForNode:(MapNode *)node {
    if(node.left){
        return [self maximumFromNode:node.left];
    }
    else {
        MapNode *currentNode = node;
        while(currentNode.parent.left == currentNode){
            currentNode = currentNode.parent;
        }
        return currentNode.parent;
    }
}
- (MapNode *)successorForNode:(MapNode *)node {
    if(node.right) {
        return [self minimumFromNode:node.right];
    }
    else {
        MapNode *currentNode = node;
        while(currentNode.parent.right == currentNode){
            currentNode = currentNode.parent;
        }
        return currentNode.parent;
    }
}

- (void)deleteNode:(MapNode *)node {
    
    if(!node)
        return;
    
    BOOL isNodeLeftChild = node.parent.left == node;

    if(!node.left && !node.right){
        if(isNodeLeftChild){
            node.parent.left = nil;
        }
        else {
            node.parent.right = nil;
        }
    }
    
    else if(!node.left && node.right) {
        if(isNodeLeftChild) {
            node.parent.left = node.right;
            node.right.parent = node.parent;
        }
        else{
            node.parent.right = node.right;
            node.right.parent = node.parent;
        }
    }
    else if(node.left && !node.right){
        if(isNodeLeftChild) {
            node.parent.left = node.left;
            node.left.parent = node.parent;
        }
        else{
            node.parent.right = node.left;
            node.left.parent = node.parent;
        }
    }
    else {
        
        MapNode *nodeToBeReplaced = [self predecessorForNode:node];
        if(nodeToBeReplaced.left) {
            BOOL isLeft = nodeToBeReplaced.parent.left == nodeToBeReplaced;
            if(isLeft) {
                nodeToBeReplaced.parent.left = nodeToBeReplaced.left;
            }
            else{
                nodeToBeReplaced.parent.right = nodeToBeReplaced.left;
            }
            nodeToBeReplaced.left.parent = nodeToBeReplaced.parent;
        }
        
        nodeToBeReplaced.right = node.right;
        nodeToBeReplaced.parent = node.parent;
        nodeToBeReplaced.left = node.left;
        nodeToBeReplaced.left.parent = nodeToBeReplaced;
        nodeToBeReplaced.right.parent = nodeToBeReplaced;
        
        if(self.root == node) {
            self.root = nodeToBeReplaced;
        }
        if(isNodeLeftChild) {
            node.parent.left = nodeToBeReplaced;
        }
        else {
            node.parent.right = nodeToBeReplaced;
        }
    }
}

@end
