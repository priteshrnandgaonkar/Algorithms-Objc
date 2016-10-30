//
//  GraphNodeData.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/29/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GraphNodeData<ObjectValueType: NSObject *, ObjectDataType: NSObject *> : NSObject

@property(strong, nonatomic)ObjectValueType value;
@property(strong, nonatomic)ObjectDataType data;

- (instancetype)init;
- (instancetype)initWithValue:(ObjectValueType)value andData:(ObjectDataType)data;

@end
