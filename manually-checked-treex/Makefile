all:
	treex -Lug Read::Treex from='!*.treex.gz' Write::CoNLLU path=.
	cat *.conllu | strip-chained-deprels.pl > ../ug-ud-manual.conllu
	../../tools/validate.py --lang ug ../ug-ud-manual.conllu
	../../tools/conllu-stats.pl < ../ug-ud-manual.conllu > ../stats.xml
