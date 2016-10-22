//
//  GraphAlgorithm.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/22/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "GraphAlgorithm.h"
#import "CCMutableNumber.h"
#import "Stack.h"

@implementation GraphAlgorithm

#pragma mark Graph traversal in each direction

+ (void)doubleGraphTraversalWithAdjacencyMatrix:(NSArray<NSArray<NSNumber *> *> *)mat root:(NSUInteger)i {
    
    NSMutableArray<NSNumber *> *visited = @[].mutableCopy;
    NSMutableArray<NSNumber *> *depth = @[].mutableCopy;
    
    for(NSUInteger j = 0; j < mat.count; ++j) {
        visited[j] = @(NO);
        depth[j] = @(0);
    }
    
    [[self class] doubleGraphTraversalWithAdjacencyMatrix:mat root:i visited:visited depth:depth];
}

+ (void)doubleGraphTraversalWithAdjacencyMatrix:(NSArray<NSArray<NSNumber *> *> *)mat root:(NSUInteger)i visited:(NSMutableArray<NSNumber *> *)visited depth:(NSMutableArray<NSNumber *> *)depth {
    
    Log(@"%lu", i);
    visited[i] = @(YES);
    
    for(NSUInteger idx = 0; idx < mat.count; ++idx) {
        
        if([mat[i][idx] isEqualToNumber:@(YES)] && !(visited[idx].boolValue)) {
            depth[idx] = @(depth[i].integerValue + 1);
            
            [[self class] doubleGraphTraversalWithAdjacencyMatrix:mat root:idx visited:visited depth:depth];
            Log(@"%lu", i);
        }
        else if(depth[idx] > depth[i] && [mat[i][idx] isEqualToNumber:@(YES)]) {
            Log(@"%lu", idx);
            Log(@"%lu", i);
        }
    }
}

#pragma mark DFS

+ (void)DFSWithAdjacencyMatrix:(NSArray<NSArray<NSNumber *> *> *)mat {
    NSMutableArray<CCMutableNumber *> *discoveryTime = @[].mutableCopy;
    NSMutableArray<CCMutableNumber *> *finishTime = @[].mutableCopy;
    NSMutableArray<NSNumber *> *visited = @[].mutableCopy;
    
    for(NSUInteger i = 0; i < mat.count; ++i) {
        visited[i] = @(NO);
        discoveryTime[i] = [[CCMutableNumber alloc] initWithNumber:@(NSNotFound)];
        finishTime[i] = [[CCMutableNumber alloc] initWithNumber:@(NSNotFound)];
    }
    
    [[self class] DFSWithAdjacencyMatrix:mat root:0 discoveryTime:discoveryTime finishTime:finishTime visited: visited time:[[CCMutableNumber alloc] initWithNumber:@(0)]];
    Log(@"DISCOVERY TIME : %@", discoveryTime);
    Log(@"FINISH TIME : %@", finishTime);

}

+ (void)DFSWithAdjacencyMatrix:(NSArray<NSArray<NSNumber *> *> *)mat root:(NSUInteger)idx discoveryTime:(NSMutableArray<CCMutableNumber *> *)discoveryTime finishTime:(NSMutableArray<CCMutableNumber *> *)finishTime visited: (NSMutableArray<NSNumber *> *)visited time:(CCMutableNumber *)time {
    
    visited[idx] = @(YES);
    time.num = @(time.num.integerValue + 1);
    discoveryTime[idx] = time.copy;
    
    Log(@"%lu", idx);
    for(NSUInteger i = 0; i < mat[idx].count; ++i) {
        if([mat[idx][i] isEqualToNumber:@(YES)] && !visited[i].boolValue) {
            [[self class] DFSWithAdjacencyMatrix:mat root:i discoveryTime:discoveryTime finishTime:finishTime visited:visited time:time];
        }
    }
    time.num = @(time.num.integerValue + 1);
    finishTime[idx] = time.copy;
}

#pragma markTopological Sort

+ (void)topologicalSortWithAdjacencyMatrix:(NSArray<NSArray<NSNumber *> *> *)mat {
    
    NSMutableArray<CCMutableNumber *> *discoveryTime = @[].mutableCopy;
    NSMutableArray<CCMutableNumber *> *finishTime = @[].mutableCopy;
    NSMutableArray<NSNumber *> *visited = @[].mutableCopy;
    Stack<NSNumber *> *st = [[Stack alloc] init];
    
    for(NSUInteger i = 0; i < mat.count; ++i) {
        visited[i] = @(NO);
        discoveryTime[i] = [[CCMutableNumber alloc] initWithNumber:@(NSNotFound)];
        finishTime[i] = [[CCMutableNumber alloc] initWithNumber:@(NSNotFound)];
    }
    
    [[self class] DFSWithAdjacencyMatrix:mat root:0 discoveryTime:discoveryTime finishTime:finishTime visited: visited time:[[CCMutableNumber alloc] initWithNumber:@(0)] stack:st];
    
    [st print];
}

+ (void)DFSWithAdjacencyMatrix:(NSArray<NSArray<NSNumber *> *> *)mat root:(NSUInteger)idx discoveryTime:(NSMutableArray<CCMutableNumber *> *)discoveryTime finishTime:(NSMutableArray<CCMutableNumber *> *)finishTime visited: (NSMutableArray<NSNumber *> *)visited time:(CCMutableNumber *)time stack:(Stack<NSNumber *> *)st {
    
    visited[idx] = @(YES);
    time.num = @(time.num.integerValue + 1);
    discoveryTime[idx] = time.copy;
    
    for(NSUInteger i = 0; i < mat[idx].count; ++i) {
        if([mat[idx][i] isEqualToNumber:@(YES)] && !visited[i].boolValue) {
            [[self class] DFSWithAdjacencyMatrix:mat root:i discoveryTime:discoveryTime finishTime:finishTime visited:visited time:time stack:st];
        }
    }
    time.num = @(time.num.integerValue + 1);
    finishTime[idx] = time.copy;
    [st push:@(idx)];
}

#pragma mark Number Of Paths From Source to Destination

+ (NSUInteger)numberOfPathsFromSource:(NSUInteger)source destination:(NSUInteger)destination adjacencyMatrix:(NSArray<NSArray<NSNumber *> *> *)mat {
    NSMutableArray<NSNumber *> *countArray = @[].mutableCopy;
    NSMutableArray<NSNumber *> *visitedArray = @[].mutableCopy;

    for(NSUInteger i = 0; i < mat.count; ++i) {
        countArray[i] = @(0);
        visitedArray[i] = @(NO);
    }
    
    [[self class] numberOfPathsFromSource:source destination:destination adjacencyMatrix:mat count:countArray visited:visitedArray];
    return countArray[source].integerValue;
}

+ (void)numberOfPathsFromSource:(NSUInteger)source destination:(NSUInteger)destination adjacencyMatrix:(NSArray<NSArray<NSNumber *> *> *)mat count:(NSMutableArray<NSNumber *> *)countArray visited:(NSMutableArray<NSNumber *> *)visitedArray {

    NSUInteger count = countArray[source].integerValue;
    visitedArray[source] = @(YES);
    
    for(NSUInteger i = 0; i < mat[source].count; ++i) {
        
        if(i == destination && [mat[source][destination] isEqualToNumber:@(YES)]) {

            count += 1;
        }
        else if([mat[source][i] isEqualToNumber:@(YES)] && [countArray[i] isEqualToNumber:@(0)] && !visitedArray[i].boolValue) {
            [[self class] numberOfPathsFromSource:i destination:destination adjacencyMatrix:mat count:countArray visited:visitedArray];
            count += countArray[i].integerValue;
        }
        else if([mat[source][i] isEqualToNumber:@(YES)] && ![countArray[i] isEqualToNumber:@(NSNotFound)] && visitedArray[i].boolValue) {
          count += countArray[i].integerValue;
        }
    }
    
    countArray[source] = @(count);
}

#pragma mark Does Undirected Graph Has Loop

+ (BOOL)doesUndirectedGraphHasLoopMatrix:(NSArray<NSArray<NSNumber *> *> *)mat {
    NSMutableArray<NSNumber *> *visitedArray = @[].mutableCopy;
    NSMutableArray<NSNumber *> *predecessorArray = @[].mutableCopy;

    
    for (NSUInteger i = 0; i < mat.count; ++i) {
        visitedArray[i] = @(NO);
        predecessorArray[i] = @(NSNotFound);
    }
    
    BOOL foundLoop = NO;
    for(NSUInteger i = 0; i < mat.count && !foundLoop; ++i) {
        if(!visitedArray[i].boolValue) {
            
            foundLoop = [[self class] doesGraphHasLoopWithMatrix:mat visitedArray:visitedArray root:0 predecssorArray:predecessorArray];
        }
    }
    return foundLoop;
}

+ (BOOL)doesGraphHasLoopWithMatrix:(NSArray<NSArray<NSNumber *> *> *)mat visitedArray:(NSMutableArray<NSNumber *> *)visitedArray root:(NSUInteger)idx predecssorArray:(NSMutableArray<NSNumber *> *)predecessorArray {
    
    visitedArray[idx] = @(YES);
    BOOL foundLoop = NO;
    
    for(NSUInteger i = 0; i < mat[idx].count; ++i) {
        
        if([mat[idx][i] isEqualToNumber:@(YES)] && visitedArray[i].boolValue && ![predecessorArray[idx] isEqualToNumber:@(i)]) {
            foundLoop = YES;
            break;
        }
        else if([mat[idx][i] isEqualToNumber:@(YES)] && !visitedArray[i].boolValue){
            
            predecessorArray[i] = @(idx);
            foundLoop = [[self class] doesGraphHasLoopWithMatrix:mat visitedArray:visitedArray root:i predecssorArray:predecessorArray];
            if(foundLoop) {
                break;
            }
        }
    }
    
    return foundLoop;
}

#pragma mark Strongly Connected Component
+ (void)stronglyConnectedComponent:(NSArray<NSArray<NSNumber *> *> *)mat {
    
    NSMutableArray<NSNumber *> *visited = @[].mutableCopy;
    NSMutableArray<CCMutableNumber *> *finishTime = @[].mutableCopy;
    
    for(NSUInteger i = 0; i < mat.count; ++i){
        visited[i] = @(NO);
        finishTime[i] = [[CCMutableNumber alloc] initWithNumber:@(NSNotFound)];
    }

    [[self class] computeFinishTimeForAdjacencyMatrix:mat visited:visited finishTime:finishTime];
    NSMutableArray<NSMutableArray<NSNumber *> *> *mut = [[self class] transposeOfAnArray: mat];
    [[self class] printDFSInDescendingOrderOf:finishTime matrix:mut];
}

+ (void)printDFSInDescendingOrderOf:(NSMutableArray<CCMutableNumber *> *)finishTime matrix:(NSArray<NSArray<NSNumber *> *> *)mat {
    
    [finishTime sortUsingComparator:^NSComparisonResult(CCMutableNumber *  _Nonnull obj1, CCMutableNumber *  _Nonnull obj2) {
       
        return [obj1.num compare:obj2.num];
    }];
    
    NSMutableArray<NSNumber *> *visited = @[].mutableCopy;
    for(NSUInteger i = 0; i < mat.count; ++i){
        visited[i] = @(NO);
    }
    NSUInteger count = 0;
    for(NSUInteger i = 0; i < finishTime.count; ++i) {
        if(!visited[i].boolValue) {
            Log(@"Strongly Connected component No %lu", count);

            [[self class] DFSWithAdjacencyMatrix:mat root:i visited:visited];
            count += 1;
        }
    }
    
}
+ (void)DFSWithAdjacencyMatrix:(NSArray<NSArray<NSNumber *> *> *)mat root:(NSUInteger)idx visited: (NSMutableArray<NSNumber *> *)visited {
    
    visited[idx] = @(YES);
    Log(@"%lu", idx);
    
    for(NSUInteger i = 0; i < mat[idx].count; ++i) {
        if([mat[idx][i] isEqualToNumber:@(YES)] && !visited[i].boolValue) {
            [[self class] DFSWithAdjacencyMatrix:mat root:i visited:visited];
        }
    }

}

+ (NSUInteger)maximumInArray:(NSArray<NSNumber *> *)arr {
    NSUInteger max = NSIntegerMin;
    NSUInteger idx = NSNotFound;
    
    for(NSUInteger i = 0; i < arr.count; ++i) {
        if(max < arr[i].integerValue) {
            max = arr[i].integerValue;
            idx = i;
        }
    }
    
    return idx;
}

+ (void)computeFinishTimeForAdjacencyMatrix:(NSArray<NSArray<NSNumber *> *> *)mat visited:(NSMutableArray<NSNumber *> *)visited finishTime:(NSMutableArray<CCMutableNumber *> *)finishTime {
    
    CCMutableNumber *time = [[CCMutableNumber alloc] initWithNumber:@(1)];
    for(NSUInteger i = 0; i < mat.count; ++i) {
        if(!visited[i].boolValue) {
            [[self class] computeFinishTimeForAdjacencyMatrix:mat visited:visited finishTime:finishTime root:i time: time];
        }
    }
}

+ (void)computeFinishTimeForAdjacencyMatrix:(NSArray<NSArray<NSNumber *> *> *)mat visited:(NSMutableArray<NSNumber *> *)visited finishTime:(NSMutableArray<CCMutableNumber *> *)finishTime root:(NSUInteger)idx time:(CCMutableNumber *)time {
    
    visited[idx] = @(YES);
    Log(@"%lu", idx);
    
    for(NSUInteger i = 0; i < mat.count; ++i) {
        if([mat[idx][i] isEqualToNumber:@(YES)] && !visited[i].boolValue){
            time.num = @(time.num.integerValue + 1);
            [[self class] computeFinishTimeForAdjacencyMatrix:mat visited:visited finishTime:finishTime root:i time:time];
        }
    }
    
    time.num = @(time.num.integerValue + 1);
    finishTime[idx] = time.copy;
}

+ (NSMutableArray<NSMutableArray<NSNumber *> *> *)transposeOfAnArray:(NSArray<NSArray<NSNumber *> *> *)arr {
    NSMutableArray<NSMutableArray<NSNumber *> *> *mut = @[].mutableCopy;
    
    for(NSUInteger i = 0; i < arr.count; ++i) {
        mut[i] = arr[i].mutableCopy;
    }
    
    for(NSUInteger i = 0; i < arr.count; ++i) {
        for(NSUInteger j = 0; j < arr[i].count; ++j) {
            mut[j][i] = arr[i][j];
        }
    }
    
    return mut;
}

@end
