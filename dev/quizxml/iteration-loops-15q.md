# Iteration & Loops Quiz (from Moodle XML)

> Generated from Moodle XML.

## Q1. Purpose of loops

What is the main purpose of using a loop in programming?

**Options**

- A. To execute a set of statements only once
  - _Feedback_: That’s what happens without loops — they repeat, not run once.
- B. To repeat a set of statements multiple times ✅
  - _Feedback_: Correct! Loops automate repetition in code.
- C. To compare two numbers
  - _Feedback_: Comparisons happen inside conditions, not loops themselves.
- D. To define a variable
  - _Feedback_: Variables can exist inside loops, but that’s not their main purpose.

## Q2. Loop types in Java

In Java, which of these is &lt;em&gt;not&lt;/em&gt; a type of loop?

**Options**

- A. while
  - _Feedback_: `while` is a valid Java loop type.
- B. for
  - _Feedback_: `for` loops are one of the main loop structures.
- C. do while
  - _Feedback_: `do while` is another valid Java loop type.
- D. repeat until ✅
  - _Feedback_: Correct — Java doesn’t have `repeat until`; that’s used in other languages.

## Q3. What controls loop continuation

What is the control structure that allows a loop to continue or stop?

**Options**

- A. Boolean condition ✅
  - _Feedback_: Correct! The condition decides whether the loop keeps running.
- B. String comparison
  - _Feedback_: You can compare strings, but that doesn’t control a loop directly.
- C. Arithmetic operator
  - _Feedback_: Operators perform math, not control repetition.
- D. Input statement
  - _Feedback_: Inputs can influence loops, but they don’t control them.

## Q4. While syntax

Which of the following is the correct general form of a &lt;code&gt;while&lt;/code&gt; loop?

**Options**

- A. while (condition) { statements } ✅
  - _Feedback_: Correct! This is the standard structure of a while loop in Java.
- B. loop (condition) { statements }
  - _Feedback_: `loop` is not a Java keyword.
- C. do { condition } while { statements }
  - _Feedback_: The order is reversed — that’s not valid syntax.
- D. repeat (condition) { statements }
  - _Feedback_: `repeat` is not recognised in Java.

## Q5. LCV responsibilities

In a &lt;code&gt;while&lt;/code&gt; loop, the loop control variable (LCV) must be:

**Options**

- A. Declared but never updated
  - _Feedback_: Without updating, the loop might never end!
- B. Updated only after the loop
  - _Feedback_: The LCV must change during the loop.
- C. Declared, tested, and updated inside or before the loop ✅
  - _Feedback_: Correct! The LCV needs all three steps to control iteration.
- D. Automatically managed by Java
  - _Feedback_: Java doesn’t automatically manage the loop variable for &lt;code&gt;while&lt;/code&gt; loops.

## Q6. Always-true while

What happens if the Boolean condition in a &lt;code&gt;while&lt;/code&gt; loop is always &lt;code&gt;true&lt;/code&gt;?

**Options**

- A. The loop runs once
  - _Feedback_: It keeps going, not just once!
- B. The program crashes
  - _Feedback_: It won’t crash automatically — it just won’t stop.
- C. The loop runs infinitely ✅
  - _Feedback_: Correct! A &lt;code&gt;true&lt;/code&gt; condition causes an infinite loop unless broken.
- D. The compiler rejects it
  - _Feedback_: It’s valid Java syntax — the issue happens at runtime.

## Q7. Hello World while count

How many times will this code print “Hello World”?&lt;pre&gt;&lt;code&gt;int i = 1;
while (i &lt;= 4) {
    System.out.println(&quot;Hello World&quot;);
    i++;
}&lt;/code&gt;&lt;/pre&gt;

**Options**

- A. 3
  - _Feedback_: No — it starts at 1 and ends at 4, giving 4 prints.
- B. 4 ✅
  - _Feedback_: Correct! It prints 4 times: when i = 1, 2, 3, 4.
- C. 5
  - _Feedback_: It stops before i reaches 5.
- D. Infinite
  - _Feedback_: The counter increases, so it won’t loop forever.

## Q8. For header visibility

Which parts are &lt;em&gt;explicitly visible&lt;/em&gt; in a &lt;code&gt;for&lt;/code&gt; loop header?

**Options**

- A. Initialisation, condition, post-body action ✅
  - _Feedback_: Correct! All three are part of a for loop’s header.
- B. Only the condition
  - _Feedback_: That describes a &lt;code&gt;while&lt;/code&gt; loop, not a &lt;code&gt;for&lt;/code&gt; loop.
- C. Only initialisation and condition
  - _Feedback_: The increment (post-body) is also visible.
- D. Only post-body action
  - _Feedback_: You can’t have just an increment in a &lt;code&gt;for&lt;/code&gt; header.

## Q9. Infinite for

Which of the following &lt;code&gt;for&lt;/code&gt; loop headers would create an infinite loop?

**Options**

- A. for ( ; ; ) ✅
  - _Feedback_: Correct — without a condition, the loop never ends.
- B. for (int i = 0; i &lt; 5; i++)
  - _Feedback_: That loop stops when i reaches 5.
- C. for (int i = 10; i &gt; 0; i--)
  - _Feedback_: That loop stops when i reaches 0.
- D. for (int i = 1; i &lt;= 10; i++)
  - _Feedback_: It ends when i is greater than 10.

## Q10. For update location

In a &lt;code&gt;for&lt;/code&gt; loop, where is the &lt;em&gt;update of the LCV&lt;/em&gt; typically located?

**Options**

- A. Before the loop
  - _Feedback_: The update occurs after each iteration, not before.
- B. Inside the loop body
  - _Feedback_: It can be, but typically it’s in the header.
- C. In the third part of the loop header ✅
  - _Feedback_: Correct! The update expression is the third element in the header.
- D. After the loop ends
  - _Feedback_: Updating after the loop wouldn’t affect loop control.

## Q11. For output sequence

What output will this code produce?
&lt;pre&gt;&lt;code&gt;for (int i = 1; i &lt;= 3; i++) {
    System.out.println(&quot;Num: &quot; + i);
}&lt;/code&gt;&lt;/pre&gt;

**Options**

- A. Num: 0, Num: 1, Num: 2
  - _Feedback_: The loop starts at 1, not 0.
- B. Num: 1, Num: 2, Num: 3 ✅
  - _Feedback_: Correct! i takes the values 1, 2, 3.
- C. Num: 1, Num: 2, Num: 3, Num: 4
  - _Feedback_: It stops before i reaches 4.
- D. None
  - _Feedback_: The loop definitely executes three times.

## Q12. While vs Do-while difference

What is the main difference between a &lt;code&gt;while&lt;/code&gt; loop and a &lt;code&gt;do while&lt;/code&gt; loop?

**Options**

- A. while runs once, do while runs many times
  - _Feedback_: Both can run multiple times depending on the condition.
- B. do while runs its body before testing the condition ✅
  - _Feedback_: Correct! &lt;code&gt;do while&lt;/code&gt; checks after executing once.
- C. do while can’t use Boolean conditions
  - _Feedback_: It uses Boolean conditions just like &lt;code&gt;while&lt;/code&gt;.
- D. There is no difference
  - _Feedback_: They differ in when the condition is checked.

## Q13. Do-while syntax

Which of the following is the correct syntax for a &lt;code&gt;do while&lt;/code&gt; loop?

**Options**

- A. do { statements } while (condition); ✅
  - _Feedback_: Correct! The semicolon is required after the while condition.
- B. while { statements } do (condition);
  - _Feedback_: The order of keywords is wrong.
- C. loop (condition) { statements }
  - _Feedback_: `loop` is not a Java keyword.
- D. do while { statements }
  - _Feedback_: Missing braces and condition placement are incorrect.

## Q14. When to choose do-while

When should you choose a &lt;code&gt;do while&lt;/code&gt; loop instead of a &lt;code&gt;while&lt;/code&gt; loop?

**Options**

- A. When the body must run at least once ✅
  - _Feedback_: Correct! A &lt;code&gt;do while&lt;/code&gt; ensures the body executes before testing.
- B. When the condition should never be checked
  - _Feedback_: It still checks the condition — just afterward.
- C. When the loop must never terminate
  - _Feedback_: That would be a logic error, not a reason to use it.
- D. When you don’t need a counter
  - _Feedback_: Both loop types can use or omit counters.

## Q15. LCV definition

What do we call a variable that controls how many times a loop executes?

**Options**

- A. Sentinel variable
  - _Feedback_: A sentinel controls when to stop based on data, not a counter.
- B. Loop control variable ✅
  - _Feedback_: Correct! The LCV determines how the loop progresses.
- C. Incrementer
  - _Feedback_: Incrementing is one part of what an LCV does.
- D. Boolean variable
  - _Feedback_: The LCV might be tested by a Boolean condition, but isn’t one itself.

