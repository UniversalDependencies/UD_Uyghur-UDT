all:
	treex -Lug Read::Treex from='!*.treex.gz' Write::CoNLLU path=.
	cat 005.conllu | strip-chained-deprels.pl > ../../ug-ud-dev.conllu
	cat 006.conllu | strip-chained-deprels.pl > ../../ug-ud-test.conllu
	rm 005.conllu 006.conllu
	cat *.conllu | strip-chained-deprels.pl > ../../ug-ud-train.conllu
	rm *.conllu
	../../../tools/validate.py --lang ug ../../ug-ud-train.conllu
	../../../tools/validate.py --lang ug ../../ug-ud-dev.conllu
	../../../tools/validate.py --lang ug ../../ug-ud-test.conllu
	../../../tools/conllu-stats.pl < ../../ug-ud-*.conllu > ../../stats.xml
