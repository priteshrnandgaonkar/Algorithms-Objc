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
#import "GraphNode.h"
#import "GraphNodeData.h"
#import "PNQueue.h"

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

+ (NSInteger)longestPathFromSourceToDestinationIn:(NSArray<NSArray<NSNumber *> *> *)arr sourceRow:(NSUInteger)sr sourceColumn:(NSUInteger)sc destinationRow:(NSUInteger)dr destinationColumn:(NSUInteger)dc {
    
    NSMutableArray<NSMutableArray<NSNumber *> *> *history = @[@[].mutableCopy].mutableCopy;
    
    for (NSUInteger i = 0; i < arr.count; ++i) {
        [history addObject:@[].mutableCopy];
        for (NSUInteger j = 0; j < arr[i].count; ++j) {
            [history[i] addObject:@(NO)];
        }
    }
    
    return [[self class] longestPathFromSourceToDestinationIn:arr history:history sourceRow:sr sourceColumn:sc destinationRow:dr destinationColumn:dc];
}

+ (NSInteger)longestPathFromSourceToDestinationIn:(NSArray<NSArray<NSNumber *> *> *)arr history:(NSMutableArray<NSMutableArray<NSNumber *> *> *)history sourceRow:(NSUInteger)sr sourceColumn:(NSUInteger)sc destinationRow:(NSUInteger)dr destinationColumn:(NSUInteger)dc {
    
    if (sr >= arr.count || sc >= arr[0].count || !arr[sr][sc].boolValue) {
        return -1;
    }
    
    if (sr == dr && sc == dc) {
        return 1;
    }
    
    if (history[sr][sc].boolValue) {
        return 0;
    }
    
    history[sr][sc] = @(YES);
    
    NSInteger up = [[self class] longestPathFromSourceToDestinationIn:arr history:history sourceRow:sr - 1 sourceColumn:sc destinationRow:dr destinationColumn:dc];
    NSInteger down = [[self class] longestPathFromSourceToDestinationIn:arr history:history sourceRow:sr + 1 sourceColumn:sc destinationRow:dr destinationColumn:dc];
    NSInteger left = [[self class] longestPathFromSourceToDestinationIn:arr history:history sourceRow:sr sourceColumn:sc - 1 destinationRow:dr destinationColumn:dc];
    NSInteger right = [[self class] longestPathFromSourceToDestinationIn:arr history:history sourceRow:sr sourceColumn:sc + 1 destinationRow:dr destinationColumn:dc];
    
    NSUInteger maxValue = MAX(MAX(up, down), MAX(left, right));
    
    return maxValue + 1;
}

+ (NSInteger)shortestPathFromSourceToDestinationIn:(NSArray<NSArray<NSNumber *> *> *)arr sourceRow:(NSUInteger)sr sourceColumn:(NSUInteger)sc destinationRow:(NSUInteger)dr destinationColumn:(NSUInteger)dc {
    
    NSMutableArray<NSMutableArray<NSNumber *> *> *adjMat = [[self class] buildTreeFromMatrix:arr];
    NSUInteger rootIndex = (sr) * arr[0].count + sc;
    NSMutableArray<NSNumber *> *countArray = [[NSMutableArray alloc] initWithCapacity:arr.count * arr[0].count];
    for(NSUInteger i = 0; i < arr.count * arr[0].count; ++i) {
        countArray[i] = @(NSNotFound);
    }
    countArray[rootIndex] = @(0);
    PNQueue<NSNumber *> *queue = [[PNQueue alloc] init];
    [queue enqueue:@(rootIndex)];
    while(queue.count > 0) {
        NSNumber *num = queue.dequeue;
        
        for(NSUInteger j = 0; j < adjMat[num.integerValue].count; ++j) {
            if([adjMat[num.integerValue][j] isEqualToNumber:@(YES)] && j == ((dr) * arr[0].count + dc)) {
                return countArray[num.integerValue].integerValue + 1;
            }
            if([adjMat[num.integerValue][j] isEqualToNumber:@(YES)] && [countArray[j] isEqualToNumber:@(NSNotFound)]) {
                countArray[j] = @(countArray[num.integerValue].integerValue + 1);
                [queue enqueue:@(j)];
            }
        }
    }
    return NSNotFound;
}

+ (NSMutableArray<NSMutableArray<NSNumber *> *> *)buildTreeFromMatrix:(NSArray<NSArray<NSNumber *> *> *)arr {
    
    NSMutableArray<NSMutableArray<NSNumber *> *> *adjMat = [[NSMutableArray alloc] initWithCapacity:arr.count * arr[0].count];
    
    for(NSUInteger i = 0; i < arr.count * arr[0].count; ++i) {
        adjMat[i] = [[NSMutableArray alloc] initWithCapacity:arr.count * arr[0].count];
        for(NSUInteger j = 0; j < arr.count * arr[0].count; ++j) {
            adjMat[i][j] = @(NO);
        }
    }
    
    for(NSInteger i = 0; i < arr.count; ++i) {
        for(NSInteger j = 0; j < arr[i].count; ++j) {
            NSUInteger rowIndex = i * arr[i].count + j;
            if(i - 1 >= 0 && arr[i-1][j].boolValue) {
                NSUInteger t  = (i-1) * arr[i-1].count + j;
                adjMat[rowIndex][t] = @(YES);
            }
            if(i + 1 < arr.count && arr[i+1][j].boolValue) {
                NSUInteger t  = (i + 1) * arr[i+1].count + j;
                adjMat[rowIndex][t] = @(YES);
            }
            if(j - 1 >= 0 && arr[i][j-1].boolValue) {
                NSUInteger t  = (i) * arr[i].count + (j - 1);
                adjMat[rowIndex][t] = @(YES);
            }
            if(j + 1 < arr[i].count && arr[i][j+1].boolValue) {
                NSUInteger t  = (i) * arr[i].count + (j + 1);
                adjMat[rowIndex][t] = @(YES);
            }
        }
    }
    
    return adjMat;
}

+ (NSMutableArray<NSString *> *)arrayOfPossibleStringsFromString:(NSString *)str  withDict:(NSDictionary<NSString *, NSString *> *)dict {
    
    NSMutableArray<NSString *> *result = @[].mutableCopy;
   
    if(str.length == 0) {
        return result;
    }
    else if(str.length == 1) {
        return @[dict[str]].mutableCopy;
    }
    
    NSString *leftString = [str substringToIndex:1];
    NSString *subString = [str substringFromIndex:1];
    NSMutableArray<NSString *> *arr = nil;
    NSUInteger count = 1;
    
    while(dict[leftString]) {
        if(subString.length == 0 && dict[leftString]) {
            [result addObject:dict[leftString]];
            break;
        }
        
        arr = [[self class] arrayOfPossibleStringsFromString:subString withDict:dict];
        
        for (NSString *obj in arr) {
            [result addObject:[NSString stringWithFormat:@"%@%@", dict[leftString], obj]];
        }
        count = count + 1;
        leftString = [str substringToIndex:count];
        subString = [str substringFromIndex:count];
    }
    
    return result;
}

+ (NSUInteger)maxNumberOfCoinsFromMatrix:(NSArray<NSArray<NSNumber *> *> *)arr {
    return [[self class] maxNumberOfCoinsFromMatrix:arr sourceX:0 sourceY:0 history:@{}.mutableCopy];
}

+ (NSUInteger)maxNumberOfCoinsFromMatrix:(NSArray<NSArray<NSNumber *> *> *)arr sourceX:(NSUInteger)sourceX sourceY:(NSUInteger)sourceY history:(NSMutableDictionary<NSValue *,  NSNumber *> *)history {
    
    CGPoint point = CGPointMake(sourceX, sourceY);

    if (history[[NSValue valueWithCGPoint:point]]) {
        return history[[NSValue valueWithCGPoint:point]].integerValue;
    }
    
    NSUInteger max = 0;
    NSUInteger temp = 0;
    for (NSUInteger i = 1; sourceX + i < arr.count; ++i) {
        for (NSUInteger j = 1; sourceY + j < arr[i].count; ++j) {
            temp = [[self class] maxNumberOfCoinsFromMatrix:arr sourceX:sourceX + i sourceY:sourceY + j history:history];
            if (max < temp) {
                max = temp;
            }
        }
    }
    
    history[[NSValue valueWithCGPoint:point]] = @(max + arr[sourceX][sourceY].integerValue);
    return max + arr[sourceX][sourceY].integerValue;
}

+ (void)distanceFromGuardsAtOpenPlacesInMat:(NSMutableArray<NSMutableArray<NSString *> *> *)mat {
    
    for (NSUInteger i = 0; i < mat.count; ++i) {
        for (NSUInteger j = 0; j < mat[i].count; ++j) {
            if ([mat[i][j] isEqualToString:@"O"]) {
                [self distanceOfGuardsFromSrcRow: i srcColumn: j matrix: mat];
            }
        }
    }
}

+ (void)distanceOfGuardsFromSrcRow:(NSInteger)x srcColumn:(NSInteger)y matrix:(NSMutableArray<NSMutableArray<NSString *> *> *)mat {
    
    BOOL guardInNb = [self checkForGuardInNbOfRow:x column:y matrix:mat];
    
    if (guardInNb) {
        mat[x][y] = @(1).stringValue;
    }
    
    else {
        mat[x][y] = @(NSIntegerMax).stringValue; // trick to avoid the next open place to access the current one
        
        NSInteger up = NSIntegerMax;
        NSInteger down = NSIntegerMax;
        NSInteger left = NSIntegerMax;
        NSInteger right = NSIntegerMax;

        if ((x - 1) >= 0 && ![mat[x-1][y] isEqualToString:@"G"] && ![mat[x-1][y] isEqualToString:@"W"]) {
            if ([mat[x-1][y] isEqualToString:@"O"]) {
                [self distanceOfGuardsFromSrcRow:x-1 srcColumn:y matrix:mat];
            }
            up = mat[x-1][y].integerValue;
        }
        else if ((x + 1) < mat.count && ![mat[x+1][y] isEqualToString:@"G"] && ![mat[x+1][y] isEqualToString:@"W"]) {
            if ([mat[x+1][y] isEqualToString:@"O"]) {
                [self distanceOfGuardsFromSrcRow:x srcColumn:y+1 matrix:mat];
            }
            [self distanceOfGuardsFromSrcRow:x+1 srcColumn:y matrix:mat];
            down = mat[x+1][y].integerValue;
        }
        else if ((y - 1) >= 0 && ![mat[x][y-1] isEqualToString:@"G"] && ![mat[x][y-1] isEqualToString:@"W"]) {
            if ([mat[x][y-1] isEqualToString:@"O"]) {
                [self distanceOfGuardsFromSrcRow:x srcColumn:y+1 matrix:mat];
            }
            [self distanceOfGuardsFromSrcRow:x srcColumn:y-1 matrix:mat];
            left = mat[x][y-1].integerValue;
        }
        else if ((y + 1) < mat[x].count && ![mat[x][y+1] isEqualToString:@"G"] && ![mat[x][y+1] isEqualToString:@"W"]) {
            if ([mat[x][y+1] isEqualToString:@"O"]) {
                [self distanceOfGuardsFromSrcRow:x srcColumn:y+1 matrix:mat];
            }
            right = mat[x][y+1].integerValue;
        }
        
        mat[x][y] = @(1 + MIN(MIN(up, down), MIN(left, right))).stringValue;
    }
}

+ (BOOL)checkForGuardInNbOfRow:(NSInteger)x column:(NSInteger)y  matrix:(NSMutableArray<NSMutableArray<NSString *> *> *)mat {
    if ((x - 1) >= 0 && [mat[x-1][y] isEqualToString:@"G"]) {
        return YES;
    }
    else if ((x + 1) < mat.count && [mat[x+1][y] isEqualToString:@"G"]) {
        return YES;
    }
    else if ((y - 1) >= 0 && [mat[x][y-1] isEqualToString:@"G"]) {
        return YES;
    }
    else if ((y + 1) < mat[x].count && [mat[x][y+1] isEqualToString:@"G"]) {
        return YES;
    }
    else {
        return NO;
    }
}

+ (NSString *)lexicographicallyLargestString:(NSMutableString *)str withSwappingIndexes:(NSArray<PNInterval *> *)intervals {
    
    NSMutableArray<NSNumber *> *indexMutArray = @[].mutableCopy;
    NSMutableArray<NSString *> *mutValueArray = @[].mutableCopy;
    
    NSMutableSet *mutSet = [NSMutableSet set];
    NSMutableSet *mutValueSet = [NSMutableSet set];

    for (PNInterval *interval in intervals) {
        [mutSet addObject: interval.start];
        [mutSet addObject: interval.end];
        NSString *startString = [NSString stringWithFormat:@"%C", [str characterAtIndex: interval.start.integerValue]];
        NSString *endString = [NSString stringWithFormat:@"%C", [str characterAtIndex: interval.end.integerValue]];
        [mutValueSet addObject: startString];
        [mutValueSet addObject: endString];
    }
    
    indexMutArray = mutSet.allObjects.mutableCopy;
    mutValueArray = mutValueSet.allObjects.mutableCopy;
    
    [indexMutArray sortUsingComparator:^NSComparisonResult(NSNumber * _Nonnull obj1, NSNumber * _Nonnull obj2) {
        return [obj1 compare: obj2];
    }];
    
    [mutValueArray sortUsingComparator:^NSComparisonResult(NSString * _Nonnull obj1, NSString * _Nonnull obj2) {
        return [obj2 compare: obj1];
    }];
    
    NSUInteger t = 0;
    for (NSString *value in mutValueArray) {
        [str deleteCharactersInRange:NSMakeRange(indexMutArray[t].integerValue,1)];
        [str insertString:value atIndex: indexMutArray[t].integerValue];
        t = t + 1;
    }
    
    return [NSString stringWithString: str];
}

+ (NSUInteger)startingPointForMaximumNumOfAmazingNumberInArray:(NSArray<NSNumber *> *)array {
    
    NSMutableArray<NSNumber *> *maxAmazNum = @[].mutableCopy;
    
    for (NSNumber *num in array) {
        [maxAmazNum addObject:@(0)];
    }
    
    NSUInteger diff = 0;
    for (NSUInteger j = 0; j < array.count; ++j) {
        
        if ([array[j] compare:@(array.count - 1)] == NSOrderedDescending) {
            continue;
        }
        
        diff = 0;
        for (NSUInteger i = array[j].integerValue; i < array.count; ++i) {
            diff = (array.count - i) % array.count;
            maxAmazNum[(j+diff)%array.count] = @(maxAmazNum[(j+diff)%array.count].integerValue + 1);
        }
    }
    
    NSNumber *max = @(NSIntegerMin);
    NSInteger index = 0;
    for (NSUInteger i = 0; i < maxAmazNum.count; ++i) {
        if (max.integerValue < maxAmazNum[i].integerValue) {
            max = maxAmazNum[i];
            index = i;
        }
    }
    return index;
}

+ (NSUInteger)minimumLengthOfSubArray:(NSArray<NSNumber *> *)numbers withSumAtLeast:(NSUInteger)s {
    
    NSMutableArray<NSNumber *> *lengthOfSubarrays = @[].mutableCopy;
    
    NSUInteger leftIndex = 0;
    NSUInteger rightIndex = 0;
    NSInteger tempSum  = 0;
    tempSum = numbers[leftIndex].integerValue;

    while (leftIndex < numbers.count && rightIndex < numbers.count) {
//        if (leftIndex == rightIndex) {
//            if (tempSum >= s) {
//                [lengthOfSubarrays addObject:@(1)];
//                leftIndex++;
//            }
//            rightIndex++;
//            tempSum += numbers[rightIndex].integerValue;
//        }
//        
//        else {
//            if (tempSum >= s) {
//                [lengthOfSubarrays addObject:@(rightIndex - leftIndex + 1)];
//                tempSum
//                leftIndex++;
//            }
//            else {
//                rightIndex++;
//            }
//        }
        
        if (tempSum >= s) {
            
            if (leftIndex == rightIndex) {
                [lengthOfSubarrays addObject:@(1)];
                rightIndex++;
                leftIndex++;
                if (leftIndex < numbers.count) {
                    tempSum = numbers[leftIndex].integerValue;
                }
            }
            else {
                [lengthOfSubarrays addObject:@(rightIndex - leftIndex + 1)];
                tempSum -= numbers[leftIndex].integerValue;
                leftIndex++;
            }
        }
        else {
//            if (leftIndex == rightIndex) {
//                rightIndex++;
//                tempSum += numbers[rightIndex].integerValue;
//            }
//            else {
//                tempSum -= numbers[leftIndex].integerValue;
//                leftIndex++;
//            }
            rightIndex++;
            if (rightIndex < numbers.count) {
                tempSum += numbers[rightIndex].integerValue;
            }
        }
    }
    
    NSUInteger min = NSIntegerMax;
    for (NSNumber *num in lengthOfSubarrays) {
        if (min > num.integerValue) {
            min = num.integerValue;
        }
    }
    return min;
}

@end
