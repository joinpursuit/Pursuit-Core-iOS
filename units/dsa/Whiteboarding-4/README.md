# Whiteboarding week 4

### Morning interview question:

Given an array of Ints, every element appears exactly once, except one element that appears twice.  Find the element that appears twice.


### Practice Problems

# 1.  [Reverse Words](https://leetcode.com/problems/reverse-words-in-a-string-iii/description/)

Given a string, you need to reverse the order of characters in each word within a sentence while still preserving whitespace and initial word order.


```swift
Input: "Let's take LeetCode contest"
Output: "s'teL ekat edoCteeL tsetnoc"
```

# 2. [Add Digits](https://leetcode.com/problems/add-digits/description/)

Given a non-negative integer num, repeatedly add all its digits until the result has only one digit.

For example:

Given num = 38, the process is like: 3 + 8 = 11, 1 + 1 = 2. Since 2 has only one digit, return it.

# 3. [Disemvowel](https://www.codewars.com/kata/disemvowel-trolls)

Trolls are attacking your comment section!

A common way to deal with this situation is to remove all of the vowels from the trolls' comments, neutralizing the threat.

Your task is to write a function that takes a string and return a new string with all vowels removed.

For example, the string "This website is for losers LOL!" would become "Ths wbst s fr lsrs LL!".

Note: for this kata y isn't considered a vowel.

# 4. [Don't give me five](https://www.codewars.com/kata/dont-give-me-five)

Given the start number and the end number of a region and should return the count of all numbers except numbers with a 5 in it.

1,9 -> 1,2,3,4,6,7,8,9 -> Result 8
4,17 -> 4,6,7,8,9,10,11,12,13,14,16,17 -> Result 12

The result may contain fives.
The start number will always be smaller than the end number. Both numbers can be also negative!

# 5. [Backwards Primes](https://www.codewars.com/kata/backwards-read-primes)

Backwards Read Primes are primes that when read backwards in base 10 (from right to left) are a different prime. (This rules out primes which are palindromes.)

**Examples:**

13 17 31 37 71 73 are Backwards Read Primes

13 is such because it's prime and read from right to left writes 31 which is prime too. Same for the others.


Find all Backwards Read Primes between two positive given numbers (both inclusive), the second one being greater than the first one. The resulting array or the resulting string will be ordered following the natural order of the prime numbers.

Example
```
backwardsPrime(2, 100) => [13, 17, 31, 37, 71, 73, 79, 97] backwardsPrime(9900, 10000) => [9923, 9931, 9941, 9967]
```



# 6. [Which are in](https://www.codewars.com/kata/which-are-in)

Given two arrays of strings a1 and a2 return a sorted array r in lexicographical order of the strings of a1 which are substrings of strings of a2.  The array r cannot contains duplicates.

**Example 1:**

```
a1 = ["arp", "live", "strong"]
a2 = ["lively", "alive", "harp", "sharp", "armstrong"]
returns ["arp", "live", "strong"]
```

**Example 2:**

```
a1 = ["tarp", "mice", "bull"]
a2 = ["lively", "alive", "harp", "sharp", "armstrong"]
returns []
```
