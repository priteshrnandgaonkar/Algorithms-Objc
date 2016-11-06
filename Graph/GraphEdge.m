//
//  GraphEdge.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 11/6/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "GraphEdge.h"

@implementation GraphEdge

- (instancetype)initWithSrc:(NSNumber *)src dest:(NSNumber *)dest andWeight:(NSNumber *)weight {
    
    self = [super init];
    if (self) {
        _src = src;
        _dest = dest;
        _weight = weight;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    GraphEdge *edge = [[[self class] allocWithZone:zone] init];
    edge.src = [self.src copyWithZone:zone];
    edge.dest = [self.dest copyWithZone:zone];
    edge.weight = [self.weight copyWithZone:zone];
    return edge;
}

- (BOOL)isEqualToEdge:(GraphEdge *)edge {
    
    if (![edge.weight isEqualToNumber:self.weight]) {
        return NO;
    }
    
    if ([edge.src isEqualToNumber:self.src] && [edge.dest isEqualToNumber:self.dest]) {
        return YES;
    }
    
    if ([edge.src isEqualToNumber:self.dest] && [edge.dest isEqualToNumber:self.src]) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isEqual:(id)object {
    if (object == self) {
        return YES;
    }
    
    if ([object isKindOfClass:[self class]]) {
        return [self isEqualToEdge:object];
    }
    else {
        return NO;
    }
}

- (NSUInteger)hash {
    return self.src.hash ^ self.dest.hash ^ self.weight.hash;
}

- (NSString *)description {
    NSString *str = [NSString stringWithFormat:@"src = %@, dest = %@, weight = %@", self.src, self.dest, self.weight];
    return str;
}

@end
