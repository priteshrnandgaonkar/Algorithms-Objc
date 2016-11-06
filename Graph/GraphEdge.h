//
//  GraphEdge.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 11/6/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GraphEdge : NSObject<NSCopying>

@property (strong, nonatomic) NSNumber *src;
@property (strong, nonatomic) NSNumber *dest;
@property (strong, nonatomic) NSNumber *weight;

- (instancetype)initWithSrc:(NSNumber *)src dest:(NSNumber *)dest andWeight:(NSNumber *)weight;

- (BOOL)isEqualToEdge:(GraphEdge *)edge;

@end
