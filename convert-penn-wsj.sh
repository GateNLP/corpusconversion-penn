#!/bin/bash

corenlp="$1"
penn="$2"
out="$3"
null="$4"

if [ "x$out" == "x" ]
then
  echo 'Need 3 parameters: STANF_CORENLP PENN_TB3 OUT'
  echo 'STANF_CORENLP: path to extracted StanfordCoreNLP v3.5.1 distribution'
  echo 'PENN_TB3: path to extracted Penn Treebank v3'
  echo 'OUT: path to empty directory to receive the GATE documents'
  echo 'optional 4th: if "null" does not replace odd Penn tokens'
  exit 1
fi

PRG="$0"
CURDIR="`pwd`"
# need this for relative symlinks
while [ -h "$PRG" ] ; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`"/$link"
  fi
done
SCRIPTDIR=`dirname "$PRG"`
S=`cd "$SCRIPTDIR"; pwd -P`

if [ ! -d ${S}/../corpusconversion-universal-dependencies ]
then
  echo 'Could not find ${S}/../corpusconversion-universal-dependencies'
  exit 1
fi

tmpdir=/tmp/ccp$$
mkdir $tmpdir
if [ ! -d $tmpdir ]
then
  echo 'Could not create temporary directory ' $tmpdir
  exit 1
fi

for dir in $penn/parsed/mrg/*
do
  tmpd=$(basename "$dir")
  if [ -d $dir ] && [ "$tmpd" == "wsj" ]
  then
    echo processing directory $dir
    mkdir $out/$tmpd
    for f in `find $dir -name '*.mrg'`
    do
      if [ -f $f ]
      then
        fname=$(basename "$f")
        dname=$(dirname "$f")
        echo converting to conllx file $fname in $dname
        java -cp $corenlp/'*' -Xmx1g edu.stanford.nlp.trees.EnglishGrammaticalStructure -basic -keepPunct -conllx -treeFile $f | \
	       python ${S}/python/replaceTokens.py $null > $tmpdir/${fname}
        ${S}/../corpusconversion-universal-dependencies/convert.sh -n 0 $tmpdir/${fname} $out/$tmpd
        rm $tmpdir/${fname}
      fi
    done
  fi
done

rm -rf $tmpdir

# java -cp stanford-corenlp-full-2015-01-29/'*' -Xmx3g edu.stanford.nlp.trees.EnglishGrammaticalStructure -basic -keepPunct -conllx -treeFile LDC99T42-Penn-WSJ/treebank_3/parsed/mrg/wsj/00/wsj_0022.mrg > wsj_0022.conllx



