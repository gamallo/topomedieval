#!/usr/bin/perl 
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use open qw(:std :utf8);
use utf8;

$arq = shift(@ARGV);
open(PFILE, $arq) || die "Can't open search-patterns: $!\n";

$separador = "%%%" ;
$/ = $separador;

while (my $line = <STDIN>) {
  chomp $line;
  my $pal="";
  #print STDERR "#$line#\n";
  if ($line =~ /\n/) {
    my (@entry) = split ('\n',$line);
    foreach my $tok (@entry) {
	chomp $tok;
	$pal .= $tok . "_" if ($tok =~ /\w/);
	#print STDERR "#$pal#\n";
	if ($tok =~ /^[[:upper:]]/) {
	    $Dico{$tok}++;
	}
    }
    $pal =~ s/\_$//;
    #print STDERR "#$pal#\n";
  }  
  else {
      $pal = $line;
  }
  if ($pal) {
      $Dico{$pal}++;
      $N++;
  }
}

$separador = "\n" ;
$/ = $separador;


my $tp=0;
my $fp=0;

while (my $line = <PFILE>) {
    chomp $line;
    ($pal,$lema,$tag) = split (" ", $line);
    #    print STDERR "#$pal# - $lema - $tag\n";
    if ($Dico{$pal} && $tag =~ /NP00G/) {
	$tp++;
	#print STDERR "---TRUE: #$pal# - $lema - $tag\n";
  }
  else {
      $fp++;
  }    
   
}


$prec = $tp / ($tp+$fp) ;
$recall = $tp / $N;
$fscore = 2*(($prec*$recall) /($prec+$recall));
print "tp=$tp fp=$fp total=$N\n";
print "prec=$prec recall=$recall F1=$fscore\n";

