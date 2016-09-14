all:
	treex -Lug Read::Treex from='!*.treex.gz' Write::CoNLLU path=.
	cat *.conllu | strip-chained-deprels.pl > ../ug-ud-sample.conllu
	../../tools/validate.py --lang ug ../ug-ud-sample.conllu
	../../tools/conllu-stats.pl < ../ug-ud-sample.conllu > ../stats.xml
