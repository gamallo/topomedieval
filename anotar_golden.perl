#!/usr/bin/perl
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use open qw(:std :utf8);
use utf8;


while (my $line = <STDIN>) {
    $line =~ s/[\[\]\(\)]//g;
    #$line =~ s/\&/ /g;
    #$line =~ s/\//\'/g;

    my @topon = ($line =~ /@@([^ ]+)[\,\.\n ]/g) ;
    foreach $topon (@topon) {
	if ($topon =~ /@@/) {
	    $topon =~ s/\@\@/\@/g;
	    my ($top1, $top2) = split ('@', $topon);
	    $topon = limpar ($topon);
	    $top2 = limpar ($top2);
	    print "$topon\n";
	    print "$top2\n";
	}
	else {
	    $topon = limpar ($topon);
	    print "$topon\n";
	}
    }
}

sub limpar {
    my ($x) = @_;

    $x =~ s/\&/ /g;
    $x =~ s/\//\'/g;
    $x =~ s/[\.\,\;\@]//g;
    return $x
}
