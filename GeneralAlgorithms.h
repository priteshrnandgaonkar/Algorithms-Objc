//
//  GeneralAlgorithms.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 11/9/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface PNInterval: NSObject

@property (nonatomic, strong) NSNumber *start;
@property (nonatomic, strong) NSNumber *end;

- (instancetype)init;
- (instancetype)initWithStart:(NSNumber *)start end:(NSNumber *)end;

@end

@interface GeneralAlgorithms : NSObject

+ (NSUInteger)numberOfSetBits:(NSUInteger)num;

+ (void)mergeIntervals:(NSMutableArray<PNInterval *> *)intervals;

+ (NSArray<NSArray<NSString *> *> *)powerSet:(NSArray<NSString *> *)values;
@end
