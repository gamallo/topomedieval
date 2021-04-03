#!/usr/bin/perl 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use open qw(:std :utf8);
use utf8;

$N=0;
$Prec=0;
$Rec=0;
$Fs=0;
while (my $line = <STDIN>) {
    chomp $line;
    if ($line =~ /^prec/) {
	($prec,$rec,$fs) = split (" ", $line);
#	    print STDERR "#$pal# - $lema - $tag\n";
        ($tmp, $prec) = split ("=", $prec);
	$prec =~ trim ($prec);  
	($tmp, $rec) = split ("=", $rec);
	$rec =~ trim ($rec); 
        ($tmp, $fs) = split ("=", $fs);
	$fs =~ trim ($fs);
	$Prec += $prec;
	$Rec += $rec;
	$Fs += $fs;
        $N++;
    }
    if ($line =~ /^tp/) {
	($tp,$fp,$total) = split (" ", $line);
	($tmp, $tp) = split ("=", $tp);
	($tmp, $fp) = split ("=", $fp);
	($tmp, $total) = split ("=", $total);
	$TP += $tp;
	$FP += $fp;
	$TOTAL += $total;
    }
}


$prec = $Prec / $N ;
$recall = $Rec / $N;
$fscore = $Fs / $N;
print "MACRO: Prec = $prec ; Recall = $recall; F1 = $fscore\n";
$prec = $TP / ($TP+$FP) ;
$recall = $TP / $TOTAL;
$fscore = 2*(($prec*$recall)/($prec+$recall));
print "MICRO: Prec = $prec ; Recall = $recall; F1 = $fscore\n";
print "tp=$TP - fp=$FP - total=$TOTAL\n";

    
sub trim {
    my ($x) = @_;

    $x =~ s/^[ ]*//;
    $x =~ s/[ ]$//;
    return $x
}
