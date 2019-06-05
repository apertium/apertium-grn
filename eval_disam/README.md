## Evaluation 

This data in `train_test_split` folder is aimed for development and evaluation of constraint grammar rules stored in `apertium-grn.grn.lrx` file.

`evaluate_tagger.py` calculates precision, recall and F-score metrics based on `source.txt`, `reference.txt` and `target.txt` files. 

1. `source.txt` contains per token morphological output from the analyser;
2. `reference.txt` includes manually disambiguated tokens;
3. `target.txt` contains the actual output after constraint grammar was applied.

To calculate metrics run the script with the command

```bash
python3 evaluate_tagger.py source.txt reference.txt target.txt
```