# Validation of Module Descriptors

## Aim

Given a dataset of module descriptors, identify issues and generate a report on changes needed and status of the overall dataset. 

## Detail

A module descriptor is a a short (<2 page MS Word) document describing the aim of a module, its learning outcomes and how it will be assessed. Typically module descriptors are written by different authors, at different time points, using unclear guidelines and so the resulting documents may be inconsistent and use different styles. This becomes an issue when the individual descriptors are merged to form programme handbooks, or department/school level documents.

The accompanying CSV file is a sample snapshot of module descriptors, with each row representing a single descriptor.

The following is an outline of the fields, the checks required and their severity.

## `Full_Title`

Full title of module.

 * MUST be in title case. 
    * Mairead - you could decide the quality level of the conversion to title case. See https://titlecaseconverter.com for rules and variations.
 * MUST be unique in dataset.
 * MUST not use roman numerals.
 * MUST not contain abbreviations (including &)

## `Short_Title`

The `Full_Title` will not fit in some legacy reports that the college generates so need an alternative title has a max of 30 characters.

 * MUST have max of 30 characters.
 * To reduce unnecessary variation this should be equal to `Full_Title` if `Full_Title` has 30 characters or less.
 * MUST be unique in dataset.

## Credits

Number of credits student gains towards their programme on passing this module.

 * MUST positive integer, multiple of 5, max 30.

## Level

Level of module learning outcomes (aligned to Bloom's taxonomy)

 * Introductory (6,7) < Intermediate (8) < Advanced (8) < Postgraduate (9,10)

## Aim 

Short outline of descriptor. 
 
 * MUST have between 500 to 2000 characters inclusive.
 * MUST can use markdown syntax for bold and italics which should not affect character count. 


## Indicative_Content

Outline of module's content. Since this is indicative the level of detail is highly dependent on the module author.

 * A spell cheecker will probably result in many false positives, so perhaps a spell checker with a white liist.


## Learning Outcomes

The number of learning outcomes