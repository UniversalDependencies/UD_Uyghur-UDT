SHELL=/bin/bash

package:
	cat [0-9]*.conllu | strip-chained-deprels.pl > ug-ud.conllu
	../../../tools/validate.py --lang ug ug-ud.conllu
	cat ug-ud.conllu | ../../../tools/conllu-stats.pl > ../../stats.xml
	split_conll.pl < ug-ud.conllu -head 900 ../../ug-ud-test.conllu ../../ug-ud-dev.conllu

# We started to edit the CoNLL-U files directly. They are now the master
# copy. They contain changes that were not done in the Treex files.
# Hence we should NOT overwrite the CoNLL-U files with a new conversion
# from the Treex files!
#treex_to_conllu:
#	treex -Lug Read::Treex from='!*.treex.gz' W2W::EstimateNoSpaceAfter HamleDT::UD1To2 Write::CoNLLU print_zone_id=0 path=.

# Separate validation of partial files will facilitate locating errors in the source files.
validate:
	rm -f *.log
	for i in [0-9]*.conllu ; do echo $$i ; ( cat $$i | strip-chained-deprels.pl > $$i.stripped ) ; ( ( echo $$i ; ../../../tools/validate.py --lang ug $$i.stripped ) >> validate.log 2>&1 ) ; done
	cat validate.log
