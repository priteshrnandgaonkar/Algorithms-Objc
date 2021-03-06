//
//  ViewController.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 9/30/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "ViewController.h"
#import "Sorting.h"
#import "Heap.h"
#import "PriorityQueue.h"
#import "Arrays-Algorithms.h"
#import "CareerCupAlgorithms.h"
#import "Map.h"
#import "GraphAlgorithm.h"
#import "RBLTree.h"
#import "MapAlgorithms.h"
#import "PNTrie.h"
#import "DPAlgo.h"
#import "GraphEdge.h"
#import "GeneralAlgorithms.h"
#import "DispatchAfterWithCancel.h"

@interface ViewController ()

@property (copy, nonatomic) void(^testBlock)();
@property (strong, nonatomic) NSString *viewControllerString;
@property (strong, nonatomic) dispatch_after_cancel_t cancellableBlock;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    dispatch_after_cancel_t block = dispatch_after_cancellable(3, ^{
        NSLog(@"Hello world!");
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"Canceling block early");
        cancel_block(block);
    });
    
    self.viewControllerString = @"My string";
    NSMutableString *tString = @"local String".mutableCopy;
    self.testBlock = ^{
        
        Log(@"Local string %@", tString);
//        Log(@"My string %@", self.viewControllerString);
    };
    self.testBlock();
    [tString replaceCharactersInRange:[tString rangeOfString:@"local"] withString:@"Pritesh's local"];
    self.viewControllerString = @"My modified string";
    self.testBlock();
    
    NSLog(@"Retain count of tString is %ld", CFGetRetainCount((__bridge CFTypeRef)tString));
    NSLog(@"Retain count of self is %ld", CFGetRetainCount((__bridge CFTypeRef)self));

    

    NSArray<NSNumber *> *arrayToSort = @[@(3),@(2),@(1),@(4),@(5),@(6),@(2),@(2),@(2),@(1),@(12),@(0)];
    
   NSArray *sortedByObjcMethod = [arrayToSort sortedArrayUsingComparator:^NSComparisonResult(NSNumber *  _Nonnull obj1, NSNumber *  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSArray *insertionSortedArray = [Sorting insertionSortOnArray:arrayToSort];
    Log("Insertion Sorted, %@", insertionSortedArray);
    NSMutableArray *inplaceInsertionSort = [Sorting inPlaceinsertionSortOnArray:insertionSortedArray.mutableCopy];
    Log("Inplace Insertion Sorted, %@", inplaceInsertionSort);

    NSArray *mergeSort = [Sorting mergeSortOnArray:arrayToSort];
    Log("Merge Sorted, %@", mergeSort);

    NSArray *lessMemoryMergeSort = [Sorting mergeSortWithLessSpaceOnArray:arrayToSort];
    Log("Merge Sorted, %@", lessMemoryMergeSort);
    
    Heap *heap = [[Heap alloc] initWithArray:arrayToSort shouldSortInAcendingOrder:NO];
    Log(@"Built heap an min array, %@", [heap buildHeap]);
    Log(@"HeapSort, %@", [heap heapSort]);
    
    MaxPriorityQueue *queue = [[MaxPriorityQueue alloc] initMaxPriorityQueueWithArray: arrayToSort];
    Log(@"Max Priority Queue, %@", queue.mutArray);
    
    Log(@"Max of Priority Queu, %@", queue.mutArray[0]);
    
    Log(@"Extract Max of Priority Queu, %@", queue.extractMaximum);
    
    Log(@"Max Priority Queue AFTER EXTRACT MAXIMUM, %@", queue.mutArray);

    [queue insertNumber:@(4)];
    
    Log(@"Max Priority Queue Insert, %@", queue.mutArray);

    [queue icrementNumberAtIndex:11 withNumber:@(3)];
    
    Log(@"Max Priority Queue after increment, %@", queue.mutArray);
    
    NSMutableArray<NSNumber *> *arr = @[@(4), @(5), @(9), @(13), @(2), @(1), @(8)].mutableCopy;

    [Sorting quickSortOnArray:arr withStartIndex:0 endIndex:arr.count-1];
    Log(@"Quick Sort array, %@",arr);
    
    arrayToSort = @[@(3),@(2),@(1),@(4),@(5),@(6),@(2),@(2),@(2),@(1),@(12),@(0)];
    NSArray *resultArray = [Sorting countingSortOnArray:arrayToSort  numbersLessThan:14];
    Log(@"CCC Counting Array, %@",resultArray);
    
    arrayToSort = @[@(3),@(2),@(1),@(4),@(5),@(6),@(2),@(2),@(2),@(1),@(12),@(0)];
    NSArray *radixResultArray = [Sorting radixSortOn:arrayToSort];
    Log(@"Counting Array, %@",radixResultArray);

    Log(@"Random number, %u", arc4random_uniform(10));
    
    NSMutableArray *array1 = @[@(10), @(2), @(5), @(19), @(4), @(0)].mutableCopy;
    
    NSArray *permutedArray = [Arrays_Algorithms permuteArray:array1];
    NSMutableArray *priorityArray = @[@(22), @(21), @(25), @(1), @(2), @(3)].mutableCopy;
    
    [Arrays_Algorithms sortArray1:array1 basedOnArray2:priorityArray withStartIndex:0 andEndIndex:priorityArray.count - 1];
    
    Log(@"Permuted array %@", array1);
    
    NSMutableArray *mutTestArray = @[@(11), @(6), @(19), @(3), @(15), @(2), @(1), @(10)].mutableCopy;
//    [Sorting modifyArray:mutTestArray withStartIndex:0 endIndex:mutTestArray.count - 1];
//    Log(@"Mut Test Array: %@", mutTestArray);
    
   NSNumber *ithSmallestValue = [Arrays_Algorithms ithSmallestNumberinArray:mutTestArray fori:4 withStartIndex:0 andEndIndex:mutTestArray.count - 1];
    Log(@"iTh Smallest value, %lu", ithSmallestValue.integerValue);
    
    NSMutableArray<NSNumber *> *mutNegativeArray = @[@(-10), @(-5), @(-4), @(-3), @(-2), @(1)].mutableCopy;
    [CareerCupAlgorithms squareAndSortArray:mutNegativeArray];
    Log(@"SQUARE AND SORT %@", mutNegativeArray);
    mutNegativeArray = @[@(3), @(4), @(8)].mutableCopy;
    [CareerCupAlgorithms squareAndSortArray:mutNegativeArray];
    Log(@"SQUARE AND SORT 2 %@", mutNegativeArray);
   
    mutNegativeArray = @[@(10), @(-5), @(4), @(-3), @(2), @(1)].mutableCopy;

    [Sorting selectionSort:mutNegativeArray];
    Log(@"Selection Sort = %@", mutNegativeArray);
    
   BOOL foundSubSequence = [CareerCupAlgorithms doesThereExistSubsequenceInArray:@[@(19), @(3), @(5), @(18)] withSum:18];
    
    Log(@"Found Sub sequence %d", foundSubSequence);
    
    
    //Map
    MapNode *root = [[MapNode alloc] initWithValue:@(10) parent:nil left:nil right:nil];
    Map *map = [[Map alloc] initWithRoot:root];
    [map insertNumber:@(14)];
    [map insertNumber:@(5)];
    [map insertNumber:@(8)];
    [map insertNumber:@(13)];
    [map insertNumber:@(17)];
    [map insertNumber:@(8)];
    [map insertNumber:@(1)];
    [map insertNumber:@(9)];
    [map insertNumber:@(2)];
    [map insertNumber:@(9)];
    [map insertNumber:@(18)];
    [map insertNumber:@(11)];
    [map inorderTreeTraversal];
    
    Log(@"Depth First Search-----------");
    
    MapNode *root2 = [[MapNode alloc] initWithValue:@(10) parent:nil left:nil right:nil];
    Map *map2 = [[Map alloc] initWithRoot:root2];
    [map2 insertNumber:@(15)];
    [map2 insertNumber:@(17)];
    [map2 insertNumber:@(11)];
    [map2 insertNumber:@(6)];
    [map2 insertNumber:@(2)];
    [map2 insertNumber:@(8)];
    [map2 insertNumber:@(9)];
    [MapAlgorithms depthFirstSearch:map];
    
    NSDictionary<NSNumber *, MapNode *> *dict = [CareerCupAlgorithms firstNonMatchingLeafPairFromtree:map treeTwo:map2];
    
    Log(@"Leaf1 = %@, Leaf2 = %@", dict[@(1)].value, dict[@(2)].value);
    
    Log(@"MINIMUM MAP: %@", [map minimum].value);
    Log(@"MAXIMUM MAP: %@", [map maximum].value);
    Log(@"BINARY SEARCH: %@", [map binarySearchNumber:@(11)].value);
    Log(@"PREDECESSOR FOR : %@", [map predecessorForNode:[map binarySearchNumber:@(10)]].value);
    Log(@"SUCCESSOR FOR : %@", [map successorForNode:[map binarySearchNumber:@(10)]].value);
    [map deleteNode:[map binarySearchNumber:@(14)]];
    [map inorderTreeTraversal];
    
    Log(@"DOUBLE DFS TRAVERSAL");
    NSArray *doubleDFSArray = @[@[@(NO), @(YES), @(NO), @(NO), @(NO), @(YES), @(YES)],
                                @[@(YES), @(NO), @(YES), @(NO), @(NO), @(YES), @(NO)],
                                @[@(NO), @(YES), @(NO), @(YES), @(NO), @(NO), @(NO)],
                                @[@(NO), @(NO), @(YES), @(NO), @(YES), @(NO), @(NO)],
                                @[@(NO), @(NO), @(NO), @(YES), @(NO), @(YES), @(NO)],
                                @[@(YES), @(YES), @(NO), @(NO), @(YES), @(NO), @(NO)],
                                @[@(YES), @(NO), @(NO), @(NO), @(NO), @(NO), @(NO)]];
    [GraphAlgorithm doubleGraphTraversalWithAdjacencyMatrix:doubleDFSArray root:0];
    Log(@"DFS TRAVERSAL");

    [GraphAlgorithm DFSWithAdjacencyMatrix:doubleDFSArray];
    
    Log(@"TOPOLOGICAL SORT");
    [GraphAlgorithm topologicalSortWithAdjacencyMatrix:doubleDFSArray];
    
    NSArray *directedGraph = @[@[@(NO), @(YES), @(NO), @(NO), @(NO), @(NO), @(NO), @(NO)],
                                @[@(NO), @(NO), @(YES), @(NO), @(NO), @(YES), @(NO), @(NO)],
                                @[@(NO), @(NO), @(NO), @(NO), @(NO), @(NO), @(NO), @(YES)],
                                @[@(NO), @(YES), @(NO), @(NO), @(YES), @(NO), @(NO), @(NO)],
                                @[@(NO), @(NO), @(NO), @(NO), @(NO), @(YES), @(NO), @(NO)],
                                @[@(NO), @(NO), @(YES), @(NO), @(NO), @(NO), @(YES), @(NO)],
                                @[@(NO), @(NO), @(YES), @(NO), @(NO), @(NO), @(NO), @(NO)],
                                @[@(NO), @(NO), @(NO), @(NO), @(NO), @(NO), @(NO), @(NO)]
                                ];

    NSUInteger count = [GraphAlgorithm numberOfPathsFromSource:0 destination:3 adjacencyMatrix:directedGraph];

    Log(@"Number Of paths in Directed grapth from source = %d to destination = %d is count = %lu", 0, 3, (unsigned long)count);
    
    NSArray *undirectedGraph2 = @[@[@(NO), @(YES), @(NO), @(NO), @(NO), @(NO), @(NO), @(NO)],
                               @[@(YES), @(NO), @(YES), @(YES), @(NO), @(YES), @(NO), @(NO)],
                               @[@(NO), @(YES), @(NO), @(NO), @(NO), @(YES), @(YES), @(YES)],
                               @[@(NO), @(YES), @(NO), @(NO), @(YES), @(NO), @(NO), @(NO)],
                               @[@(NO), @(NO), @(NO), @(YES), @(NO), @(YES), @(NO), @(NO)],
                               @[@(NO), @(YES), @(YES), @(NO), @(YES), @(NO), @(YES), @(NO)],
                               @[@(NO), @(NO), @(YES), @(NO), @(NO), @(YES), @(NO), @(NO)],
                               @[@(NO), @(NO), @(YES), @(NO), @(NO), @(NO), @(NO), @(NO)]
                               ];

    NSArray *undirectedGraph3 = @[@[@(NO), @(YES), @(NO), @(NO)],
                                @[@(YES), @(NO), @(YES), @(YES)],
                                @[@(NO), @(YES), @(NO), @(NO)],
                                @[@(NO), @(YES), @(NO), @(NO)]
                                ];
    BOOL foundLoop = [GraphAlgorithm doesUndirectedGraphHasLoopMatrix:undirectedGraph2];
    Log(@"Found Loop %d", foundLoop);
    
    Log(@"STRONGLY CONNECTED");
    NSArray *directedGraphStronglyConnected = @[@[@(NO), @(YES), @(NO), @(NO), @(NO), @(NO), @(NO), @(NO)],
                                  @[@(NO), @(NO), @(YES), @(NO), @(NO), @(NO), @(YES), @(YES)],
                                  @[@(NO), @(NO), @(NO), @(YES), @(NO), @(YES), @(NO), @(NO)],
                                  @[@(NO), @(NO), @(YES), @(NO), @(YES), @(NO), @(NO), @(NO)],
                                  @[@(NO), @(NO), @(NO), @(NO), @(YES), @(NO), @(NO), @(NO)],
                                  @[@(NO), @(NO), @(NO), @(NO), @(NO), @(NO), @(YES), @(NO)],
                                  @[@(NO), @(NO), @(NO), @(NO), @(NO), @(YES), @(NO), @(NO)],
                                  @[@(YES), @(NO), @(NO), @(NO), @(NO), @(NO), @(YES), @(NO)]
                                  ];

    [GraphAlgorithm stronglyConnectedComponent:directedGraphStronglyConnected];
    
    Log(@"RBL TREE");
    RBLTree *tree = [[RBLTree alloc] initWithValue:@(10)];
    [tree insertNumber:@(4)];
    [tree insertNumber:@(6)];
    [tree insertNumber:@(14)];
    [tree insertNumber:@(4)];
    [tree insertNumber:@(13)];
    [tree insertNumber:@(7)];
    [tree insertNumber:@(19)];
    [tree insertNumber:@(5)];
    
    RBLNode *node = [tree searchNumber:@(13)];
    RBLNode *predecessor = [tree predecessorOfNode:node];
    Log(@"Predecessor of %@ is %@ withColor %lu", node.value, predecessor.value, predecessor.color);
    
    [tree inorderTreeTraversal];
    
    Log(@"After Deletion");
    [tree deleteNumber:node];
    
    [tree inorderTreeTraversal];
 
    Log(@"OVERLAPPING INTERVAL");
    
    NSArray<NSArray<NSNumber *> *> *arrayOfIntervals = @[@[@(7), @(9)], @[@(1), @(4)], @[@(6), @(8)], @[@(2), @(4)], @[@(10), @(15)]];//@[@[@(1), @(4)], @[@(6), @(8)], @[@(2), @(4)], @[@(7), @(9)], @[@(10), @(15)]];//;//;////@[@[@(1), @(4)], @[@(2), @(3)]];
    NSUInteger overlappingLength =  [CareerCupAlgorithms largestOverlappingLengthAmongstTheGivenIntervals: arrayOfIntervals];
   
    Log(@"OVERLAPPING INTERVAL LENGTH = %lu", overlappingLength);
 
    NSArray<NSArray<NSNumber *> *> *mat = @[
  @[@(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES)],
  @[@(YES), @(YES), @(NO), @(YES), @(YES), @(NO), @(YES), @(NO), @(YES), @(YES)],
  @[@(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES), @(YES)]
  ];
    
    NSUInteger longestPath = [CareerCupAlgorithms longestPathFromSourceToDestinationIn:mat sourceRow:0 sourceColumn:0 destinationRow:1 destinationColumn:7];
    
    Log(@"Longest Path %lu", longestPath);
    NSArray<NSArray<NSNumber *> *> *mat2 = @[
    @[@(YES), @(YES), @(YES), @(YES)],
    @[@(YES), @(YES), @(NO), @(YES)],
    @[@(YES), @(YES), @(YES), @(YES)]
                                            ];
//    NSMutableArray *adjMat = [CareerCupAlgorithms buildTreeFromMatrix:mat2];
    NSUInteger shortestPath = [CareerCupAlgorithms shortestPathFromSourceToDestinationIn:mat sourceRow:0 sourceColumn:0 destinationRow:1 destinationColumn:6];
    Log(@"Shortest Path %lu", shortestPath);

    Log(@"Reverse Map Numbers to String");
    NSDictionary *alpHabetsDict = @{
                                    @("1"): @("a"), @("2"): @("b"),
                                    @("3"): @("c"), @("4"): @("d"),
                                    @("5"): @("e"), @("6"): @("f"),
                                    @("7"): @("g"), @("8"): @("h"),
                                    @("9"): @("i"), @("10"): @("j"),
                                    @("11"): @("k"), @("12"): @("l"),
                                    @("13"): @("m"), @("14"): @("n"),
                                    @("15"): @("o"), @("16"): @("p"),
                                    @("17"): @("q"), @("18"): @("r"),
                                    @("19"): @("s"), @("20"): @("t"),
                                    @("21"): @("u"), @("22"): @("v"),
                                    @("23"): @("w"), @("24"): @("x"),
                                    @("25"): @("y"), @("26"): @("z"),
                                    };
   NSMutableArray *possibleString = [CareerCupAlgorithms arrayOfPossibleStringsFromString:@"1626" withDict:alpHabetsDict];
    Log(@"Possible Strings %@", possibleString);
    
    PNTrie *trie = [[PNTrie alloc] init];
    [trie insertObject:@"abc"];
    [trie insertObject:@"acd"];
    [trie insertObject:@"bcd"];
    [trie insertObject:@"cat"];
    [trie insertObject:@"cot"];
    [trie insertObject:@"cit"];
    [trie insertObject:@"cut"];
    [trie insertObject:@"abe"];
    [trie insertObject:@"ab"];
    [trie insertObject:@"a"];
    [trie insertObject:@"bat"];


    
    NSString *stringQuery = @"b";
    NSArray *possibleStringsFromPrefixSearch = [trie prefixSearch:stringQuery];
    
    Log(@"Possible Strings From Trie for query = %@ array = %@", stringQuery, possibleStringsFromPrefixSearch);
    
    Log(@"contains query = %@ BOOL = %d", @"a", [trie containsObject:@"a"]);
    
    Log(@"delete query = %@ BOOL = %d", @"ab", [trie deleteObject:@"ab"]);
    Log(@"delete query = %@ BOOL = %d", @"bcd", [trie deleteObject:@"bcd"]);
    
    Log(@"2 Possible Strings From Trie for query = %@ array = %@", @"b", [trie prefixSearch:@"a"]);
    
    Log(@"GREP c.t is %@", [trie grepWord:@"..."]);
    
    NSArray *nthSmallestArray = @[@(3), @(16), @(1), @(20), @(45), @(0), @(23)];
    NSNumber *num = [Sorting nthSmallestNumberinArray:@[@(3), @(16), @(1), @(20), @(45), @(0), @(23)] n: 1];
    Log(@"%dth in %@ is %@", 1, nthSmallestArray, num);
    
    NSString *tStr = @"poi";
    NSMutableString *mtStr =@"poi".mutableCopy;
    NSMutableArray *arrtr = @[tStr, mtStr].mutableCopy;
    tStr = @"oip";
    [mtStr replaceCharactersInRange:NSMakeRange(0, 2) withString:@"change"];
    
    CGPoint t =CGPointMake( 0 , 0);
    NSMutableArray *marr = @[].mutableCopy;
    [marr addObject:[NSValue valueWithCGPoint:t]];

    NSArray<NSArray<NSNumber *> *> *coinsMat = @[
                                             @[@(10), @(0), @(0), @(0)],
                                             @[@(0), @(1), @(5), @(20)],
                                             @[@(10), @(4), @(0), @(21)]
                                             ];
    NSUInteger maxCoins = [CareerCupAlgorithms maxNumberOfCoinsFromMatrix:coinsMat];
    
    Log("MAX Coins Collected %lu", maxCoins);
    
    NSNumber *fibNumber = [DPAlgo nthFibonacciNumber:5];
    
    Log(@"%dth Fibonacci number is %@", 5, fibNumber);
    
    NSString *exprString = @"5*4-3*2";
    NSArray *possibleResults = [DPAlgo allPossibleValues:exprString];
    Log(@"All possible values of %@ is %@", exprString, possibleResults);
    
    NSUInteger lis = [DPAlgo maximumIncreasingSubSequence: @[@(10), @(22), @(9), @(33), @(21), @(50), @(41), @(60), @(8) ]];
    
    
    Log(@"Longest increseing subseq in %@ is %lu",@[@(10), @(22), @(9), @(33), @(21), @(50), @(41), @(60), @(8) ], lis);
    NSArray *logestSubSeq = [DPAlgo longestIncreasingSubSequence: @[@(10), @(22), @(9), @(33), @(21), @(50), @(41), @(60), @(8) ]];
    
    Log(@"Longest Possible subseq is %@", logestSubSeq);
    
    NSMutableSet *set1 = [NSMutableSet setWithObject:@(1)];
    NSMutableSet *set2 = [NSMutableSet setWithObject:@(2)];
    
    [set1 unionSet:set2];
    
    NSArray<NSArray<NSNumber *> *> *graphMat = @[
  @[@(NSNotFound), @(4), @(4), @(NSNotFound), @(NSNotFound)],
  @[@(4), @(NSNotFound), @(NSNotFound), @(8), @(6)],
  @[@(4), @(NSNotFound), @(NSNotFound), @(3), @(5)],
  @[@(NSNotFound), @(8), @(3), @(NSNotFound), @(2)],
  @[@(NSNotFound), @(6), @(5), @(2), @(NSNotFound)],
    ];
    NSSet<GraphEdge *> *set = [GraphAlgorithm minimumSpanningTreeKruskal:graphMat];
    
    NSMutableArray<GraphEdge *> *prims = [GraphAlgorithm minimumSpanningTreePrimsMat:graphMat];
    
    GraphEdge *edge1 = [[GraphEdge alloc] initWithSrc:@(0) dest:@(1) andWeight:@(10)];
    NSMutableSet *muSet = [NSMutableSet set];
    [muSet addObject:edge1];
    GraphEdge *edge2 = [[GraphEdge alloc] initWithSrc:@(0) dest:@(1) andWeight:@(10)];
    [muSet addObject:edge2];
    [muSet removeObject:[[GraphEdge alloc] initWithSrc:@(0) dest:@(1) andWeight:@(10)]];

    
    NSUInteger numOfSetBits = [GeneralAlgorithms numberOfSetBits: 10];
    
    Log(@"Num of set bits in 10 is %lu",(unsigned long) numOfSetBits);
    
    PNInterval *interval1 = [[PNInterval alloc] initWithStart:@(1) end: @(3)];
    PNInterval *interval2 = [[PNInterval alloc] initWithStart:@(2) end: @(4)];
    PNInterval *interval3 = [[PNInterval alloc] initWithStart:@(5) end: @(7)];
    PNInterval *interval4 = [[PNInterval alloc] initWithStart:@(6) end: @(8)];

    NSMutableArray<PNInterval *> *intervalArray = @[interval1, interval2, interval3, interval4].mutableCopy;
    [GeneralAlgorithms mergeIntervals: intervalArray];
    
    NSArray<NSArray<NSString *> *> *powerSet = [GeneralAlgorithms powerSet:@[@"a", @"b", @"c", @"d"]];
    Log(@"Power set - %@", powerSet);
    
    NSMutableArray<NSMutableArray<NSString *> *> *museum =@[
  @[@"O", @"O", @"G"].mutableCopy,
  @[@"W", @"O", @"W"].mutableCopy,
  @[@"O", @"O", @"G"].mutableCopy,
  ].mutableCopy;
    [CareerCupAlgorithms distanceFromGuardsAtOpenPlacesInMat: museum];
    
    PNInterval *stringInterval1 = [[PNInterval alloc] initWithStart:@(0) end: @(2)];
    PNInterval *stringInterval2 = [[PNInterval alloc] initWithStart:@(2) end: @(3)];
    
    NSMutableArray<PNInterval *> *stringIntervalArray = @[stringInterval1, stringInterval2].mutableCopy;
    
    NSString *lexLargestString = [CareerCupAlgorithms lexicographicallyLargestString:@"abdc".mutableCopy withSwappingIndexes:stringIntervalArray];
    
    
    NSArray *amazNumsArray = @[@(4), @(2), @(8), @(2), @(4), @(5), @(3)];//@[@(10), @(11), @(5), @(14), @(9), @(8)];//@[@(9), @(10), @(5), @(3), @(4), @(1)];
    NSUInteger startingPoint = [CareerCupAlgorithms startingPointForMaximumNumOfAmazingNumberInArray:amazNumsArray];
    Log(@"Starting Point of array %@ for max Amazing num are %lu", amazNumsArray, startingPoint);
    
    NSMutableArray<NSNumber *> *testMutArray = @[@(1), @(2), @(3)].mutableCopy;
    
    [testMutArray insertObject:@(4) atIndex:1];
    
    NSUInteger minEdits = [DPAlgo minimumNumberOfEditsFromStr1:@"sunday" toStr2:@"saturday"];
    
    NSUInteger min = [CareerCupAlgorithms minimumLengthOfSubArray:@[@(3), @(9), @(4), @(5), @(11)] withSumAtLeast:11];
    
    [testMutArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Log(@"obj = %@", obj);
        *stop = YES;
        testMutArray[idx] = @(0);
//        [testMutArray removeObject:obj];
    }];
 
    NSArray<NSString *> *names = @[@"Pritesh", @"Ravindra", @"Nandgaonkar"];
    NSString *priteshName = [names componentsJoinedByString:@" "];
    NSArray *componentsSeperated = [priteshName componentsSeparatedByString:@" "];
    
    NSArray *binary = [GeneralAlgorithms binaryRepresentationOfNumber:@(6)];
    Log("Binary Representation %@", binary);
    
    NSString *string = @"Housing";
    NSString *pattern = @"7";
    BOOL isPatternMatached = [GeneralAlgorithms checkPatternOnString:string pattern:pattern];
    Log("Pattern Matched on String = %@, pattern = %@ Result = %d", string, pattern, isPatternMatached);
    
    NSDictionary<NSString *, NSArray<NSString *> *> *teleDict =
    @{
      @"0" : @[],
      @"1" : @[],
      @"2" : @[@"a", @"b", @"c"],
      @"3" : @[@"d", @"e", @"f"],
      @"4" : @[@"g", @"h", @"i"],
      @"5" : @[@"j", @"k", @"l"],
      @"6" : @[@"m", @"n", @"o"],
      @"7" : @[@"p", @"q", @"r", @"s"],
      @"8" : @[@"t", @"u", @"v"],
      @"9" : @[@"w", @"x", @"y", @"z"]
      };
    
    NSArray *permutedTeleArray = [GeneralAlgorithms permutationsOfString:@"fb1" basedOn:teleDict];
    Log(@"PermutedTeleArray: %@", permutedTeleArray);
    
    
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_get_main_queue());
    
    dispatch_source_set_event_handler(source, ^{
        NSLog(@"%lu", dispatch_source_get_data(source));
    });
    dispatch_resume(source);
    
    dispatch_apply(4, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
        // do some work on data at index
        NSLog(@"Dispatch Apply %zu", index);
        dispatch_source_merge_data(source, 1);
    });
    NSLog(@"After Dispatch Apply");
//    -6 -5 -3 -2 2 3 4
    
  BOOL isThereAPair = [GeneralAlgorithms isTherePairInArray:@[@(-2), @(2), @(-6), @(-3), @(-5), @(4), @(3)] withSum:@(5)];
    
    BOOL isThereTriplet = [GeneralAlgorithms isThereATripletInArray:@[@(-2), @(1), @(-6), @(-3), @(-5), @(1), @(3)] withSum: @(0)];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
