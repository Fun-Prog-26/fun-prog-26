## Q1 (loops, multichoice)
Purpose of loops

What is the main purpose of using a loop in programming?

- [  ] To execute a set of statements only once
- [  ] To repeat a set of statements multiple times
- [  ] To compare two numbers
- [  ] To define a variable


## Q2 (arrays, multichoice)
Loop types in Java

In Java, which of these is **not** a type of loop?

- [  ] while
- [  ] for
- [  ] do while
- [  ] repeat until


## Q3 (loops, multichoice)
What controls loop continuation

What is the control structure that allows a loop to continue or stop?

- [  ] Boolean condition
- [  ] String comparison
- [  ] Arithmetic operator
- [  ] Input statement


## Q4 (loops, multichoice)
While syntax

Which of the following is the correct general form of a `while` loop?

- [  ] while (condition) { statements }
- [  ] loop (condition) { statements }
- [  ] do { condition } while { statements }
- [  ] repeat (condition) { statements }


## Q5 (loops, multichoice)
LCV responsibilities

In a `while` loop, the loop control variable (LCV) must be:

- [  ] Declared but never updated
- [  ] Updated only after the loop
- [  ] Declared, tested, and updated inside or before the loop
- [  ] Automatically managed by Java


## Q6 (loops, multichoice)
Always-true while

What happens if the Boolean condition in a `while` loop is always `true`?

- [  ] The loop runs once
- [  ] The program crashes
- [  ] The loop runs infinitely
- [  ] The compiler rejects it


## Q7 (loops, multichoice)
Hello World while count

How many times will this code print “Hello World”?
~~~ 
int i = 1;
while (i <= 4) {
    System.out.println("Hello World");
    i++;
}
 ~~~ 


- [  ] 3
- [  ] 4
- [  ] 5
- [  ] Infinite


## Q8 (loops, multichoice)
For header visibility

Which parts are **explicitly visible** in a `for` loop header?

- [  ] Initialisation, condition, post-body action
- [  ] Only the condition
- [  ] Only initialisation and condition
- [  ] Only post-body action


## Q9 (loops, multichoice)
Infinite for

Which of the following `for` loop headers would create an infinite loop?

- [  ] for ( ; ; )
- [  ] for (int i = 0; i < 5; i++)
- [  ] for (int i = 10; i > 0; i--)
- [  ] for (int i = 1; i <= 10; i++)


## Q10 (loops, multichoice)
For update location

In a `for` loop, where is the **update of the LCV** typically located?

- [  ] Before the loop
- [  ] Inside the loop body
- [  ] In the third part of the loop header
- [  ] After the loop ends


## Q11 (loops, multichoice)
For output sequence

What output will this code produce?

~~~ 
for (int i = 1; i <= 3; i++) {
    System.out.println("Num: " + i);
}
 ~~~ 


- [  ] Num: 0, Num: 1, Num: 2
- [  ] Num: 1, Num: 2, Num: 3
- [  ] Num: 1, Num: 2, Num: 3, Num: 4
- [  ] None


## Q12 (loops, multichoice)
While vs Do-while difference

What is the main difference between a `while` loop and a `do while` loop?

- [  ] while runs once, do while runs many times
- [  ] do while runs its body before testing the condition
- [  ] do while can’t use Boolean conditions
- [  ] There is no difference


## Q13 (loops, multichoice)
Do-while syntax

Which of the following is the correct syntax for a `do while` loop?

- [  ] do { statements } while (condition);
- [  ] while { statements } do (condition);
- [  ] loop (condition) { statements }
- [  ] do while { statements }


## Q14 (loops, multichoice)
When to choose do-while

When should you choose a `do while` loop instead of a `while` loop?

- [  ] When the body must run at least once
- [  ] When the condition should never be checked
- [  ] When the loop must never terminate
- [  ] When you don’t need a counter


## Q15 (loops, multichoice)
LCV definition

What do we call a variable that controls how many times a loop executes?

- [  ] Sentinel variable
- [  ] Loop control variable
- [  ] Incrementer
- [  ] Boolean variable


