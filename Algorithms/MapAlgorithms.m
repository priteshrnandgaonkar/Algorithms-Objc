//
//  MapAlgorithms.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/14/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "MapAlgorithms.h"
#import "Stack.h"

@implementation MapAlgorithms

+ (void)depthFirstSearch:(Map *)map {
    
    Stack<MapNode *> *st = [[Stack alloc] init];
    [st push:map.root];
    
    while(st.count > 0) {
        MapNode *node = st.pop;
        Log(@"%@", node.value);
        
        if(node.right) {
            [st push:node.right];
        }
        if(node.left) {
            [st push:node.left];
        }
    }
}

+ (void)inorderTreeTraversalWithRoot:(MapNode *)root {
    if(root == nil)
        return
    [MapAlgorithms inorderTreeTraversalWithRoot:root.left];
    NSLog(@"%@", root.value);
    [MapAlgorithms inorderTreeTraversalWithRoot:root.right];
}

+ (MapNode *)binarySearchTreeWithRoot:(MapNode *)node number:(NSNumber *)num {
    
    if(node == nil) {
        return nil;
    }
    
    if([node.value isEqualToNumber:num]) {
        return node;
    }
    else if(num.integerValue < node.value.integerValue) {
        return [MapAlgorithms binarySearchTreeWithRoot:node.left number:num];
    }
    else {
        return [MapAlgorithms binarySearchTreeWithRoot:node.right number:num];
    }
}

+ (MapNode *)minimumForTreeRoot:(MapNode *)root {
    if(!root.left)
        return root;
    
    return [MapAlgorithms minimumForTreeRoot:root.left];
    
}

+ (MapNode *)minimumIterativelyForTreeRoot:(MapNode *)root {
    MapNode *node = root;
    while(node.left != nil) {
        node = root.left;
    }
    
    return node;
    
}

+ (MapNode *)maximumIterativelyForTreeRoot:(MapNode *)root {
    
    MapNode *node = root;
    while(node.right != nil) {
        node = root.right;
    }
    
    return node;
}

// Successor for node is the smallest node larger than the nodes value
+ (MapNode *)successorForNode:(MapNode *)node {
    if(node.right) {
        return [MapAlgorithms minimumIterativelyForTreeRoot:node];
    }
    
    MapNode *interNode = node;
    MapNode *parentNode = node.parent;
    if(!parentNode) {
        return nil;
    }
    
    while(parentNode != nil && parentNode.right == interNode) {
        interNode = parentNode;
        parentNode = interNode.parent;
    }
    
    return parentNode;
}

+ (MapNode *)predecessorForNode:(MapNode *)node {
    if(node.left) {
        return [MapAlgorithms maximumIterativelyForTreeRoot:node.left];
    }
    
    MapNode *interNode = node;
    MapNode *parent = node.parent;
    
    while (parent != nil && parent.left == interNode) {
        interNode = parent;
        parent = interNode.parent;
    }
    
    return parent;
}

+ (MapNode *)searchNumber:(NSNumber *)num root:(MapNode *)root{
    
    if([num isEqualToNumber:root.value])
        return root;
    if([num compare:root.value] == NSOrderedAscending) {
        return [MapAlgorithms searchNumber:num root:root.left];
    }
    else {
        return [MapAlgorithms searchNumber:num root:root.right];
    }
}

+ (void)insertNumber:(NSNumber *)num root:(MapNode *)root {

    MapNode *parentNode = nil;
    MapNode *currentNode = root;
    
    while(currentNode != nil){
        if([num compare:currentNode.value] == NSOrderedAscending) {
            parentNode = currentNode;
            currentNode = currentNode.left;
            
        }
        else {
            parentNode = currentNode;
            currentNode = currentNode.right;
        }
    }
    
    MapNode *nodeToBeInserted = [[MapNode alloc] initWithValue:num parent:parentNode left:nil right:nil];
    BOOL isNewNodeOnLeft = [parentNode.value compare:num] == NSOrderedAscending ? YES : NO;
    if(isNewNodeOnLeft) {
        parentNode.left = nodeToBeInserted;
    }
    else{
        parentNode.right = nodeToBeInserted;
    }
}

+ (void)deleteNumber:(NSNumber *)num root:(MapNode *)root {
  
    MapNode *node = [MapAlgorithms searchNumber:num root:root];
    if(!node.left && !node.right) {
        if(node.parent.left == node){
            node.parent.left = nil;
        }
        else {
            node.parent.right = nil;
        }
//        node.parent = nil;
    }
    
    if(node.left && !node.right) {
//        MapNode *nodeToBeInserted = [MapAlgorithms maximumIterativelyForTreeRoot:node.left];
//        nodeToBeInserted.parent.right = nil;
//        nodeToBeInserted.parent = nil;
//        nodeToBeInserted.parent = node.parent;
//        nodeToBeInserted.left = node.left;
//        nodeToBeInserted.right = node.right;
        
    }
    
    if(!node.left && node.right) {
        MapNode *nodeToBeInserted = [MapAlgorithms minimumIterativelyForTreeRoot:node.right];
        nodeToBeInserted.parent.left = nil;
        nodeToBeInserted.parent = nil;
        nodeToBeInserted.parent = node.parent;
        nodeToBeInserted.left = node.left;
        nodeToBeInserted.right = node.right;
    }
}

@end
