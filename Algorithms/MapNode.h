//
//  MapNode.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/14/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapNode : NSObject<NSCopying>

@property(strong, nonatomic, readonly, nonnull) NSNumber *value;
@property(strong, nonatomic, nullable)id data;
@property(weak, nonatomic, nullable) MapNode *parent;
@property(strong, nonatomic, nullable) MapNode *left;
@property(strong, nonatomic, nullable) MapNode *right;

- (_Nonnull instancetype)initWithValue:(NSNumber  * _Nonnull )num parent:(MapNode * _Nullable)parent left:(MapNode * _Nullable)left right:(MapNode * _Nullable)right;

- (_Nonnull instancetype)initWithValue:(NSNumber  * _Nonnull )num parent:(MapNode * _Nullable)parent left:(MapNode * _Nullable)left right:(MapNode * _Nullable)right data: (id _Nullable)data;

@end
