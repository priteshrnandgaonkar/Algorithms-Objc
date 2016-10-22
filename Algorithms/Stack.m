//
//  Stack.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/22/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "Stack.h"

@interface Stack()

@property(strong, nonatomic) NSMutableArray<NSObject *> *array;

@end

@implementation Stack

- (instancetype)init {
    self = [super init];
    if(self) {
        _array = @[].mutableCopy;
    }
    return self;
}

- (instancetype)initWithObject:(NSObject *)object {
    self = [super init];
    if(self) {
        _array = @[].mutableCopy;
        [_array addObject:object];
    }
    
    return self;
}

- (void)push:(NSObject *)object {
    [self.array addObject:object];
}
- (NSObject *)pop {
    NSObject *lastObject = self.array.lastObject;
    [self.array removeLastObject];
    return lastObject;
}

- (NSUInteger)count {
    return self.array.count;
}

- (void)print {
    NSMutableArray<id> *mut = self.array.mutableCopy;
    while(mut.count > 0) {
        Log(@"%@", mut.lastObject);
        [mut removeLastObject];
    }
}

@end
