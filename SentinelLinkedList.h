//
//  SentinelLinkedList.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/6/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

@interface SentinelLinkedList : NSObject

- (void)insertValue:(NSNumber *)val;
- (void)deleteValue:(NSNumber *)val;
- (Node *)searchValue:(NSNumber *)val;
- (void)deleteNode:(Node *)node;
- (void)printEntireLinkedList;

@end
