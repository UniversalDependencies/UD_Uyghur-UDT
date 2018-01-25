SHELL=/bin/bash

all:
	treex -Lug Read::Treex from='!*.treex.gz' W2W::EstimateNoSpaceAfter HamleDT::UD1To2 Write::CoNLLU print_zone_id=0 path=.
	cat [0-9]*.conllu | strip-chained-deprels.pl > ug-ud.conllu
	../../../tools/validate.py --lang ug ug-ud.conllu
	cat ug-ud.conllu | ../../../tools/conllu-stats.pl > ../../stats.xml
	split_conll.pl < ug-ud.conllu -head 900 ../../ug-ud-test.conllu ../../ug-ud-dev.conllu
	rm *.conllu

validate:
	rm -f *.log
	for i in [0-9]*.conllu ; do echo $$i ; ( cat $$i | strip-chained-deprels.pl > $$i.stripped ) ; ( ( echo $$i ; ../../../tools/validate.py --lang ug $$i.stripped ) >> validate.log 2>&1 ) ; done
	cat validate.log

