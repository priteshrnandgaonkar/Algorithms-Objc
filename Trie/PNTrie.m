//
//  PNTrie.m
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 11/1/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#import "PNTrie.h"
#import "Stack.h"

@interface PNTrieNode()

@property (strong, nonatomic) NSMutableDictionary<NSString *, PNTrieNode *> *mutChildrens;

@end

@implementation PNTrieNode

-(instancetype)init {
    self = [super init];
    if(self) {
        _mutChildrens = @{}.mutableCopy;
        _isEndOfObject = NO;
    }
    return self;
}

- (void)insertChildKey:(NSString *)key {
    self.mutChildrens[key] = [[PNTrieNode alloc] init];
}
- (void)removeKey:(NSString *)key {
    [self.mutChildrens removeObjectForKey:key];
}

- (NSDictionary<NSString *,PNTrieNode *> *)childrens {
    
    if(!self.mutChildrens) {
        return nil;
    }
    return [NSDictionary dictionaryWithDictionary:self.mutChildrens];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"childerens: %@, endOfWord: %d", self.mutChildrens, self.isEndOfObject];
}

- (id)copyWithZone:(NSZone *)zone {
    PNTrieNode *node = [[[self class] allocWithZone:zone] init];
    node.mutChildrens = [self.mutChildrens mutableCopyWithZone:zone];
    node.isEndOfObject = self.isEndOfObject;
    return node;
}

@end

@interface PNTrie()

@property (strong, nonatomic) PNTrieNode *root;

@end


@implementation PNTrie

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _root = [[PNTrieNode alloc] init];
    }
    return self;
}

- (instancetype)initWithRoot:(NSString *)val {
    
    self = [self init];
    [_root insertChildKey:val];
    return self;
}

- (void)insertObject:(NSString *)type {
    
    [self insertObject:type withRoot:self.root];
    
}

- (void)insertObject:(NSString *)key withRoot:(PNTrieNode *)node {
    
    NSString *queryKey = [key substringToIndex:1];
    NSString *substring = [key substringFromIndex:1];
    
    if(!node.childrens[queryKey]) {
        [node insertChildKey:queryKey];
    }

    node.childrens[queryKey].isEndOfObject = substring.length == 0;
    
    if(substring.length > 0) {
        [self insertObject:substring withRoot:node.childrens[queryKey]];
    }
    else {
        node.childrens[queryKey].isEndOfObject = YES;
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"DICT : %@", self.root];
}

- (NSArray<NSString *> *)prefixSearch:(NSString *)type {
    
    NSMutableArray<NSString *> *mutArray = @[].mutableCopy;
    NSArray<NSString *> *tempArray = @[];
    
    PNTrieNode *node = self.root;
    NSString *temp = nil;
    NSUInteger i = 0;
    for (i = 0; i < type.length; ++i) {
        temp =  [NSString stringWithFormat:@"%C", [type characterAtIndex:i]];
        if(node.childrens[temp]) {
            node = node.childrens[temp];
        }
        else {
            break;
        }
    }
    
    if(i < type.length) {
        return nil;
    }
 
    tempArray = [self DFSFromeNode:node];
    
    if(tempArray.count == 0 || node.isEndOfObject) {
        [mutArray addObject:type];
    }
    
    for (NSString *str in tempArray) {
        temp = [NSString stringWithFormat:@"%@%@", type, str];
        [mutArray addObject:temp.copy];
    }
    
    return [NSArray arrayWithArray:mutArray];
}

- (NSArray<NSString *> *)DFSFromeNode:(PNTrieNode *)node {
    
    if ([node.childrens allKeys].count <= 0) {
        return @[];
    }
    
    NSArray<NSString *> *dictKeys = node.childrens.allKeys;
    NSMutableArray<NSString *> *mutArray = @[].mutableCopy;
    NSString *tempStr = nil;
    NSArray *arr = nil;
    
    for (NSString *keyString in dictKeys) {
        arr = [self DFSFromeNode:node.childrens[keyString]];
        if(arr.count == 0) {
            [mutArray addObject:keyString];
            continue;
        }
        for (NSString *str in arr) {
            tempStr = [NSString stringWithFormat:@"%@%@", keyString, str];
            [mutArray addObject:tempStr.copy];
        }
    }
    
    return [NSArray arrayWithArray:mutArray];
}

- (BOOL)containsObject:(NSString *)type {
    
    PNTrieNode *node = self.root;
    NSString *temp = nil;
    NSUInteger i = 0;
    
    for (i = 0; i < type.length; ++i) {
        temp =  [NSString stringWithFormat:@"%C", [type characterAtIndex:i]];
        if(node.childrens[temp]) {
            node = node.childrens[temp];
        }
        else {
            return NO;
        }
    }
    return node.isEndOfObject;
}

- (BOOL)deleteObject:(NSString *)type {
    
    if (![self containsObject:type]) {
        return NO;
    }
    
    PNTrieNode *node = self.root;
    NSString *temp = nil;
    NSUInteger i = 0;
    Stack<PNTrieNode *> *st = [[Stack alloc] init];
    
    for (i = 0; i < type.length; ++i) {
        temp =  [NSString stringWithFormat:@"%C", [type characterAtIndex:i]];
        if(node.childrens[temp]) {
            [st push:node];
            node = node.childrens[temp];
        }
        else {
            return NO;
        }
    }
    node.isEndOfObject = NO;
    [self navigateDeletionUpFromNode:node withStack:st];
    return true;
}

- (void)navigateDeletionUpFromNode:(PNTrieNode *)baseNode withStack:(Stack<PNTrieNode *> *)stack {
    
    PNTrieNode *node = baseNode;
    PNTrieNode *parentNode = nil;
    NSArray *temp = nil;

    while(node.childrens.allKeys.count == 0 && stack.count > 0) {

        parentNode = stack.pop;
        temp = [parentNode.childrens allKeysForObject:node];
        if(temp.count > 1 || temp.count == 0) {
            return;
        }
        [parentNode removeKey:temp[0]];
        node = parentNode.copy;
    }
    
}

@end
