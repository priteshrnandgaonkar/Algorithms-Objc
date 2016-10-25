//
//  RBLNode.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/24/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "RBLNode.h"

@interface RBLNode()

@property(strong, nonatomic, nonnull) NSNumber *value;

@end

@implementation RBLNode

- (instancetype)initWithValue:(NSNumber *)num parent:(RBLNode *)parent left:(RBLNode *)left right:(RBLNode *)right color:(RBLNodeColor)color {
    self = [super init];
    if(self) {
        _parent = parent;
        _left = left;
        _right = right;
        _color = color;
        _value = num;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    RBLNode *node = [[[self class] allocWithZone:zone] init];
    node.color = self.color;
    node.parent = self.parent;
    node.left = [self.left copyWithZone:zone];
    node.right = [self.right copyWithZone:zone];
    node.value = [self.value copyWithZone:zone];
    return node;
}

@end
