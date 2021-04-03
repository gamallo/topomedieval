#!/usr/bin/perl
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use open qw(:std :utf8);
use utf8;


while ($line = <STDIN>) {
    $line =~ s/[\[\]\(\)\@\*]//g;
    $line =~ s/\&/ /g;
    $line =~ s/\//\'/g;

    $line =~ s/<[<]*[^\>]*>[>]*//g;

    print $line;
    
}

