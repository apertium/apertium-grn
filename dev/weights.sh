cat ../eval_disam/train_test_split/reference_test.txt | grep -v '\/.*\/' | grep -v '\*'  | grep -o '<[^>]\+>' | sort -u > grn.symbols
cat ../eval_disam/train_test_split/reference_test.txt | grep -v '\/.*\/' | grep -v '\*' | sed 's/:/\\:/g' | python3 weights.py > grn.weights
cat grn.weights | cut -f1 | hfst-strings2fst -j -m grn.symbols -o ../.deps/grn.weights.noweight.hfst
cat grn.weights | hfst-strings2fst -j -m grn.symbols -o ../.deps/grn.weights.hfst
#echo "?::0.0" | hfst-regexp2fst | hfst-repeat -o ../.deps/grn.weights.maxweight.hfst
#hfst-union -1 ../.deps/grn.weights.strweights.hfst -2 ../.deps/grn.weights.maxweight.hfst -o ../.deps/grn.weights.hfst
