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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *arrayToSort = @[@(3),@(2),@(1),@(4),@(5),@(6),@(2),@(2),@(2),@(1),@(12),@(0)];
    
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
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
