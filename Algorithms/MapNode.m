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
    MapNode *node = [[[self class] allocWithZone:zone]
                     initWithValue:self.value
                     parent:self.parent
                     left:self.left
                     right:self.right];
    return node;
}

@end
