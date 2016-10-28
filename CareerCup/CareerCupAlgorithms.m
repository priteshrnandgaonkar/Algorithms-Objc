//
//  CareerCupAlgorithms.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/8/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "CareerCupAlgorithms.h"
#import "Stack.h"
#import "MapNode.h"

@implementation CareerCupAlgorithms

+ (NSUInteger)largestOverlappingLengthAmongstTheGivenIntervals:(NSArray<NSArray<NSNumber *> *> *)arrayOfIntervals {
    Map *map = [[self class] buildTree:arrayOfIntervals];
    
    MapNode *currentNode = map.root;
    NSUInteger result = [[self class] rightOverlappingIntervalLength:currentNode];
    
    NSUInteger parentSpan = 0;
    
    NSUInteger valueToDeduct = 0;
    //Evaluate left branch
    while(currentNode.left) {
        valueToDeduct = 0;
        parentSpan = ((NSNumber *)currentNode.data).integerValue;
        result += [[self class] rightOverlappingIntervalLength:currentNode.left];
        valueToDeduct += [[self class] rightOverlapLengthGreaterThan:currentNode.value.integerValue - parentSpan fromNode: currentNode.left];
        result -= valueToDeduct;
        
        currentNode = currentNode.left;
    }
    return result;
}

+ (NSUInteger)rightOverlappingIntervalLength:(MapNode *)node {
    
    NSUInteger result = ((NSNumber *)node.data).integerValue;
    MapNode *currentNode = node;
    
    NSUInteger currentNodesEnd = 0;
    NSUInteger currentNodesSpan = 0;

    NSUInteger rightNodesEnd = 0;
    NSUInteger rightNodesSpan = 0;

    while(currentNode.right) {
        
        currentNodesEnd = currentNode.value.integerValue;
        currentNodesSpan = ((NSNumber *)currentNode.data).integerValue;
        
        rightNodesEnd = currentNode.right.value.integerValue;
        rightNodesSpan = ((NSNumber *)currentNode.right.data).integerValue;

        if (rightNodesEnd - rightNodesSpan > currentNodesEnd) {
            //Disjoint interval
            result += rightNodesSpan;
        }
        else if (rightNodesSpan - rightNodesEnd > currentNodesEnd - currentNodesSpan) {
            //Right intervals start is between the current interval
            result += rightNodesEnd - currentNodesEnd;
        }
        else if (rightNodesSpan - rightNodesEnd < currentNodesEnd - currentNodesSpan) {
            //Right interval is superset of the current interval
            result += rightNodesEnd - currentNodesEnd;
            result += currentNodesEnd - currentNodesSpan - (rightNodesSpan - rightNodesEnd);
        }
        
        currentNode = currentNode.right;
    }
    return result;
}

+ (NSUInteger)rightOverlapLengthGreaterThan:(NSUInteger)num fromNode:(MapNode *)node {
    
    NSUInteger result = 0;
    MapNode *currentNode = node;
    
    NSUInteger currentNodesEnd = 0;
    NSUInteger currentNodesSpan = 0;
    
    while(currentNode) {
        
        currentNodesEnd = currentNode.value.integerValue;
        currentNodesSpan = ((NSNumber *)currentNode.data).integerValue;

        if(currentNodesEnd - currentNodesSpan > num) {
            result += currentNodesSpan;
        }
        else if (currentNodesEnd > num && currentNodesEnd - currentNodesSpan <= num){
            result += currentNodesEnd - num;
        }
        currentNode = currentNode.right;
    }
    return result;
}


+ (Map *)buildTree:(NSArray<NSArray<NSNumber *> *> *)arrayOfIntervals {
    Map *map = [[Map alloc] init];
    MapNode *node = nil;
    for(NSArray<NSNumber *> *interval in arrayOfIntervals) {
        
        NSUInteger lengthOfInterval = interval[1].integerValue - interval[0].integerValue;
        node = [[MapNode alloc] initWithValue:interval[1] parent:nil left:nil right:nil data:@(lengthOfInterval)];
        [map insertNode:node];
    }
    return map;
}

+ (void)squareAndSortArray:(NSMutableArray<NSNumber *> *)array {
    
    __block NSUInteger negativeEndingIndex = NSNotFound;
    
    [array enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj.integerValue > 0){
            return;
        }
        negativeEndingIndex = idx;
    }];
    
    negativeEndingIndex = negativeEndingIndex == NSNotFound ? 0 : negativeEndingIndex;
    
    for(NSUInteger i = 0; i < array.count; ++i) {
        NSNumber *num = array[i];
        array[i] = @(num.integerValue * num.integerValue);
    }
    
    NSUInteger leftIndex = 0;
    NSUInteger rightIndex = negativeEndingIndex;
    
    while(leftIndex < rightIndex) {
        NSNumber *left = array[leftIndex];
        array[leftIndex] = array[rightIndex];
        array[rightIndex] = left;
        leftIndex++;
        rightIndex--;
    }
    
    leftIndex = 0;
    rightIndex = negativeEndingIndex + 1;
    while(leftIndex < rightIndex && leftIndex < array.count && rightIndex < array.count) {
        if(array[leftIndex] > array[rightIndex]) {
            NSNumber *right = array[rightIndex];
            [array insertObject:right atIndex:leftIndex];
            [array removeObjectAtIndex:rightIndex + 1];
            rightIndex++;
        }
        leftIndex++;
    }
}

+ (BOOL)doesThereExistSubsequenceInArray:(NSArray<NSNumber *> *)array withSum:(NSInteger)sum {
    NSUInteger leftIndex = 0;
    NSUInteger rightIndex = 0;
    while(leftIndex <= rightIndex && leftIndex < array.count && rightIndex < array.count && sum != 0) {
        Log(@"Left = %lu, Right = %lu, sum = %lu", leftIndex, rightIndex, sum);
        if(array[rightIndex].integerValue <= sum && leftIndex <= rightIndex){
            sum = sum - array[rightIndex].integerValue;
            rightIndex++;
        }
        else if(array[rightIndex].integerValue > sum && leftIndex < rightIndex){
            sum = sum + array[leftIndex].integerValue;
            leftIndex++;
        }
        else if(array[rightIndex].integerValue > sum && leftIndex == rightIndex) {
            leftIndex++;
            rightIndex++;
        }
    }
    
    return sum == 0;
}

+ (NSDictionary<NSNumber *, MapNode *> *)firstNonMatchingLeafPairFromtree:(Map *)treeOne treeTwo:(Map *)treeTwo {
    
    Stack<MapNode *> *stackOne = [[Stack alloc] initWithObject:treeOne.root];
    Stack<MapNode *> *stackTwo = [[Stack alloc] initWithObject:treeTwo.root];
    
    MapNode *leafOne = [[self class] leafForTreeWithStack:stackOne];
    MapNode *leafTwo = [[self class] leafForTreeWithStack:stackTwo];
    
    while(leafOne && leafTwo) {
        if (![leafOne.value isEqualToNumber:leafTwo.value]) {
            return @{@(1): leafOne, @(2): leafTwo};
        }
        else {
            leafOne = [[self class] leafForTreeWithStack:stackOne];
            leafTwo = [[self class] leafForTreeWithStack:stackTwo];
        }
    }
    return nil;
}

+ (MapNode *)leafForTreeWithStack:(Stack *)stack {
    
    MapNode *node = nil;
    while (stack.count > 0) {
        node = stack.pop;
        if (!node.left && !node.right) {
            return node;
        }
        if (node.right) {
            [stack push:node.right];
        }
        if (node.left) {
            [stack push:node.left];
        }
    }
    
    return nil;
}

@end
