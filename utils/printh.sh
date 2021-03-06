#!/bin/bash

while getopts "hf:" option; do
	case ${option} in 
		h ) # display help
			echo "Usage:"
			echo -e "\tprinth file\t\tprint the header the file."
			echo -e "\tprinth -h\t\tdisplay the help message."
			echo -e "\tprinth -f\t\tdisplay header and the first line."
			exit 0
			;;
		f )
			shift
			file=$1;shift
			firstline=`sed -n 2p $file`
			head -n1 $file | awk -F "\t" -v firstline="$firstline" '{OFS="\t";split(firstline,a,"\t");for(i=1;i<=NF;i++){print i,$i,a[i]}}' 
			exit 0
			;;
		\? )
			echo "Invalid Option: -$OPTARG" 1>&2
          	exit 1
			;;
		: )
			echo "Invalid Option: -$OPTARG requires an argument" 1>&2
			exit 1
			;;
	esac
done
shift $((OPTIND -1))

file=$1;shift
head -n1 $file | awk -F "\t" '{OFS="\t";for(i=1;i<=NF;i++){print i,$i}}'
