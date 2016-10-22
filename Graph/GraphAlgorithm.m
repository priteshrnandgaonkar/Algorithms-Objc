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

+ (void)DFSWithAdjacencyMatrix:(NSArray<NSArray<NSNumber *> *> *)mat root:(NSUInteger)idx discoveryTime:(NSMutableArray<CCMutableNumber *> *)discoveryTime finishTime:(NSMutableArray<CCMutableNumber *> *)finishTime visited: (NSMutableArray<NSNumber *> *)visited time:(CCMutableNumber *)time stack:(Stack<NSNumber *> * _Nonnull)st {
    
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

@end
