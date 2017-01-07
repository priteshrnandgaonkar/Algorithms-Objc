//
//  GeneralAlgorithms.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 11/9/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SinglyLinkedNode.h"

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

+ (NSArray<NSNumber *> *)binaryRepresentationOfNumber:(NSNumber *)num;

// If String is "Housing" then the possible pattern for it would be "H3i2" or "H6" or "7"
+ (BOOL)checkPatternOnString:(NSString *)str pattern:(NSString *)pattern;

+ (NSArray<NSString *> *)permutationsOfString:(NSString *)str basedOn:(NSDictionary<NSString *, NSArray<NSString *> *> *)teleDict;

//Complexity is O(nLogN)
+ (BOOL)isTherePairInArray:(NSArray<NSNumber *> *)arr withSum:(NSNumber *)sum;

+ (BOOL)isThereATripletInArray:(NSArray<NSNumber *> *)arr withSum:(NSNumber *)sum;

//+ (void)permuteString:(NSString *)str;

@end
