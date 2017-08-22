# Convert the Penn Treebank 3 Format to GATE

NOTE: so far this only supports part of what is in the Penn Treebank corpus:
most importantly the POS tags.

This is a script for converting the Penn Treebank 3 merged files to GATE documents
using the Stanford CoreNLP conversion to CONLLX format and subsequently using the [corpusconversion-universal-dependencies](https://github.com/GateNLP/corpusconversion-universal-dependencies) tool.

NOTE: currently this works only on the WSJ (Wall Street Journal) part of the Penn Treebank
distribution, since the StanfordCoreNLP conversion script used produces errors on the
other sections.

This has only been tested under Linux.

## Convert the Penn Treebank V3 corpus (WSJ part)

* clone this repository or download and extract a release zip file
* clone the [corpusconversion-universal-dependencies](https://github.com/GateNLP/corpusconversion-universal-dependencies) repository into a sibling directory or unzip a release file
* download the Stanford CoreNLP distribution
  and extract it. We will STANFCORENLP as the placeholder for the full path to the
  directory containing the extracted CoreNLP distribution below.
  NOTE: after trying out versions 3.5.1 and 3.8.0 of the CoreNLP distribution on a few
  Penn wsj files, the only difference seems to be that some UD POS tags and some 
  dependency labels are better in the output of versions 3.8.0. 
* create a directory which should contain the files converted into GATE documents.
  We will OUT as the placeholder for the full path to this directory below.
* Obtain the Penn Treebank 3 distribution and extract it. There should be a directory
  called "treebank\_3" which contains a subdirectory "parsed". We will use PENNTB3 as the
  placeholder for the full path to the "treebank\_3" directory below.
* Change into the corpusconversion-penn directory. This directory should contain a script
  "convert-penn-wsj.sh". Run that script using:

```
./convert-penn-wsj.sh STANF_CORENLP PENN_TB3 OUT
```

Where STANFCORENLP, PENNTB3, and OUT are replaced with the actual path names as
per the instructions above.

## Conversion details

The conversion will by default replace the token text placeholders "-LRB-", "-RRB-", "-LCB-", "-RCB-", 
"-LSB-", and "-RSB-" with "(){}[]". Also replaces all token text placeholders "``" and "''" with just 
a single double quote character. The actual POS tags remain the same though. 

This replacement can be disabled by adding an additional 4th parameter "null" to the conversion
script parameters.

## LICENSES

* the license for this software is in the file LICENSES
* this script needs other software that may come with different licenses, please respect their licenses and use this software only in accordance with their licensing rules!

## Convert the GENIA corpus in Penn format

A similar approach should work for the version of the corpus as available from https://nlp.stanford.edu/~mcclosky/biomedical.html however there is no script for that yet.
