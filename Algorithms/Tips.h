//
//  Tips.h
//  Algorithms
//
//  Created by Pritesh Nandgaonkar on 10/4/16.
//  Copyright © 2016 Pritesh Nandgaonkar. All rights reserved.
//

#ifndef Tips_h
#define Tips_h

//1.
// Copying one array to another copies the pointer, thus mutating one array will mutate the other
/*
NSArray<NSNumber *> *dummy1 = @[@(9), @(8), @(7), @(6)];
NSMutableArray<NSNumber *> *dummy2 = dummy1.mutableCopy;
[dummy2 removeLastObject];

Log(@"Dummy 2, %@", dummy1);
 */

//2.
// Also do not mutate the value of NSMutableArray while iterating through enumerateObjectsWithBlock: and For in loops
// If you want to mutate then use c style loops like for(NSUInteger i = 0; i < n; ++i){})

//3.
// Hash Table with chaining takes Theta(1+α) time for unsuccessful and successful search on an average.
// where α = load factor = n / m, where n is the universal set of the keys and m is the possible slots in which the hash functions hashes the keys to.
// For the above complexity to be true, "Uniform hashing" is assumed, which is that, any given el- ement is equally likely to hash into any of the m slots, independently of where any other element has hashed to. What does this analysis mean? If the number of hash-table slots is at least pro-portional to the number of elements in the table, we have n = O(m) and, con- sequently, α = n/m = O(m)/m = O(1). Thus, searching takes constant time on average. Since insertion takes O(1) worst-case time and deletion takes O(1) worst-case time when the lists are doubly linked, all dictionary operations can be supported in O(1) time on average.

//4.
// Hash function:- A good hash function satisfies (approximately) the assumption of simple uniform hashing: each key is equally likely to hash to any of the m slots, independently of where any other key has hashed to.
// Division method:-
// In the division method for creating hash functions, we map a key k into one of m slots by taking the remainder of k divided by m. That is, the hash function is
//  h(k) = k mod m
// When using the division method, we usually avoid certain values of m. For example, m should not be a power of 2, since if m = 2^p, then h(k) is just the p lowest-order bits of k. Unless it is known that all low-order p-bit patterns are equally likely, it is better to make the hash function depend on all the bits of the key.
// choosing m = 2^p − 1 when k is a character string interpreted in radix 2^p may be a poor choice, because permuting the characters of k does not change its hash value.
// A prime not too close to an exact power of 2 is often a good choice for m. For example, suppose we wish to allocate a hash table, with collisions resolved by chaining, to hold roughly n = 2000 character strings, where a character has 8 bits. We don’t mind examining an average of 3 elements in an unsuccessful search, so we allocate a hash table of size m = 701. The number 701 is chosen because it is a prime near 2000/3 but not near any power of 2. Treating each key k as an integer, our hash function would be
//  h(k) = k mod 701.

// Multiplication Method:-
// The multiplication method for creating hash functions operates in two steps. First, we multiply the key k by a constant A in the range 0 < A < 1 and extract the fractional part of k A. Then, we multiply this value by m and take the floor of the result. In short, the hash function is h(k) = ⌊m (k A mod 1)⌋

//------------------------Dhasu Algo ------------------------------------
/*
 N friends are playing a game. Each of them has a list of numbers in front of himself.
 
 Each of N friends chooses a number from his list and reports it to the game administrator. Then the game administrator sorts the reported numbers and shouts the K-th largest number.
 
 You want to know the count all possible numbers that the game administrator can shout.
 
 Input Format:
 
 First line of the input contain an integer T, the number of testcases. Then follow T testcases. For each test case the input is of the following format.
 
 In the first line there are two numbers N and K. In each of next N lines there is an integer a_i followed by a_i integers, ith line describes the list for ith person.
 
 All the numbers in all the lists are unique.
 
 Solution:-
 take the smallest number from each set. find the K-th -largest of these. This is the smallest number that is in the result. Similarly, find the largest number in the result. Prove that Each number between the two is in the result.
*/

#endif /* Tips_h */
