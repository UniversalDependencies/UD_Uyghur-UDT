source-xml ... The original files from Marhaba. Dan converted them to CoNLL-U, then to Treex (so that they can be edited in Tred).
    Various versions exist in the folder. It is not that the individual files shall be concatenated!
all-treex ... Original treebank automatically converted to Treex and split to 35 files, 100 sentences per file.
manually-checked-treex ... Treex files edited by Marhaba. Conversion of these files to CoNLL-U also happens in this folder.
    There is a Makefile, the script strip-chained-deprels.pl that is needed for the conversion, and the resulting CoNLL-U files.
    There is also a log from validation. If there are errors, they are reported back to Marhaba, she edits the Treex files and
    sends a new version.
ug-conllu_fixed ... In the last exchange in December 2017, Marhaba attempted to fix directly the CoNLL-U files, without revisiting
    the Treex files. The "fixed" files are in this folder (but they still have problems).
morphology ... A prototype of an Uyghur morphological analyzer implemented in Foma. Output of the analyzer applied to the treebank files.
