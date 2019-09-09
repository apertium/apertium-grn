total=`find . -name '*.txt' | xargs cat  |  sed 's/[:,;!?\.()<>]\+/ & /g;s/  */ /g' | tr '[\t ]' '\n'  | apertium-destxt | hfst-proc -w ../grn.automorf.hfst  | apertium-retxt | grep -v '^$' | wc -l`
known=`find . -name '*.txt' | xargs cat  |  sed 's/[:,;!?\.()<>]\+/ & /g;s/  */ /g' | tr '[\t ]' '\n'  | apertium-destxt | hfst-proc -w ../grn.automorf.hfst  | apertium-retxt | grep -v '^$' | grep -v '\*'  | wc -l`

echo "TOTAL: $total KNOWN: $known"
echo "($known/$total)*100" | bc -l

