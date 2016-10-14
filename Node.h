//
//  Node.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/6/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

@property(strong, nonatomic, readonly) NSNumber *value;
@property(strong, nonatomic) Node *prev;
@property(strong, nonatomic) Node *next;

- (instancetype)initWithValue:(NSNumber *)value previous:(Node *)prev next:(Node *)next;
- (BOOL)isEqualToNode:(Node *)node;

@end
