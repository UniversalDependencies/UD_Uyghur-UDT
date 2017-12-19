#!/usr/bin/env perl
# Reads a file processed by Foma flookup (Uyghur morphology).
# Remembers analyses of words in a cache.
# Then reads a CoNLL-U file and applies the analyses, translated to UD features.
# Copyright © 2017 Dan Zeman <zeman@ufal.mff.cuni.cz>
# License: GNU GPL

# Usage:
# perl -pe "if (m/^\d+\t/) { @f=split(/\t/); $_=qq($f[1]\n); } else { $_=qq(); }" < ug-ud-dev.conllu > ug-ud-dev.txt
# flookup ug.bin < ug-ud-dev.txt > ug-ud-dev.m.txt
# perl apply-foma-output-to-conllu.pl ug-ud-dev.m.txt < ug-ud-dev.conllu > ug-ud-dev.m.conllu

use utf8;
use open ':utf8';
binmode(STDIN, ':utf8');
binmode(STDOUT, ':utf8');
binmode(STDERR, ':utf8');

my $fomaoutput = shift(@ARGV);
open(FOMA, $fomaoutput) or die("Cannot read Foma output $fomaoutput: $!");
while(<FOMA>)
{
    s/\r?\n$//;
    my ($word, $analysis) = split(/\t/, $_);
    $cache{$word}{$analysis}++;
}
close(FOMA);

my %v2f =
(
    'Prs'   => 'PronType=Prs',
    'Dem'   => 'PronType=Dem',
    'Ind'   => 'PronType=Ind',
    'Card'  => 'NumType=Card',
    'Sing'  => 'Number=Sing',
    'Plur'  => 'Number=Plur',
    '1'     => 'Person=1',
    '2'     => 'Person=2',
    '3'     => 'Person=3',
    'Infm'  => 'Polite=Infm',
    'Form'  => 'Polite=Form',
    'Nom'   => 'Case=Nom',
    'Gen'   => 'Case=Gen',
    'Dat'   => 'Case=Dat',
    'Acc'   => 'Case=Acc',
    'Loc'   => 'Case=Loc',
    'Abl'   => 'Case=Abl',
    'Inf'   => 'VerbForm=Inf',
    'Fin'   => 'VerbForm=Fin',
    'Part'  => 'VerbForm=Part',
    'Conv'  => 'VerbForm=Conv',
    'Ind'   => 'Mood=Ind',
    'Pot'   => 'Mood=Pot',
    'Cnd'   => 'Mood=Cnd',
    'Imp'   => 'Mood=Imp',
    'Pres'  => 'Tense=Pres',
    'Past'  => 'Tense=Past',
    'Fut'   => 'Tense=Fut',
    'Nfh'   => 'Evident=Nfh',
    'Hab'   => 'Aspect=Hab',
    'Prog'  => 'Aspect=Prog',
    'Prosp' => 'Aspect=Prosp',
    'Perf'  => 'Aspect=Perf',
    'Pos'   => 'Polarity=Pos',
    'Neg'   => 'Polarity=Neg',
    'Int'   => 'Interrog=Yes'
);

while(<>)
{
    if(m/^\d+/)
    {
        my @f = split(/\t/, $_);
        # Set lemma of punctuation to the surface form of the symbol.
        if($f[3] eq 'PUNCT')
        {
            $f[2] = $f[1];
        }
        elsif(exists($cache{$f[1]}))
        {
            # If there is more than one analysis, select those that match our part-of-speech tag.
            # But note that Foma says only "VERB" for words that can be both VERB and AUX.
            my $lookfortag = $f[3];
            $lookfortag = '(VERB|AUX)' if($lookfortag =~ m/^(VERB|AUX)$/);
            my @a = grep {m/\+$lookfortag/} (keys(%{$cache{$f[1]}}));
            if(scalar(@a)>0)
            {
                my $aa = $a[0];
                my @items = split(/\+/, $aa);
                # Lemma is the first item.
                $f[2] = shift(@items);
                # UPOS tag is the second item, and we already know it.
                shift(@items);
                # The remaining items are feature values.
                my %features;
                foreach my $i (@items)
                {
                    if(exists($v2f{$i}))
                    {
                        $features{$v2f{$i}}++;
                    }
                    else
                    {
                        print STDERR ("WARNING: Unknown Foma feature '$i'\n");
                    }
                }
                my @features = sort {lc($a) cmp lc($b)} (keys(%features));
                #my @features = sort(keys(%features));
                if(scalar(@features)>0)
                {
                    $f[5] = join('|', @features);
                }
            }
        }
        $_ = join("\t", @f);
    }
    print;
}
