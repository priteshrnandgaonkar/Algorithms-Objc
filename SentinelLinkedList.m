//
//  SentinelLinkedList.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/6/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "SentinelLinkedList.h"

@interface SentinelLinkedList()

@property(strong, nonatomic) Node *headNode;

@end

@implementation SentinelLinkedList

- (instancetype)init
{
    self = [super init];
    if (self) {
        _headNode = [[Node alloc] initWithValue:@(NSIntegerMax) previous:nil next:nil];
        _headNode.next = _headNode;
        _headNode.prev = _headNode;
    }
    return self;
}

- (void)insertValue:(NSNumber *)val {
    
    Node *head = self.headNode.next;
    Node *nodeToInsert = [[Node alloc] initWithValue:val previous:self.headNode next:head];
    if(head == self.headNode) {
        self.headNode.next = nodeToInsert;
        self.headNode.prev = nodeToInsert;
    }
    else {
        head.prev = nodeToInsert;
        self.headNode.next = nodeToInsert;
    }
}

- (Node *)searchValue:(NSNumber *)val {
    Node *head = self.headNode.next;
    if(head == self.headNode) {
        return nil;
    }
    
    while(head != self.headNode) {
        if([head.value isEqualToValue:val]) {
            return head;
        }
        head = head.next;
    }
    return nil;
}

- (void)deleteValue:(NSNumber *)val {
    Node *valWithNode = [self searchValue:val];
    if(!valWithNode) {
        return;
    }
    Node *prev = valWithNode.prev;
    prev.next = valWithNode.next;
    valWithNode.next.prev = prev;
    [self deleteValue:val];
}

- (void)deleteNode:(Node *)node {
    
    Node *prev = node.prev;
    prev.next = node.next;
    node.next.prev = prev;
}

- (void)printEntireLinkedList {
    
    Node *currentNode = self.headNode.next;
    if(currentNode == self.headNode){
        Log(@"SentinelLinkedList Empty List");
        return;
    }
    
    NSMutableString *str = currentNode.value.stringValue.mutableCopy;
    currentNode = currentNode.next;
    while(currentNode != self.headNode){
        NSString *temp = [NSString stringWithFormat:@" --> %@", currentNode.value.stringValue];
        [str appendString:temp];
        currentNode = currentNode.next;
    }
    Log(@"SentinelLinkedList LIST = %@", str);
}

@end
