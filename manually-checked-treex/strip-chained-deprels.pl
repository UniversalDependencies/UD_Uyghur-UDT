#!/usr/bin/env perl
# Removes v2 chained deprels (over elided nodes) from a CoNLL-U file because the current validator does not permit them.
# Dan Zeman <zeman@ufal.mff.cuni.cz>

while(<>)
{
    if(m/^\d+\t/)
    {
        s/\r?\n$//;
        my @fields = split(/\t/);
        $fields[7] =~ s/>.*//;
        # For debugging purposes swap the Arabic and Latin scripts.
        if($fields[9] =~ m/Translit=(.*?)(\||$)/)
        {
            my $translit = $1;
            $fields[9] .= "|Arabic=$fields[1]";
            $fields[1] = $translit;
        }
        $_ = join("\t", @fields)."\n";
    }
    print;
}