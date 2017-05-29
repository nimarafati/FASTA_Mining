#!/usr/bin/perl
#chop sequences in one file into different file based on the number of sequences per reads by user. 
$infile=$ARGV[0];
print "How many sequence you have?";
$sequenceNumber=<STDIN>;
#chomp($sequenceNumber);
print "How many sequence per file?";
$sequencesPerFile=<STDIN>;
#chomp($sequencesPerFile);
my $cntr=0;
my $filecntr=0;
$fileNumber=int($sequenceNumber/$sequencesPerFile);
#for (my $i=0; $i<$fileNumber;$i++)
#{
#	my $newOutput="output$i";
#	open ($newOutput, ">$infile.$i");
#	print $newOutput;$pauze=<STDIN>;
#}
#$outputFile=$output."0";
open(output0,">$infile.0");
$outputfile="output0";
open (inputF, $infile) || die print "there is no file";
while(<inputF>)
{
	$line=$_;
	if (/^>/)
	{
		$cntr++;
		if ($cntr < $sequencesPerFile + 1)
		{
			print $outputfile $line;
		}
		else
		{
			$filecntr++;
			$outputfile="output$filecntr";
			open($outputfile, ">$infile.$filecntr");
			print $outputfile $line;
			$cntr="";
		}
	}
	else
	{
		print $outputfile $line;
	}
}
close inputF;
for (my $j=0; $j<$fileNumber;$j++)
{
		$closeFile="output$j";
		close $closeFile;
}
