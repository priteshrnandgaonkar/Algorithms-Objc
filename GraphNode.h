//
//  GraphNode.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/29/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GraphNode<ObjectType: NSObject *> : NSObject

@property(strong, nonatomic) GraphNode<ObjectType> *next;
@property(strong, nonatomic) ObjectType data;

- (instancetype)init;

- (void)addNode:(GraphNode *)node;

@end
