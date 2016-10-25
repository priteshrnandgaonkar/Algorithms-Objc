//
//  MapNode.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/14/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "MapNode.h"

@interface MapNode()

@property(strong, nonatomic, nonnull) NSNumber *value;

@end

@implementation MapNode

- (_Nonnull instancetype)initWithValue:(NSNumber  * _Nonnull )num parent:(MapNode * _Nullable)parent left:(MapNode * _Nullable)left right:(MapNode * _Nullable)right {
    
    self = [super init];
    if(self) {
        self.value = num;
        self.left = left;
        self.parent = parent;
        self.right = right;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    
    MapNode *node = [[[self class] allocWithZone:zone] init];
    node.value = [self.value copyWithZone:zone];
    node.parent = self.parent;
    node.left = [self.left copyWithZone:zone];
    node.right = [self.right copyWithZone:zone];

    return node;
}

@end
