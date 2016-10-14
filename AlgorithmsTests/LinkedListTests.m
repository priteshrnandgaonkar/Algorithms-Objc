//
//  LinkedListTests.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/6/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LinkedList.h"
#import "SentinelLinkedList.h"

@interface LinkedListTests : XCTestCase

@end

@implementation LinkedListTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreationWithEmptyHeader {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    LinkedList *list = [[LinkedList alloc] init];
    [list printEntireLinkedList];
    [list insertValue:@(3)];
    [list insertValue:@(4)];
    [list insertValue:@(3)];
    [list printEntireLinkedList];
    Node *n = [list searchValue:@(3)];
//    XCTAssertEqual(n.value.integerValue, 4);
//    XCTAssertEqual(n.next.value.integerValue, 3);
//    XCTAssertEqual(n.prev.value.integerValue, 3);
    [list deleteNode:n];
    [list printEntireLinkedList];
}

- (void)testSentinelLinkedList {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    SentinelLinkedList *list = [[SentinelLinkedList alloc] init];
    [list printEntireLinkedList];
    [list insertValue:@(3)];
    [list insertValue:@(4)];
    [list insertValue:@(3)];
    [list insertValue:@(5)];
    [list insertValue:@(19)];
    [list insertValue:@(3)];
    [list insertValue:@(4)];
    [list insertValue:@(3)];
    [list insertValue:@(20)];
    [list printEntireLinkedList];
    [list deleteValue:@(3)];
    [list printEntireLinkedList];
    Node *n = [list searchValue:@(19)];
    [list deleteNode:n];
    [list printEntireLinkedList];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
