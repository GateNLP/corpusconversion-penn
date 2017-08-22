#!/bin/bash

corenlp="$1"
file="$2"
out="$3"
null="$4"

if [ "x$out" == "x" ]
then
  echo 'Convert a Penn format document to one GATE document'
  echo 'Need 3 parameters: STANF_CORENLP INFILE OUTDIR'
  echo 'STANF_CORENLP: path to extracted StanfordCoreNLP v3.5.1 distribution'
  echo 'INFILE: path to file in Penn tree format'
  echo 'OUTDIR: path of directory where to put the generated GATE file'
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

        echo converting to conllx file $file
        fname=$(basename "$file")
        java -cp $corenlp/'*' -Xmx1g edu.stanford.nlp.trees.EnglishGrammaticalStructure -basic -keepPunct -conllx -treeFile $file | \
	       python ${S}/python/replaceTokens.py $null > $tmpdir/${fname}
        ${S}/../corpusconversion-universal-dependencies/convert.sh -n 0 $tmpdir/${fname} $out
        rm $tmpdir/${fname}

rm -rf $tmpdir




