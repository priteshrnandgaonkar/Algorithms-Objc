//
//  GraphNode.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/29/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "GraphNode.h"

@implementation GraphNode

- (instancetype)init {
    self = [super init];
    if (self) {
        _next = nil;
        _data = nil;
    }
    return self;
}

- (void)addNode:(GraphNode *)node {
    if(!self.next) {
        self.next = node;
    }
    else {
        [self.next addNode:node];
    }
}

@end
