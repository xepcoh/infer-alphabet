Background
==========

This project was my sink-or-swim introduction to Ruby.  I was robbed of the precious opportunity to create the classic Hello World program by the circumstances since the very first time I needed to do something in Ruby was for an interview.  Be that as it may, and I may never get my Hello World time back, the problem was interesting enough.

The Problem
-----------

You are faced with an arbitrary alphabet where an alphabet is defined as an ordered sequence of unique characters.  You don't know what it is and to figure it out you're given a newline-delimitted (or whatever), sorted file of words.  Your mission, should you choose to accept it, is to infer the aphabet from the file.

What do we really know?
-----------------------

Not much but we do know that two consecutive words may have a common root (could be zero length) but different suffixes.  Our algo would have to rely on the initial letters of the suffixes to infer the order.  The initial letter in the preceding suffix would appear earlier in the alphabet than the initial letter in the suffix of the following word.  

The Algo
--------

If we run through the file once and just identify the suffixes between every pair of adjacent words, we would end up with a set of pairs where each pair defined a relative order of the two initial characters in the suffix.  We would then need to organize these pairs into an alphabet.  How may we do that?  One way to think about a pair is as defining a predecessor.  Let's assume that the set of words in the file gives us enough information to infer the whole alphabet.  The first letter of the alphabet does not have a predecessor.  In other words, among all the characters that we've found there will be one for which no pair exists that defines its predecessor.  That should be easy enough.  Let's say we then removed all pairs that pointed to our newfound root.  Well, then we should be right back to where we started--identifying the new "root" and we've already figured out how to do that.  Repeating this process until we've gone through all of the pairs should yield us the alphabet.

Now let's see if my Ruby sparkles ...  Sure that was cheesy but a language with a name like Ruby is almost by design leading you to make puns, doesn't it?  :)  