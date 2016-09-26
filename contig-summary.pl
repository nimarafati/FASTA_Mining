#!/usr/bin/perl 
use strict;
#This module calculate the N50 and N90 of contigs.
# ./contig-summary FILENAME
#Nima Rafati 20100525:20120830

my $fileName="";
my $input="";
my $contigLn=0;
my $cntr=0;
my $cntrTotal=0;
my $contigSum=0;
my $min=0;
my $max=0;
my $mean=0;
my $nN50;
my @N50;
my @N90;
my $nN90;
my @contigArr;
my $contig=0;
my $matchS;
my $N50Sum;
my $N90Sum;
my $median;
my @scafflength;
my $seq;
my $seqLength;
$fileName= $ARGV[0];
if ($fileName eq "")
{
	print " please insert the name of the file after the script\n";
	exit;
}
open ("infile", $fileName) || die " I couldn't find the $fileName \n";
while (<infile>)
{
    $input=$_;
	if (/^\>/)
	{
		chomp($seq);
		$seqLength=length($seq);
		$seq="";
		if ( $seqLength != 0)
		{
			push @contigArr, $seqLength;
			$contigSum+=$seqLength;
			$seq="";
			$seqLength="";
			$cntrTotal++;
		}
	}
	else
	{
		$input=~ s/\n//g;
		$seq.=$input;
	}

}
    $seqLength=length($seq);
    push @contigArr, $seqLength;
    $contigSum+=$seqLength;     
    $seqLength=length($seq);

close ("infile");
@contigArr= sort {$a <=> $b} @contigArr;
@N50=@contigArr;
@N90=@contigArr;
$contig=@contigArr;
$min=$contigArr[0];
if ($contig % 2)
{
  $median= $contigArr[$contig/2];
}
else
{
  $median=($contigArr[$contig/2]+$contigArr [$contig/2-1])/2;
}
$mean=int($contigSum/$contig);
$max=$contigArr[$contig-1];
print "min: $min\t max: $max\t median: $median\t Number: $contig\t sum: $contigSum\t Average: $mean \n";
while ( $N50Sum < $contigSum * 0.5 )
{
  $contigLn = pop @contigArr;
  $nN50++;
  $N50Sum+= $contigLn;
}
print "N50: $contigLn\tnN50: $nN50\tSum of N50: $N50Sum\n";
$contigLn=0;
while ( $N90Sum < $contigSum * 0.9 )
{
  $contigLn = pop @N90;
  $nN90++;
  $N90Sum += $contigLn;
}
print "N90: $contigLn\tnN90: $nN90\tSum of N90: $N90Sum\n";
