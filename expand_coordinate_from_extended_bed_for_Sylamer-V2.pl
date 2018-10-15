#!/usr/bin/perl -l
##This script 
##Nima Rafati 201
#
use Getopt::Long;
$extendSize=2000;
my $contact="Nima Rafati nimarafati\@gmail.com
20160210	V1.0";
my $usage = "./*.pl -fai *.fai -i extended-bed.bed -size in bp (default 2000)
This script extract upstream coordinates of genes using a extended bed file and fai file by defined size (default 2000)
$contact\n";

&GetOptions('h=s' =>\$helpFlag,
'i=s' =>\$inputFile,
'fai=s' =>\$faiFile,
'size=i' =>\$extendSize);
if($helpFlag || $faiFile eq "" || $inputFile eq "")
{
	print $usage;
	exit;
}
open (inF1, $faiFile);
while(<inF1>)
{
	chomp($_);
	@lineArr=split("\t",$_);
	$lengthHash{$lineArr[0]}=$lineArr[1];
}
close inF1;
open (inF2, $inputFile);
while(<inF2>)
{       
        chomp($_);
        @lineArr1=split("\t",$_);
	$positive=$lineArr1[1]-$extendSize;
	$negative=$lineArr1[2]+$extendSize;
	if($lineArr1[5] eq "+" && $positive>=0 && $lineArr1[1]!=0)
	{
		print "$lineArr1[0]\t",$positive,"\t$lineArr1[1]\t$lineArr1[3]";
	}
       	if($lineArr1[5] eq "+" && $positive<0 && $lineArr1[1]!=0)
	{
		print "$lineArr1[0]\t0\t$lineArr1[1]\t$lineArr1[3]";
	}
	if($lineArr1[5] eq "-" && $negative<=$lengthHash{$lineArr1[0]})
	{
		print "$lineArr1[0]\t$lineArr1[2]\t",$negative,"\t$lineArr1[3]";
	}
       	if($lineArr1[5] eq "-" && $negative>$lengthHash{$lineArr1[0]} && $lineArr1[2]<$lengthHash{$lineArr1[0]})
	{
		print "$lineArr1[0]\t$lineArr1[2]\t$lengthHash{$lineArr1[0]}\t$lineArr1[3]";
#		print $_;<STDIN>;
	}
}
close inF2;
