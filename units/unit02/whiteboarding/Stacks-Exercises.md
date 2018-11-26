## Exercises 

<pre> 
1. Find the largest integer in a Stack of Ints

func largestElement &lt;T&gt;(in stack: Stack &lt;T&gt;) -> T? {
  return stack.peek
}
</pre> 

</br></br> 

<pre> 
2. Find the sum of a Stack of Ints

func sum(of stack: Stack&lt;Int&gt;) -> Int {
    return 0
}
</pre> 

</br></br> 

3. Write a function that pushes a new element to the bottom of a Stack

func pushBottom&lt;T&gt;(stack: Stack&lt;T&gt;, newElement: T) -> Stack&lt;T&gt; {
    return Stack&lt;T&gt;()
}
</pre> 

</br></br> 

[Valid Braces](https://www.codewars.com/kata/valid-braces)
<pre> 
4. Write a function that takes a string of braces, and determines if the order of the braces is valid. 
It should return true if the string is valid, and false if it's invalid.

This Kata is similar to the Valid Parentheses Kata, but introduces new characters: brackets [], 
and curly braces {}. Thanks to @arnedag for the idea!

All input strings will be nonempty, and will only consist of parentheses, brackets 
and curly braces: ()[]{}.

What is considered Valid?
A string of braces is considered valid if all braces are matched with the correct brace.

Examples
"(){}[]"   =>  True
"([{}])"   =>  True
"(}"       =>  False
"[(])"     =>  False
"[({})](]" =>  False
</pre> 

</br></br> 

[Palindrome](https://leetcode.com/problems/valid-palindrome/description/)
<pre>
5. Solve using two stacks. 
Given a string, determine if it is a palindrome, considering only alphanumeric characters
and ignoring cases.

Note: For the purpose of this problem, we define empty string as valid palindrome.

Example 1:

Input: "A man, a plan, a canal: Panama"
Output: true
Example 2:

Input: "race a car"
Output: false
</pre> 

</br></br>  
