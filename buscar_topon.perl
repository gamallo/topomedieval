#!/usr/bin/perl
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use open qw(:std :utf8);
use utf8;

$arq = shift(@ARGV);
open(GAZ, $arq) || die "Can't open search-patterns: $!\n";


while (my $top = <GAZ>) { ##ler os gazetteters
    chomp $top;
    $Topon{$top}++;
}
    
    
while (my $line = <STDIN>) {
    chomp $line;
    my ($token,$lemma,$cat) = split (" ", $line); 
    my @topon = split ("_", $lemma) if ($lemma =~ /_/) ;
    foreach $topon (@topon) {
	if ($Topon{$topon}) {
	    $toponUC = ucfirst ($topon);
	    print "$toponUC $topon NP00G00\n";
	}
    }
    if ($cat =~ /NP00G/){
	print "$line\n";
    }
}

sub limpar {
    my ($x) = @_;

    $x =~ s/\&/ /g;
    $x =~ s/\//\'/g;
    $x =~ s/[\.\,\;\@]//g;
    return $x
}
