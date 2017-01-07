//
//  GeneralAlgorithms.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 11/9/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "GeneralAlgorithms.h"

@implementation PNInterval

- (instancetype)init {
    self = [super init];
    if (self) {
        _start = nil;
        _end = nil;
    }
    return self;
}

- (instancetype)initWithStart:(NSNumber *)start end:(NSNumber *)end {
    self = [super init];
    
    if (self) {
        _start = start;
        _end = end;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat: @"start: %@, end: %@", self.start, self.end];
}

@end

@implementation GeneralAlgorithms

//+ (void)permuteString:(NSString *)str {
//    
//    // Generate count dict
//    NSMutableDictionary<NSString *, NSNumber *> *mutDict = @{}.mutableCopy;
//    NSMutableArray<NSString *> *mutArray = @[].mutableCopy;
////    NSMutableArray *result = [NSMutableArray arrayWithCapacity: str.length];
//    for (NSUInteger i = 0; i < str.length; ++i) {
//        
//        unichar alphabetChar = [str characterAtIndex:i];
//        NSString *alphabet = [NSString stringWithCharacters:&alphabetChar length:1];
//        if (!mutDict[alphabet]) {
//            mutDict[alphabet] = @(1);
//            [mutArray addObject: alphabet];
//        }
//        else {
//            mutDict[alphabet] = @(mutDict[alphabet].integerValue + 1);
//        }
//    }
//    
//    [mutArray sortUsingComparator:^NSComparisonResult(NSString   * _Nonnull obj1, NSString   * _Nonnull obj2) {
//        return [obj1 compare: obj2];
//    }];
//    
//    NSMutableArray<NSString *> *results = [NSMutableArray arrayWithCapacity: str.length];
//    
//    NSDictionary *countDict = [NSDictionary dictionaryWithDictionary: mutDict];
//    [self generatePermutationAndPrintPermutationsOfArray: [NSArray arrayWithArray:mutArray] withCountsDict:countDict andResultsArray: results workingDict:countDict.copy];
//}
//
//+ (void)generatePermutationAndPrintPermutationsOfArray:(NSArray<NSString *> *)alphabetArray withCountsDict:(NSDictionary<NSString *, NSNumber *> *)countDict andResultsArray: (NSMutableArray<NSString *> *)results workingDict:(NSDictionary<NSString *, NSNumber *> *)originalCountDict {
//    
//    NSUInteger idx = [self indexOfFirstLeftElementInArray:alphabetArray withCountGreaterThanZeroInReferenceToDict:countDict];
//    
//    //Base Condition
//    if (idx == NSNotFound) {
//        NSLog(@"%@", results);//[self printArray: results];
//        return
//    }
//    
//    [self addObjectAtIndex:idx inArray: results];
//    countDict[alphabetArray[idx]] = @(countDict[alphabetArray[idx]].integerValue - 1);
//    
//    [self generatePermutationAndPrintPermutationsOfArray:alphabetArray withCountsDict:countDict andResultsArray:results workingDict:originalCountDict];
//    
//    
//}
//
//+ (NSUInteger)indexOfFirstLeftElementInArray:(NSArray<NSString *> *)array withCountGreaterThanZeroInReferenceToDict:(NSDictionary<NSString *, NSNumber *> *)countDict {
//    for (NSUInteger i = 0; i < array.count; ++i) {
//        if (countDict[array[i]].integerValue > 0) {
//            return i;
//        }
//    }
//    return NSNotFound;
//}

+ (BOOL)isThereATripletInArray:(NSArray<NSNumber *> *)arr withSum:(NSNumber *)sum {
    NSMutableArray<NSNumber *> *sortedArray = [arr sortedArrayUsingComparator:^NSComparisonResult(NSNumber   * _Nonnull obj1, NSNumber   * _Nonnull obj2) {
        return [obj1 compare:obj2];
    }].mutableCopy;
    
    BOOL doesTripletExist = NO;
    for (NSUInteger i = 0; i < sortedArray.count; ++i) {
        NSNumber *temp = sortedArray[i];
        [sortedArray removeObject:temp];
        doesTripletExist = [self isTherePairInArray:sortedArray  withSum:@(sum.integerValue - temp.integerValue)];
        if (doesTripletExist) {
            return YES;
        }
        [sortedArray insertObject:temp atIndex:i];
    }
    return NO;
}

+ (BOOL)isTherePairInArray:(NSArray<NSNumber *> *)arr withSum:(NSNumber *)sum {
    NSArray<NSNumber *> *sortedArray = [arr sortedArrayUsingComparator:^NSComparisonResult(NSNumber   * _Nonnull obj1, NSNumber   * _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSUInteger leftIndex = 0;
    NSUInteger rightIndex = arr.count - 1;
    
    while (leftIndex < rightIndex ) {
        if ([sortedArray[leftIndex] integerValue] + [sortedArray[rightIndex] integerValue] < [sum integerValue]) {
            leftIndex++;
        }
        else if([sortedArray[leftIndex] integerValue] + [sortedArray[rightIndex] integerValue] > [sum integerValue]){
            rightIndex--;
        }
        else {
            NSLog(@"Pair with sum %@ is (%@,%@)", sum, sortedArray[leftIndex], sortedArray[rightIndex]);
            return YES;
        }
    }
    
    return NO;
}

+ (NSArray<NSString *> *)permutationsOfString:(NSString *)str basedOn:(NSDictionary<NSString *, NSArray<NSString *> *> *)teleDict {
    
    NSMutableString *convertToNum = @"".mutableCopy;
    
    for(NSUInteger i = 0; i < str.length; ++i) {
        
        unichar letterChar = [str characterAtIndex:i];
        NSString *letter = [NSString stringWithCharacters:&letterChar length:1];
        if (teleDict[letter]) {
            [convertToNum appendString:letter];
            continue;
        }
        
        for (NSString *key in teleDict) {
            
            if ([teleDict[key] containsObject: letter]) {
                [convertToNum appendString:key];
                break;
            }
        }
    }
    
    // Now you have converted Num
    return [self permutationsOfNumberString:[NSString stringWithString:convertToNum] basedOn:teleDict];
}

+ (NSArray<NSString *> *)permutationsOfNumberString:(NSString *)str basedOn:(NSDictionary<NSString *, NSArray<NSString *> *> *)teleDict {

    if (str.length == 0) {
        return @[];
    }
    
    if (str.length == 1) {
        NSString *key = [str substringToIndex:1];
        NSMutableArray<NSString *> *mutArray = teleDict[key].mutableCopy;
        [mutArray addObject:key];
        return mutArray;
    }
    
    NSString *subString = [str substringToIndex:str.length - 1];
    
    NSArray<NSString *> *subStringPermutaions = [self permutationsOfNumberString:subString basedOn:teleDict];
    NSString *lastLetter = [str substringWithRange:NSMakeRange(str.length - 1, 1)];
    
    NSMutableArray<NSString *> *mutArray = @[].mutableCopy;
    
    NSArray *possibleLettersForLastLetter = [teleDict[lastLetter] arrayByAddingObjectsFromArray:@[lastLetter]];
    
    for (NSString *equivalent in possibleLettersForLastLetter) {
        for (NSString *permutation in subStringPermutaions) {
            
            NSString *temp = [permutation stringByAppendingString:equivalent];
            [mutArray addObject:temp];
        }
    }
    
    return [NSArray arrayWithArray:mutArray];
}

+ (NSUInteger)numberOfSetBits:(NSUInteger)num {
    
    NSUInteger numOfBits = ceil(log(num)) + 1;
    NSUInteger count = 0;
    
    NSUInteger temp = 1;
    for (NSUInteger i = 0; i < numOfBits; ++i) {
        count += (num & temp << i) > 0;
    }
    return count;
}

+ (void)mergeIntervals:(NSMutableArray<PNInterval *> *)intervals {
    [intervals sortUsingComparator:^NSComparisonResult(PNInterval *  _Nonnull obj1, PNInterval *  _Nonnull obj2) {
        return [obj1.start compare: obj2.start];
    }];
    
    for (NSUInteger i = 1; i < intervals.count; ++i) {
        if ([intervals[i - 1].end compare: intervals[i].start] == NSOrderedDescending) {
            //OVERLAP
            if ([intervals[i - 1].end compare: intervals[i].end] == NSOrderedAscending) {
                intervals[i - 1].end = intervals[i].end;
            }
            else {
                intervals[i] = intervals[i - 1];
            }
        }
    }
    
    [self removeSubIntervals:intervals];
    
}

+ (void)removeSubIntervals:(NSMutableArray<PNInterval *> *)intervals {
    NSUInteger index = 1;
    while (index < intervals.count) {
        if ([intervals[index].end compare: intervals[index - 1].end] == NSOrderedSame) {
            [intervals removeObjectAtIndex: index];
        }
        else {
            index++;
        }
    }
}

+ (NSArray<NSArray<NSString *> *> *)powerSet:(NSArray<NSString *> *)values {
    // Iterative
    NSUInteger count = values.count;
    NSMutableArray<NSArray<NSString *> *> *mutArray = @[].mutableCopy;
    
    for (NSUInteger i = 0; i < pow(2, count); ++i) {
        [mutArray addObject:[self arrayForNumber:i inValues:values]];
    }
    return [NSArray arrayWithArray: mutArray];
}

+ (NSArray<NSString *> *)arrayForNumber:(NSUInteger)i inValues:(NSArray<NSString *> *)values {

    NSMutableArray<NSString *> *mutArray = @[].mutableCopy;
    NSUInteger count = values.count;
    NSUInteger temp = 1;
    
    while (temp <= pow(2, count) - 1) {
        if ((temp & i) != 0) {
            [mutArray addObject: values[(NSUInteger)ceil(log(temp))]];
        }
        temp = temp << 1;
    }
    
    return [NSArray arrayWithArray: mutArray];
}

+ (BOOL)isNumberChar:(NSString *)alphabetString {
    
    BOOL result = NO;
    if([alphabetString isEqualToString:@"0"]) {
        result = YES;
    }
    else if([alphabetString isEqualToString:@"1"]) {
        result = YES;
    }
    else if([alphabetString isEqualToString:@"2"]) {
        result = YES;
    }
    else if([alphabetString isEqualToString:@"3"]) {
        result = YES;
    }
    else if([alphabetString isEqualToString:@"4"]) {
        result = YES;
    }
    else if([alphabetString isEqualToString:@"5"]) {
        result = YES;
    }
    else if([alphabetString isEqualToString:@"6"]) {
        result = YES;
    }
    else if([alphabetString isEqualToString:@"7"]) {
        result = YES;
    }
    else if([alphabetString isEqualToString:@"8"]) {
        result = YES;
    }
    else if([alphabetString isEqualToString:@"9"]) {
        result = YES;
    }
    return result;
}

+ (BOOL)checkPatternOnString:(NSString *)str pattern:(NSString *)pattern {
    
    NSInteger stringIndex = 0;
    BOOL isNumber = YES;
    NSInteger count = 0;
    
    BOOL result = YES;
    
    for(NSInteger patternIndex = 0; patternIndex < pattern.length; ++patternIndex) {
        
        unichar alphabetChar = [pattern characterAtIndex:patternIndex];
        NSString *alphabet = [NSString stringWithCharacters:&alphabetChar length:1];
        isNumber = [self isNumberChar: alphabet];
        
        if (isNumber) {
            count = (count * 10) + alphabet.intValue;
        }
        else {
            
            if (count > 0) {
                stringIndex += count;
            }
            if(stringIndex >= str.length || alphabetChar != [str characterAtIndex: stringIndex]) {
                result = NO;
                break;
            }
            stringIndex++;
            count = 0;
        }
    }
    
    if (count > 0 && count != str.length - stringIndex) {
        result = NO;
    }
    
    return result;
}

+ (NSArray<NSNumber *> *)binaryRepresentationOfNumber:(NSNumber *)num {
    NSMutableArray<NSNumber *> *mutArray = @[].mutableCopy;
    
    NSMutableArray<NSNumber *> *resultArray = @[].mutableCopy;

    NSInteger temp = num.integerValue;
    while(temp > 0) {
        [mutArray addObject:@(temp % 2)];
        temp = temp / 2;
    }
    
    for (num in mutArray.reverseObjectEnumerator) {
        [resultArray addObject:num];
    }
    
    return [NSArray arrayWithArray:resultArray];
}

@end
