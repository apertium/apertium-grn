# Evaluation

To run the evaluation, first create a corpus of reference tokens,

```
cat ../corpora/*.ref | grep '<' > everything.ref
```

Then run the corpus through the morphological analyser:
```
cat everything.ref | cut -f2 -d'^' | cut -f1 -d'/' | hfst-proc -w ../grn.automorf.hfst > everything.tst
```

Then run the `estimate-morph.py` script,

```
python3 estimate-morph.py everything.ref everything.tst 
```
