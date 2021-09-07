########################################################
# nimarafati@gmail.com	                               #
# Please cite the script by referencing to github      #
# repository 					       #
########################################################

import argparse
import os
import subprocess
#import matplotlib.pyplot as pl

parser = argparse.ArgumentParser(description='This script reports identical sequences present in a fasta file. You can set the similarity level by identity_perc. It is based on blat output (psl format)')

parser.add_argument('-fa',   '-fasta', 	help = 'A fasta file')
parser.add_argument('-idp',  '-identity_perc', help = 'Identity percent (default=70)', type = int)
parser.add_argument('-dist', '-distribution',  help = 'Report distribution of identity levels between sequences (default = True)', default = True, action='store_true') 
args = parser.parse_args()


#Empty list to save idetity percents
idp_list = []

# Set identity percentage cut-off if it was not provided by the user
if args.idp is None:
	args.idp = 70
print(args.idp)
print(args.dist)
def run_blat(fa_file):
	print('Running blat.....')
	cmd = 'blat -t=dna -q=dna -noHead ' + args.fa + ' ' + args.fa + ' ' + args.fa + '.psl'
	print(cmd)
	process = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
	process.wait()
	print('Blat is done')


#Running blat
run_blat(args.fa)
blat_output = args.fa + '.psl'

#Parsing blat output
psl_file = open(blat_output, 'r')
f = open(args.fa + 'gene_trans.txt', 'w')
for line in psl_file:
	line = line.strip()
	line_list = line.split()
	match_length = line_list[0]
	query_name = line_list[9]
	target_name = line_list[13]
	query_length = line_list[10]
	if query_name != target_name:
		idp_match = int(match_length) / int(query_length)
		if args.dist  == True:
			idp_list.append(idp_match)
		if int(idp_match) >= int(args.idp):
			f.write(query_name + '\t' + target_name + '\n')


#Print histogram of idp distribution
#if args.dist  == True:
#	fig = pl.hist(idp_list,normed=0)
#	pl.xlabel("Identity percent")
#	pl.ylabel("Frequency")
#	pl.savefig("abc.png")

