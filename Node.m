//
//  Node.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/6/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "Node.h"

@interface Node()

@property(strong, nonatomic) NSNumber *value;

@end

@implementation Node

- (instancetype)initWithValue:(NSNumber *)value previous:(Node *)prev next:(Node *)next {
    if(self = [super init]){
        _value = value;
        _prev = prev;
        _next = next;
    }
    
    return self;
}

- (BOOL)isEqualToNode:(Node *)node {
    
    if(![self.value isEqualToValue:node.value]) {
        return NO;
    }
    
    Node *prevNode = node.prev;
    Node *prev = self.prev;
    
    while(prevNode != nil && prev != nil) {
        if(![prevNode.value isEqualToValue:prev.value]) {
            return NO;
        }
        prev = prev.prev;
        prevNode = prevNode.prev;
    }
    
    if(prev || prevNode) {
        return NO;
    }
    
    Node *nextNode = node.next;
    Node *next = self.next;
    
    while(nextNode != nil && next != nil) {
        if(![nextNode.value isEqualToValue:next.value]) {
            return NO;
        }
        next = next.next;
        nextNode = nextNode.next;
    }
    
    if(next || nextNode) {
        return NO;
    }
    return YES;
}

- (BOOL)isEqual:(id)object {
    
    if(self == object) {
        return true;
    }
    
    if([object class] != [Node class]) {
        return NO;
    }
    else {
        return [self isEqualToNode:object];
    }
}

@end
