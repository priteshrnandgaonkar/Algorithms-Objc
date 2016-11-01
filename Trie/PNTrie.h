//
//  PNTrie.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 11/1/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PNTrieNode : NSObject<NSCopying>

NS_ASSUME_NONNULL_BEGIN

@property (strong, readonly, nonatomic) NSDictionary<NSString *, PNTrieNode *> *childrens;
@property (assign, nonatomic) BOOL isEndOfObject;

- (instancetype)init;
- (void)insertChildKey:(NSString *)key;
- (void)removeKey:(NSString *)key;

NS_ASSUME_NONNULL_END

@end

@interface PNTrie : NSObject

NS_ASSUME_NONNULL_BEGIN

@property (strong, readonly, nonatomic) PNTrieNode *root;

- (instancetype)init;
- (instancetype)initWithRoot:(NSString *)root;

- (void)insertObject:(NSString *)type;
- (NSArray<NSString *> *)prefixSearch:(NSString *)type;
- (BOOL)containsObject:(NSString *)type;
- (BOOL)deleteObject:(NSString *)type;

NS_ASSUME_NONNULL_END

@end
