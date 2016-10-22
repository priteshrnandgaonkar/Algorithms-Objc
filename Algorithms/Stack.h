//
//  Stack.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/22/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack<ObjectType> : NSObject

- (instancetype)init;
- (instancetype)initWithObject:(ObjectType)object;
- (void)push:(ObjectType)object;
- (ObjectType)pop;
- (NSUInteger)count;
- (void)print;

@end
