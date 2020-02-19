DIX=apertium-grn.grn.lexc
BIN=grn.automorf.hfst

cat ~/data/thesis/corpora/grn_bible.txt |  sed "s/\([^ ]\)['’]\([^ ]\)/\1ʼ\2/g"  | apertium-destxt | nice -n 19 hfst-proc -w $BIN | apertium-retxt | sed 's/\$\W*\^/$\n^/g' > /tmp/grn.coverage.txt

EDICT=`cat $DIX | grep '^[^:]\+:[^ ]\+ *[A-Z]' | wc -l`
EPARA=`cat $DIX | grep -o 'LEXICON ' | wc -l`;
TOTAL=`cat /tmp/grn.coverage.txt | wc -l`;
KNOWN=`cat /tmp/grn.coverage.txt | grep -v '\*' | wc -l`;
COVER=`calc $KNOWN / $TOTAL`;
DATE=`date`;

echo -e $DATE"\t"$EPARA":"$EDICT"\t"$KNOWN"/"$TOTAL"\t"$COVER >> history.log
tail -1 history.log

cat /tmp/grn.coverage.txt | cut -f2 -d'^' | cut -f1 -d'/' | sort -f | uniq -c | sort -gr | grep -v '[0-9] [0-9]' > grn.hitparade.txt

cat grn.hitparade.txt | apertium-destxt |  hfst-proc -w  grn.automorf.hfst | apertium-retxt