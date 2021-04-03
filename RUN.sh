#!/bin/bash

CORPUSDIR="/home/gamallo/Aulas/TFG/2021/pablo_vazquez_pereira/test/Obras-MENS_ITGM_O" ##please, put your corpus path
LINGUAKITDIR="/home/gamallo/Linguakit-master" ##please, put your Linguakit path
LOGDIR="tmp"

rm result.txt
for i in $CORPUSDIR/* ; do echo $i;
 file=`basename $i`
 cat $i |./anotar_golden.perl > $LOGDIR/golden_$file
 cat $i |./pre-processo.perl |$LINGUAKITDIR/linguakit tagger histgz -nec |grep NP00 |./buscar_topon.perl gazLOCmedieval.dat  > $LOGDIR/test_$file
 echo $i >> result.txt
 cat $LOGDIR/golden_$file |~/Linguakit-master/linguakit tok histgz -split |awk '($0 ~ /^$/){print "%%%"}{print $0}' |./eval.perl $LOGDIR/test_$file >> result.txt
done
echo "calcular macro e micro"
cat result.txt |./macro-micro.perl 

