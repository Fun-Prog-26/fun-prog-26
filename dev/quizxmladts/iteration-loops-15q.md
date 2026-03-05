## Q1 (multichoice)
Purpose of loops

What is the main purpose of using a loop in programming?

- [0%] To execute a set of statements only once
  - That’s what happens without loops — they repeat, not run once.
- [100%] To repeat a set of statements multiple times
  - Correct! Loops automate repetition in code.
- [0%] To compare two numbers
  - Comparisons happen inside conditions, not loops themselves.
- [0%] To define a variable
  - Variables can exist inside loops, but that’s not their main purpose.


## Q2 (multichoice)
Loop types in Java

In Java, which of these is &lt;em&gt;not&lt;/em&gt; a type of loop?

- [0%] while
  - `while` is a valid Java loop type.
- [0%] for
  - `for` loops are one of the main loop structures.
- [0%] do while
  - `do while` is another valid Java loop type.
- [100%] repeat until
  - Correct — Java doesn’t have `repeat until`; that’s used in other languages.


## Q3 (multichoice)
What controls loop continuation

What is the control structure that allows a loop to continue or stop?

- [100%] Boolean condition
  - Correct! The condition decides whether the loop keeps running.
- [0%] String comparison
  - You can compare strings, but that doesn’t control a loop directly.
- [0%] Arithmetic operator
  - Operators perform math, not control repetition.
- [0%] Input statement
  - Inputs can influence loops, but they don’t control them.


## Q4 (multichoice)
While syntax

Which of the following is the correct general form of a &lt;code&gt;while&lt;/code&gt; loop?

- [100%] while (condition) { statements }
  - Correct! This is the standard structure of a while loop in Java.
- [0%] loop (condition) { statements }
  - `loop` is not a Java keyword.
- [0%] do { condition } while { statements }
  - The order is reversed — that’s not valid syntax.
- [0%] repeat (condition) { statements }
  - `repeat` is not recognised in Java.


## Q5 (multichoice)
LCV responsibilities

In a &lt;code&gt;while&lt;/code&gt; loop, the loop control variable (LCV) must be:

- [0%] Declared but never updated
  - Without updating, the loop might never end!
- [0%] Updated only after the loop
  - The LCV must change during the loop.
- [100%] Declared, tested, and updated inside or before the loop
  - Correct! The LCV needs all three steps to control iteration.
- [0%] Automatically managed by Java
  - Java doesn’t automatically manage the loop variable for &lt;code&gt;while&lt;/code&gt; loops.


## Q6 (multichoice)
Always-true while

What happens if the Boolean condition in a &lt;code&gt;while&lt;/code&gt; loop is always &lt;code&gt;true&lt;/code&gt;?

- [0%] The loop runs once
  - It keeps going, not just once!
- [0%] The program crashes
  - It won’t crash automatically — it just won’t stop.
- [100%] The loop runs infinitely
  - Correct! A &lt;code&gt;true&lt;/code&gt; condition causes an infinite loop unless broken.
- [0%] The compiler rejects it
  - It’s valid Java syntax — the issue happens at runtime.


## Q7 (multichoice)
Hello World while count

How many times will this code print “Hello World”?&lt;pre&gt;&lt;code&gt;int i = 1;
while (i &lt;= 4) {
    System.out.println(&quot;Hello World&quot;);
    i++;
}&lt;/code&gt;&lt;/pre&gt;

- [0%] 3
  - No — it starts at 1 and ends at 4, giving 4 prints.
- [100%] 4
  - Correct! It prints 4 times: when i = 1, 2, 3, 4.
- [0%] 5
  - It stops before i reaches 5.
- [0%] Infinite
  - The counter increases, so it won’t loop forever.


## Q8 (multichoice)
For header visibility

Which parts are &lt;em&gt;explicitly visible&lt;/em&gt; in a &lt;code&gt;for&lt;/code&gt; loop header?

- [100%] Initialisation, condition, post-body action
  - Correct! All three are part of a for loop’s header.
- [0%] Only the condition
  - That describes a &lt;code&gt;while&lt;/code&gt; loop, not a &lt;code&gt;for&lt;/code&gt; loop.
- [0%] Only initialisation and condition
  - The increment (post-body) is also visible.
- [0%] Only post-body action
  - You can’t have just an increment in a &lt;code&gt;for&lt;/code&gt; header.


## Q9 (multichoice)
Infinite for

Which of the following &lt;code&gt;for&lt;/code&gt; loop headers would create an infinite loop?

- [100%] for ( ; ; )
  - Correct — without a condition, the loop never ends.
- [0%] for (int i = 0; i &lt; 5; i++)
  - That loop stops when i reaches 5.
- [0%] for (int i = 10; i &gt; 0; i--)
  - That loop stops when i reaches 0.
- [0%] for (int i = 1; i &lt;= 10; i++)
  - It ends when i is greater than 10.


## Q10 (multichoice)
For update location

In a &lt;code&gt;for&lt;/code&gt; loop, where is the &lt;em&gt;update of the LCV&lt;/em&gt; typically located?

- [0%] Before the loop
  - The update occurs after each iteration, not before.
- [0%] Inside the loop body
  - It can be, but typically it’s in the header.
- [100%] In the third part of the loop header
  - Correct! The update expression is the third element in the header.
- [0%] After the loop ends
  - Updating after the loop wouldn’t affect loop control.


## Q11 (multichoice)
For output sequence

What output will this code produce?
&lt;pre&gt;&lt;code&gt;for (int i = 1; i &lt;= 3; i++) {
    System.out.println(&quot;Num: &quot; + i);
}&lt;/code&gt;&lt;/pre&gt;

- [0%] Num: 0, Num: 1, Num: 2
  - The loop starts at 1, not 0.
- [100%] Num: 1, Num: 2, Num: 3
  - Correct! i takes the values 1, 2, 3.
- [0%] Num: 1, Num: 2, Num: 3, Num: 4
  - It stops before i reaches 4.
- [0%] None
  - The loop definitely executes three times.


## Q12 (multichoice)
While vs Do-while difference

What is the main difference between a &lt;code&gt;while&lt;/code&gt; loop and a &lt;code&gt;do while&lt;/code&gt; loop?

- [0%] while runs once, do while runs many times
  - Both can run multiple times depending on the condition.
- [100%] do while runs its body before testing the condition
  - Correct! &lt;code&gt;do while&lt;/code&gt; checks after executing once.
- [0%] do while can’t use Boolean conditions
  - It uses Boolean conditions just like &lt;code&gt;while&lt;/code&gt;.
- [0%] There is no difference
  - They differ in when the condition is checked.


## Q13 (multichoice)
Do-while syntax

Which of the following is the correct syntax for a &lt;code&gt;do while&lt;/code&gt; loop?

- [100%] do { statements } while (condition);
  - Correct! The semicolon is required after the while condition.
- [0%] while { statements } do (condition);
  - The order of keywords is wrong.
- [0%] loop (condition) { statements }
  - `loop` is not a Java keyword.
- [0%] do while { statements }
  - Missing braces and condition placement are incorrect.


## Q14 (multichoice)
When to choose do-while

When should you choose a &lt;code&gt;do while&lt;/code&gt; loop instead of a &lt;code&gt;while&lt;/code&gt; loop?

- [100%] When the body must run at least once
  - Correct! A &lt;code&gt;do while&lt;/code&gt; ensures the body executes before testing.
- [0%] When the condition should never be checked
  - It still checks the condition — just afterward.
- [0%] When the loop must never terminate
  - That would be a logic error, not a reason to use it.
- [0%] When you don’t need a counter
  - Both loop types can use or omit counters.


## Q15 (multichoice)
LCV definition

What do we call a variable that controls how many times a loop executes?

- [0%] Sentinel variable
  - A sentinel controls when to stop based on data, not a counter.
- [100%] Loop control variable
  - Correct! The LCV determines how the loop progresses.
- [0%] Incrementer
  - Incrementing is one part of what an LCV does.
- [0%] Boolean variable
  - The LCV might be tested by a Boolean condition, but isn’t one itself.


