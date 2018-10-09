## Logic Problems

## Objectives 

How does logic problems and brainteasers relate to the job search and interview. 

1. Review [whiteboarding process](https://github.com/joinpursuit/Pursuit-Core-iOS/tree/master/units/unit01/lesson-04-introduction-to-whiteboarding)  
1. Thought Process and approach
1. Being able to take a problem, breaking it down and coming up with an approach to a solution

Logic problems may still be asked at an interview as was during the Pursuit application process. Knowing how to approach example problems is essential to your job search tool set. A fair logic problem should be able to be logically deduced. Many of those problems are rooted in mathematics and computer science. 

## Some essential mathematics knowledge 
1. Prime Numbers - A prime number is a whole number greater than 1 whose only factors are 1 and itself. A factor is a whole numbers that can be divided evenly into another number. The first few prime numbers are 2, 3, 5, 7, 11, 13, 17, 19, 23 and 29. Numbers that have more than two factors are called composite numbers.
1. Divisibility - A divisibility test is a rule for determining whether one whole number is divisible by another. It is a quick way to find factors of large numbers. Divisibility Test for 3: if the sum of the digits of a number is divisible by 3, then the number is divisible by 3. 
1. Probability - Probability. Probability is the likelihood or chance of an event occurring. For example, the probability of flipping a coin and it being heads is ½, because there is 1 way of getting a head and the total number of possible outcomes is 2 (a head or tail). ... The probability of something which is certain to happen is 1.

When you are approached with a logic problem use the similar approach you would apply when posed with a data structure or algorithm (DSA) problem. Most importantly you want to show the interviewer your approach to the problem. Take notes of any rules and patterns you discover while going through the problem / logic puzzle.

## Worst Case Shifting 

Worst case shifting is best described using the example of the "nine balls" weighing problem as described in "Cracking the Coding Interview" by Gale McDowell. 

Problem. You're given nine balls. Eight are the same weight and the ninth ball is heavier than the rest. Using a left and right scale balance, you are only given two chances to weigh to find out which of the nine balls is the heaviest. 

<details>
<summary>Solution</summary>

A first approach might be to divide the balls into sets of four. This approach has an imbalance in the worst case as the ninth ball takes just one weighing to discover it it's the heavier one. Replicating this approach for the remaining sets would result in a worst case of three weightings, one too many. Using **worst case shifting** and dividing the balls into three sets we would shift the imbalance of the worst case. With this new approach we would know the set of three that has the heaviest ball after one weighing. 

</details>

</br>

**For lab break into pairs to solve the logic problems from Canvas**


