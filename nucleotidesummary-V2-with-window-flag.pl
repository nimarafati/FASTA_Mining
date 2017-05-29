#!/usr/bin/perl 
# use strict;
# This module calculates the number of nucleotides and GC content in supplied sequences. You can also set a flag to calculate GC content in window 
#USage: ./nucleotidesummary.pl filename.fasta
#Nima Rafati 2010425:20130620
use Getopt::Long;
my $date="20140303";
my $line;
my $ScaffNCntr=0;
my $ScaffGCntr=0;
my $ScaffCCntr=0;
my $ScaffACntr=0;
my $ScaffTCntr=0;
my $Scafftotal=0;
my $ScaffGCContent=0;
my $SingletonNCntr=0;
my $SingletonGCntr=0;
my $SingletonCCntr=0;
my $SingletonACntr=0;
my $SingletonTCntr=0;
my $Singletontotal=0;
my $SingletonGCContent=0;
my $totalNucleeotides;
my $totalGCContent;
my $totalNCntr=0;
my $totalGCntr=0;
my $totalCCntr=0;
my $totalACntr=0;
my $totalTCntr=0;
my $x;
my $switchScaff=0;
my $switchSingleton=0;
my $fileName=$ARGV[0];
my $window=1;
my $newStart=0;
my $usage="./MarkDup-V1.pl -input file.fasta -window
Nima Rafati $date (nimarafati\@gmail.com)
-input fasta file
-window defualt is 1\n";

&GetOptions (	'h'=>\$helpFlag,
		'input=s' =>\$inputFile,
		'window=i' =>\$window);
if($helpFlag)
{
	die print $usage;
}
if($inputFile eq "" || $window  eq "")
{
	die print $usage;
}
 
open (infile, $fileName);
if ($fileName eq "")
{
        print " please insert the name of the file after the script\n";
        exit;
}

while(<infile>)
{
    $line=chomp($_);
    $x=substr($line,0,1);
print $window;<STDIN>;
    if ( $x eq ">"  &&  $switchScaff == 0)
    {
	$switchScaff=1;
	$line=~ s/>//;
	print $line;<STDIN>;
    }
    if( $x ne ">" &&  $switchScaff == 1 )
    {
	    $line=uc($line);
	if($window == 1)
	{
#	chomp($line);
	#print $line;
	#my $pauze=<STDIN>;
	$ScaffNCntr+= $line =~ tr/N//;
	$ScaffGCntr+= $line =~ tr/G//;
	$ScaffCCntr+= $line =~ tr/C//;
	$ScaffACntr+= $line =~ tr/A//;
	$ScaffTCntr+= $line =~ tr/T//;
#	$switchScaff=0;
	}
	else
	{
		$cntr++;
		$cntrTotal++;
		if($cntr == $window)
		{
			$Scafftotal=$ScaffGCntr+$ScaffCCntr+$ScaffTCntr+$ScaffACntr;
			$ScaffGCContent=($ScaffGCntr+$ScaffCCntr)*100/$Scafftotal;
			$ScaffAllSum=$ScaffGCntr+$ScaffCCntr+$ScaffCAntr+$ScaffTCntr+$ScaffNCntr;
			$ScaffNContent=($ScaffNCntr*100)/$ScaffAllSum;
			print "$newStart\t$cntrTotal\t$ScaffGCContent\n";
		        $ScaffNCntr=0;
        		$ScaffGCntr=0;
       			$ScaffCCntr=0; 
		        $ScaffACntr=0;
		        $ScaffTCntr=0;
			$cntr=0;
			$newStart=$cntrTotal-1;
		}
	}
    }
}
#$Scafftotal=$ScaffGCntr+$ScaffCCntr+$ScaffTCntr+$ScaffACntr;
#$ScaffGCContent=($ScaffGCntr+$ScaffCCntr)*100/$Scafftotal;
#$ScaffAllSum=$ScaffGCntr+$ScaffCCntr+$ScaffCAntr+$ScaffTCntr+$ScaffNCntr;
#$ScaffNContent=($ScaffNCntr*100)/$ScaffAllSum;
#print "N : $ScaffNCntr\n";
#print "G : $ScaffGCntr\n";
#print "C : $ScaffCCntr\n";
#print "A : $ScaffACntr\n";
#print "T : $ScaffTCntr\n";
#print "GC-Content: $ScaffGCContent\n";
#print "N-percent: $ScaffNContent\n";
close infile;

