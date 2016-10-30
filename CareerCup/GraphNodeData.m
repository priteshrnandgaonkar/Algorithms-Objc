//
//  GraphNodeData.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/29/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "GraphNodeData.h"

@implementation GraphNodeData

- (instancetype)init {
    self = [super init];
    if(self) {
        _value = nil;
        _data = nil;
    }
    return self;
}

- (instancetype)initWithValue:(NSObject *)value andData:(NSObject *)data {
    self = [super init];
    if(self) {
        _value = value;
        _data = data;
    }
    return self;
}

@end
