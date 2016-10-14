//
//  LinkedList.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/6/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "LinkedList.h"

@interface LinkedList()

@property(strong, nonatomic) Node *headNode;

@end

@implementation LinkedList

- (instancetype)init {
    if(self = [super init]) {
        _headNode = nil;
    }
    return self;
}

- (instancetype)initWithValue:(NSNumber *)num {
    if(self = [super init]) {
        _headNode = [[Node alloc] initWithValue:num previous:nil next:nil];
    }
    return self;
}

- (void)insertValue:(NSNumber *)val {
    Node *node = [[Node alloc] initWithValue:val previous:nil next:nil];
    node.next = self.headNode;
    self.headNode.prev = node;
    self.headNode = node;
}

- (Node *)searchValue:(NSNumber *)val {
    Node *currentNode = self.headNode;
    while(currentNode != nil) {
        if([currentNode.value isEqualToValue:val]) {
            return currentNode;
        }
        currentNode = currentNode.next;
    }
    return nil;
}

- (void)deleteValue:(NSNumber *)val {
    Node *valWithNode = [self searchValue:val];
    if(!valWithNode) {
        return;
    }
    Node *previousNode = valWithNode.prev;
    if(previousNode != nil) {
        previousNode.next = valWithNode.next;
        valWithNode.next.prev = previousNode;
    }
    else {
        self.headNode = valWithNode.next;        
    }
    [self deleteValue:val];
}

- (void)deleteNode:(Node *)node {
    Node *valWithNode = [self searchValue:node.value];
    if(![valWithNode isEqualToNode:node]) {
        return;
    }
    
    Node *prev = node.prev;
    if(!prev){
        self.headNode = node.next;
    }
    prev.next = node.next;
    node.next.prev = prev;
}

- (void)printEntireLinkedList {
    
    Node *currentNode = self.headNode;
    if(!currentNode){
        Log(@"Empty List");
        return;
    }
    
    NSMutableString *str = currentNode.value.stringValue.mutableCopy;
    currentNode = currentNode.next;
    while(currentNode != nil){
        NSString *temp = [NSString stringWithFormat:@"--> %@", currentNode.value.stringValue];
        [str appendString:temp];
        currentNode = currentNode.next;
    }
    Log(@"LIST = %@", str);
}

@end
