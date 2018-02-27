# Whiteboarding Week 5

### Morning interview question:

You are [climbing a stair case](https://leetcode.com/problems/climbing-stairs/description/). It takes n steps to reach to the top.

Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?


### Practice Problems

1. [Happy Numbers](https://leetcode.com/problems/happy-number/)


Write an algorithm to determine if a number is "happy".

A happy number is a number defined by the following process: Starting with any positive integer, replace the number by the sum of the squares of its digits, and repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1. Those numbers for which this process ends in 1 are happy numbers.

Example: 19 is a happy number

1<sup>2</sup> + 9<sup>2</sup> = 82

8<sup>2</sup> + 2<sup>2</sup> = 68

6<sup>2</sup> + 8<sup>2</sup> = 100

1<sup>2</sup> + 0<sup>2</sup> + 0<sup>2</sup> = 1

2. [Third Largest Number](https://leetcode.com/problems/third-maximum-number/)

Given a non-empty array of integers, return the third maximum number in this array. If it does not exist, return the maximum number. 

3. [Remove duplicates from a sorted linked list](https://leetcode.com/problems/remove-duplicates-from-sorted-list/)

Given a sorted linked list, delete all duplicates such that each element appear only once.

|Sample Input | Sample Output | 
|---|---|
|1->1->2| 1->2 |
|1->1->2->3->3| 1->2->3 | 

4. [Length of last word](https://leetcode.com/problems/length-of-last-word/)

Given a string s consists of upper/lower-case alphabets and empty space characters ' ', return the length of last word in the string.

If the last word does not exist, return 0.

Note: A word is defined as a character sequence consists of non-space characters only.

|Sample Input | Sample Output | 
|---|---|
|"Hello World"| 5 |
|"This is a test expression" | 10 |

5. [Find all duplicates in an array](https://leetcode.com/problems/find-all-duplicates-in-an-array/)

Given an array of integers, 1 ≤ a[i] ≤ n (n = size of array), some elements appear twice and others appear once.

Find all the elements that appear twice in this array.

**Bonus**: Solve it in O(n) runtime.  The only extra space you may use is making a copy of the input array (i.e you could do it in constant space if you could manipulate the input array.  You can also make the function an inout function).


|Sample Input | Sample Output | 
|---|---|
|[4,3,2,7,8,2,3,1]| [2,3] |



6. [Remove only nearby duplicates from an array](https://leetcode.com/problems/contains-duplicate-ii/)

Given an array of integers and an integer k, find out whether there are two distinct indices i and j in the array such that nums[i] = nums[j] and the absolute difference between i and j is at most k.


|Sample Input | Sample Output | 
|---|---|
|[1,5,3,9,10,3,4], 2| false |
|[1,5,3,9,10,3,4], 3| true |
|[1,5,3,9,10,3,4], 4| true | 


