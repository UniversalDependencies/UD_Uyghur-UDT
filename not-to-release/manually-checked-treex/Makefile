all:
	treex -Lug Read::Treex from='!*.treex.gz' Write::CoNLLU path=.
	cat *.conllu | strip-chained-deprels.pl > ../../ug-ud-dev.conllu
	rm *.conllu
	../../../tools/validate.py --lang ug ../../ug-ud-dev.conllu
	../../../tools/conllu-stats.pl < ../../ug-ud-*.conllu > ../../stats.xml
