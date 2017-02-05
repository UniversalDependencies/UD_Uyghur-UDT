all:
	treex -Lug Read::Treex from='!*.treex.gz' W2W::EstimateNoSpaceAfter HamleDT::UD1To2 Write::CoNLLU print_zone_id=0 path=.
	cat *.conllu | strip-chained-deprels.pl > ug-ud.conllu
	../../../tools/validate.py --lang ug ug-ud.conllu
	cat ug-ud.conllu | ../../../tools/conllu-stats.pl > ../../stats.xml
	split_conll.pl < ug-ud.conllu -head 900 ../../ug-ud-test.conllu ../../ug-ud-dev.conllu
	rm *.conllu
