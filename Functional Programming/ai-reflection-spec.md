# AI Usage Reflection — Submission Specification

**Module:** Functional Programming
**Assignment:** Quiz Bank Parser and Paper Generator

---

## Purpose

This reflection is not about catching you using AI. It is about demonstrating that you engaged with it critically. AI tools can produce plausible-looking Haskell that compiles but is wrong, ignores your invariants, uses the wrong types, or misses the point of the task entirely. Knowing how to recognise that, and fix it, is part of what this module is assessing.

Using AI is permitted. Submitting AI output you do not understand is not.

---

## Format and Length

Submit your reflection as "reflection.md"(using markdown - this is the preferred option or reflection.pdf. It should be **300–500 words**, not counting code excerpts.  

---

## What to Include

Your reflection must contain the following four parts.

---

### Part 1 — Declaration (approx. 50 words)

State clearly whether you used any AI tools during this assignment. If yes, name them (for example: ChatGPT, Claude, GitHub Copilot, Gemini). If you did not use any AI tools, state this and skip Parts 2 and 3.

---

### Part 2 — Worked Example (approx. 200 words + code)

Choose **one specific interaction** where AI assisted you on this assignment. It does not have to be the most impressive — it should be the most honest. Include all three of the following:

**a) The prompt you gave**
Copy your prompt exactly as you typed it.

**b) What the AI produced**
Include a relevant excerpt of the response or code. You do not need to paste everything — just enough to show what it gave you.

**c) What you changed, and why**
Explain specifically what you modified, added, or rejected in the AI output. This is the most important part. A vague statement such as "I tidied it up" is not sufficient. Show the before and after if the change was to code.

Examples of the kind of change being looked for:
- The AI ignored the category inheritance rule from Section 2, so you rewrote that part
- The AI used `String` where your design uses a proper ADT, so you changed the types throughout
- The AI generated a QuickCheck property that always passed trivially, so you replaced it with one that actually tests the invariant
- The AI produced a valid-paper generator that did not fail clearly when constraints were unsatisfiable, so you added the error handling from Section 5.3

---

### Part 3 — Critical Reflection (approx. 150–200 words)

Reflect briefly on your experience of using AI for this assignment. You should address at least two of the following:

- Where was AI most useful? (for example: explaining a concept, producing boilerplate, suggesting a structure)
- Where did it fall short or mislead you? (for example: wrong types, ignoring invariants, not understanding the Moodle XML format)
- Did AI help you move faster, or did fixing its output cost more time than writing from scratch?
- What would you do differently if you were starting again?

---

### Part 4 — References

List each AI tool you used, the approximate date, and a one-line description of what you used it for.

Example:

| Tool    | Date         | Used for                                      |
|---------|--------------|-----------------------------------------------|
| Claude  | March 2026   | Explaining cursor-based XML navigation        |
| ChatGPT | March 2026   | Draft of the QuickCheck Arbitrary instance    |

---

## Marking

The reflection contributes to the **Code Quality and Communication** criterion (Section 10.5, 15% of the total mark). It will be assessed on:

- honesty and specificity (a reflection that shows real engagement is worth more than a polished one that says nothing)
- evidence that you understood any AI-generated code you submitted
- clarity of the worked example

A reflection that is vague, generic, or inconsistent with the code you submitted will attract a low mark in this criterion. A reflection that honestly documents where AI helped and where you had to correct it will attract a high one.

---

## Important Notes

- You will not be penalised for having used AI, only for not reflecting on it honestly.
- If your reflection suggests you do not understand the code in your submission, that will affect your mark across all criteria, not just this one.
- There is no requirement to have used AI. A genuine "I did not use it" reflection is perfectly valid.
