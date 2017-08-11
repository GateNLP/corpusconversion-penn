#!/bin/bash

corenlp="$1"
file="$2"
out="$3"

if [ "x$out" == "x" ]
then
  echo 'Need 3 parameters: STANF_CORENLP INFILE OUTDIR'
  echo 'STANF_CORENLP: path to extracted StanfordCoreNLP v3.5.1 distribution'
  echo 'INFILE: path to file in Penn tree format'
  echo 'OUTDIR: path of directory where to put the generated GATE file'
  exit 1
fi

if [ ! -d ../corpusconversion-universal-dependencies ]
then
  echo 'Could not find ../corpusconversion-universal-dependencies'
  exit 1
fi

tmpdir=/tmp/ccp$$
mkdir $tmpdir
if [ ! -d $tmpdir ]
then
  echo 'Could not create temporary directory ' $tmpdir
  exit 1
fi

        echo converting to conllx file $file
        fname=$(basename "$file")
        java -cp $corenlp/'*' -Xmx1g edu.stanford.nlp.trees.EnglishGrammaticalStructure -basic -keepPunct -conllx -treeFile $file > $tmpdir/${fname}
        ../corpusconversion-universal-dependencies/convert.sh -n 0 $tmpdir/${fname} $out
        rm $tmpdir/${fname}

rm -rf $tmpdir




