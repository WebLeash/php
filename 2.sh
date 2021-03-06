#!/bin/bash

commandusage="Usage: $0 -p <path to csv files> -l <path to log file> -t <live or test>"

	while getopts ":p:l:t:" option;
	do
		case "${option}" in
			p) 
			  csv_path=${OPTARG};;
			l) 
			   log_path=${OPTARG};;
			t) 
			   live=${OPTARG};;
			*) 
			    error "$commandusage" "init_env"
	           	    exit 1 
			    ;;
	   	esac
	done

	if [ -z $csv_path ]; then
		echo "Please provide valid path for csv files"
		echo "$commandusage init_env"
		exit 1
	fi
	if [ ! -d $csv_path ]; then
		echo  ">$csv_path, not found" "init_env"
		exit 1
	fi

	if [ -z $log_path ]; then
		echo "Please provide path for log file"
		echo "$commandusage init_env"
		exit 1
	fi

	if [ ! -d $log_path ]; then
		echo ">$log_path< not found init_env"
		exit 1
	fi

	if [ -z $live ]; then
		echo "Nothing passed for Live or Test/Live mode, setting mode to test"
		live=test
		URL=$URL_test
	fi
