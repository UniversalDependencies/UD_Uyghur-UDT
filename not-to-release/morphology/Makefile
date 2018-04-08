SHELL=/bin/bash

# Usage:
# perl -pe "if (m/^\d+\t/) { @f=split(/\t/); $_=qq($f[1]\n); } else { $_=qq(); }" < ug-ud-dev.conllu > ug-ud-dev.txt
# flookup ug.bin < ug-ud-dev.txt > ug-ud-dev.m.txt
# perl apply-foma-output-to-conllu.pl ug-ud-dev.m.txt < ug-ud-dev.conllu > ug-ud-dev.m.conllu

all: text foma conllu

text:
	perl -pe 'if (m/^\d+\t/) { @f=split(/\t/); $$_=qq($$f[1]\n); } else { $$_=qq(); }' < ug-ud.conllu > ug-ud.txt

foma:
	flookup ug.bin < ug-ud.txt > ug-ud.m.txt

conllu:
	perl apply-foma-output-to-conllu.pl ug-ud.m.txt < ug-ud.conllu > ug-ud.m.conllu

coverage:
	perl -e 'while(<>) { if (m/^\d+\t[^\t]+\t([^\t]+)\t/) { $$n++ ; $$l++ if($$1 ne "_"); } } printf("%d/%d=%f\n", $$l, $$n, $$l/$$n);' < ug-ud.m.conllu

# Fran: I've made a change to the morph script to calculate a score based on the
# times that each feature is seen with each relation. This should give better
# results than just picking one at random. It's not perfect, but it is an
# improvement.
#
# cd /home/zeman/nastroje/hfst
# svn up in apertium-uig and then git pull in ud-scripts.
#
# You can run it now like: [command modified by Dan]

hfst:
	cd /home/zeman/nastroje/hfst ; \
		cat UD_Uyghur/not-to-release/manually-checked/ug-ud.conllu \
		| python3 ud-scripts/conllu-morph.py apertium-uig-incubator/uig.automorf.hfst apertium-uig/texts/uig-feats.tsv apertium-uig/texts/uig-feat-rel.tsv \
		| perl -pe 's/Reflexive=Yes/Reflex=Yes/; s/Case=(Gen|Loc)\|Case=Nom/Case=Nom/; s/Case=Abl\|Case=Loc/Case=Loc/; s/^(\d+\t[^\t]+\t[^\t]+)\t_/$$1\tX/;' \
		> UD_Uyghur/not-to-release/morphology/ug-ud.m-fran.conllu ; \
		cd /net/work/people/zeman/unidep/UD_Uyghur-UDT/not-to-release/morphology

# The following target is cloned from the ../manually-checked folder but here it operates on the morphologically analyzed corpus.
package:
	../../../tools/validate.py --lang ug ug-ud.m-fran.conllu
	cat ug-ud.m-fran.conllu | ../../../tools/conllu-stats.pl > ../../stats.xml
	split_conll.pl < ug-ud.m-fran.conllu -head 900 ../../ug_udt-ud-test.conllu devtrain.conllu
	split_conll.pl < devtrain.conllu -head 900 ../../ug_udt-ud-dev.conllu ../../ug_udt-ud-train.conllu
	wc_conll.pl ../../ug_udt-ud-train.conllu
	wc_conll.pl ../../ug_udt-ud-dev.conllu
	wc_conll.pl ../../ug_udt-ud-test.conllu


