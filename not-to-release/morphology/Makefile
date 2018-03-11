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
