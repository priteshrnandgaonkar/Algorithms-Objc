//
//  CCMutableNumber.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/22/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "CCMutableNumber.h"

@implementation CCMutableNumber

- (instancetype)initWithNumber:(NSNumber *)number {
    self = [super init];
    if(self) {
        _num = number;
    }
    return self;
}

- (NSString *)description {
    return self.num.stringValue;
}

- (id)copyWithZone:(NSZone *)zone {
    CCMutableNumber *mutNumber = [[[self class] allocWithZone:zone] initWithNumber:self.num];
    return mutNumber;
}

@end
