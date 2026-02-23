# Validation of Module Descriptors

## Aim

Given a dataset of module descriptors, identify issues and generate a report on changes needed and status of the overall dataset. 

## Dataset

The dataset consists approximately 500 module descriptors, most of which have already been cleaned so should pass the criteria listed below.

However, your submitted script will be applied to other descriptors which have not been cleaned and your grade will be based on how well your script performs on that unseen dataset.

**Mairead** I would consider two variations to this that make it easier for students. 1) Give a dataset that contain more problematic descriptors or 2) have two datasets of problematic cases and allow students to submit a script which you apply to the first problematic dataset, then at assignment end apply script to second problematic dataset for grading.

## Detail

### Input

A module descriptor is a a short (typically <2 page MS Word) document describing the aim of a module, its learning outcomes and how it will be assessed. Typically module descriptors are written by different authors, at different time points, using unclear guidelines and so the resulting documents may be inconsistent and use different styles. This becomes an issue when the individual descriptors are merged to form programme handbooks, or department/school level documents.

The accompanying CSV file is a sample snapshot of module descriptors, with each row representing a single descriptor. To create this dataset, descriptors were extracted from a legacy module catalogue system and converted from MS Word into key-value pairs, then the list of dictionaries can be saved as a CSV.

### Output 

Since all changes need to be applied to the data while it is stored in a legacy system, the purpose of this activity is the identify the required changes and to generate a report in a formant that simplifies the manual inputting of the identified changes. So given an input CSV, containing a list of descriptors, you should create an output CSV with columns

~~~
Code,Field,Rule,Severity,Comment
~~~
where

 * `Code` is the descripitor unique identifier.
 * `Field` is the part of the descriptor containing the issue (per list below).
 * `Rule` is the number of the rule (per list below)
 * `Severity` is `INFO`, `WARNIING` or `ERROR`.
 * `Comment` a plain, natural language describing the issue and the required correction.

### Datasheet 

The following is an outline of the fields, the checks required and their severity. Items marked with MUST should generate an error, and RECOMMEND should generate a warning. 

> (delete) Items marks with ASSERT are almost surly true, but since "mistakes were made, but not by me", code should be written to verify all of the assertions.

#### `Code`

Primary key.

> (delete) 1. ASSERT unique identifier.

#### `Full_Title`

Full title of module.

 1. MUST be in title case. 
    * **Mairead** - you could decide the quality level of the conversion to title case. See https://titlecaseconverter.com for rules and variations.
 2. MUST be unique in dataset.
 3. MUST not use roman numerals.
 4. MUST not contain abbreviations (including &).

#### `Short_Title`

The `Full_Title` will not fit in some legacy reports that the college generates so need an alternative title has a max of 30 characters.

 1. MUST have max of 30 characters.
 2. To reduce unnecessary variation this RECOMMEND to be equal to `Full_Title` if `Full_Title` has 30 characters or less.
 3. MUST be unique in dataset.

#### `Credits`

Number of credits student gains towards their programme on passing this module.

 1. MUST positive integer, multiple of 5, max 30.

#### `Level`

Level of module learning outcomes (verbs aligned to Bloom's taxonomy) with ordered levels of Introductory (6,7) < Intermediate (8) < Advanced (8) < Postgraduate (9,10)

 1. MUST be one of `[Introductory<Intermediate<Advanced<Postgraduate]`

#### `Pre-Requisites`

Modules that must be taken in an earlier semester to this module.

 1. MUST be an empty list or `Full_Title`s separated by `;`.
 2. The `Level` of each module in list MUST be equal or lower than the `Level` of this module.

#### `Co-Requisites`

Modules that must be taken in the same semester as this module.

 1. MUST be an empty list or `Full_Title`s separated by `;`.

#### `Aim`

Short outline of descriptor. 
 
 1. MUST have between 500 to 2000 characters inclusive. Note, the aim can use markdown syntax for bold and italics which should not affect character count. 

#### `Department`

 1. MUST be a non-empty string.

#### `Indicative_Content`

Outline of module's content. Since this is indicative the level of detail is highly dependent on the module author. 

**NOTE** This is a multi-line string. Depending on the author, it could be a nested list of lists so not sure what automatic processing could be done here. Even checking for consistent list separator character is non-trivial.

 1. NICE A spell checker will probably result in many false positives, so perhaps a spell checker with a white list.

#### `Programmes`

Can ignore

#### `Learning_Outcomes`

The set of outcomes that a student must demonstrate competency in to gain credits for this module. 

 1. The number of RECOMMEND learning outcomes is weakly related to the number of credits:
   * A 5-credit module &mdash; 4 and 6 learning outcomes inclusive.
   * A 10-credit or 15-credit module &mdash; 5 and 8 learning outcomes inclusive.
   * A 20 or more -credit module &mdash; 6 and 12 learning outcomes inclusive.
 2. Each learning outcomes MUST be a single sentence, and ending with a full stop.
 3. Each learning outcomes MUST use an appropriate verb based on Bloom's taxonomy.

#### `Learning_And_Teaching_Methods`

Not sure what automatic quality checks can be done here. This is free form text.

#### `Learning_Modes`

This column contains a multi-line string. An example entry is 

```
Lecture: full time () + part time (30)
Practical: full time () + part time (18)
Independent Learning: full time () + part time (222)
```

where

 * Each line represents a single type of activity
 * Text before ":" is the type of activity
 * The number on parenthesis is the number of hours allocated for each mode (full time and part time) or blank if not delivered in that mode.
 
 1. Sum of hours in each mode MUST be equal number of credit-hours for the module in both modes.<br/>
   credit-hours = 135 hours for each 5-credits

#### `Assessment_Criteria`

The bands at which a module is graded at. This is a multi-line string with each line of the pattern `MESSAGE` or "`INTERVAL`: `MESSAGE`" where

 * `MESSAGE` is a sentence starting with 'In addition to the normal regulations ... '

or 

 * `INTERVAL` must be items in sequence:
      * ('Fail', 'Pass') for modules with pass/fail basis.
      * ('<40%', '40%-59%', '60%-69%', '70%-100%') for modules where `Level=="Postgraduate"`
      * ('<40%', '40%-49%', '50%-59%', '60%-69%', '70%-100%') for modules where `Level!="Postgraduate"`

 * `MESSAGE` MUST be a complete sentence (or more) ending in a full stop.

#### `Assessment_Methods`

**Maireaid** If you paste the contents of this section into charGPT with the leading prompt "Can you read the following description and write python code to test for each of the following? The function should report message for each test that fails." it generates suitable python code.  In effect if the specification is detailed enough that a student can follow then so can chatGPT.


This field lists the assessment components for the module. It consists of:

 * A multi-line string with each line representing either a main or a sub assessment item. 
 * A main assessment item is not indented and the assessment weight is to the far right. If it is a 'Continuous Assessment' then it must have sub items.
 * A sub item is indented and must follow other sub items or a main item.
 * All items list the related learning outcomes and the weight.

And satisfies conditions:

 1. The weight of each entry MUST be in range 0 to 100 inclusive.
 2. The sum of sub items weights MUST equal the main item weight.
 3. The sum of main item weights MUST sum to 100.
 4. The list of learning outcomes MUST be an ordered, comma separated list, "-" MUST be used to represent continuous sequences of length 3 or more.
 5. The learning outcomes for a main item should be the union of all of the sub item learning outcomes.
 6. The union of learning outcomes must equal the module learning outcomes.

An example entry is given below. Note that this entry has issues 1) second line is missing the learning outcomes (should be taken from sub items) and 2) sum of weights does not match 'Continuous Assessment' sub total and 3) unnecessary trailing comma in line 4.

```
Final Written Examination      : 1,2,3,4    :        50
Continuous Assessment          :            :        50
    Lab Report                 : 5,6,7      :   30
    In-Class Assessment        : 5,6,7,     :   10
```
