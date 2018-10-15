#!/usr/bin/perl 
use warnings;
use Getopt::Long;
my $contact="Nima Rafati nimarafati\@gmail.com
20170703	V1\n";
my $usage = "$0.pl -i input.fasta
This script checks a fasta file to have one header and only one line of sequence. 
$contact\n";

&GetOptions('h=s' =>\$helpFlag,
'i=s' =>\$inputFile);
if($helpFlag)
{
	print $usage;
	exit;
}

my $cntr=0;
my $save_Seq=0;

open(inF1,$inputFile) || die print $usage;
while(<inF1>)
{
	$cntr++;
	chomp($_);
	if($save_Seq == 1)
	{
		$seq.=$_;
	}
	if ($_=~ m/>/)
	{
		if($cntr>1)
		{
			$seq=~ s/>.*//;
			print "$header\n$seq\n";
			$seq="";
		}
		$header=$_;
		$save_Seq=1;
	}
}
close inF1;
