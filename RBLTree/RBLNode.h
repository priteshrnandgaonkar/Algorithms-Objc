//
//  RBLNode.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/24/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "MapNode.h"

typedef NS_ENUM(NSUInteger, RBLNodeColor) {
    RBLNodeColorBlack,
    RBLNodeColorRed
};

@interface RBLNode : NSObject

@property(strong, nonatomic, nonnull) NSNumber *value;
@property(assign, nonatomic) RBLNodeColor color;
@property(weak, nonatomic, nullable) RBLNode *parent;
@property(strong, nonatomic, nullable) RBLNode *left;
@property(strong, nonatomic, nullable) RBLNode *right;

- (instancetype _Nonnull)initWithValue:(NSNumber * _Nonnull)num parent:(RBLNode * _Nullable)parent left:(RBLNode * _Nullable)left right:(RBLNode * _Nullable)right color:(RBLNodeColor)color;

@end
