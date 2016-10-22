//
//  CCMutableNumber.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/22/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCMutableNumber : NSObject<NSCopying>

@property(strong, nonatomic)NSNumber *num;

- (instancetype)initWithNumber:(NSNumber *)number;

@end
