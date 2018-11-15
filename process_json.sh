#!/usr/bin/env bash 
#Ver 1.0
#------------------------------------------------------------------
# http://no-proxy.app.c9.equifax.com:3128/
# http://proxy-user.prod.edc.equifax.com:18717
# 172.18.100.15:18717/
#--------------------------------------------------------------------
set -x

init_env(){
	stdout "Setting Env"
	csv_path=""
	log_path=""
	live=""
	user="Admin" #parameter (1) ##NEED TO SET THIS AS ARGUMENR
	pass="SamplePassword" #parameter (2) ##NEED TO SET THIS AS ARGUMENR
	URL="https://equifax.service-now/api/equif/v2/packaging_and_release_api/post_application"
	URL_Test="https://servicenowtest.equifax.com"
	commandusage="Usage: $0 -p <path to csv files> -l <path to log file> -t <live or test>"
#-----------------------------------------------------------------
#http_proxy="http://proxy-user.prod.edc.equifax.com:18717"
#https_proxy="https://proxy-user.prod.edc.equifax.com:18717"
#http_proxy="http://172.18.100.15:18717"
#https_proxy="https://172.18.100.15:18717"
#http_proxy="http://no-proxy.app.c9.equifax.com:3128/"
#https_proxy="https://no-proxy.app.c9.equifax.com:3128/"
#-----------------------------------------------------------------
	if [[ -n ${https_proxy} ]] ; then
		export https_proxy 
	fi

	if [[ -n ${http_proxy} ]] ; then
		export http_proxy 
	fi

	while getopts p:l:t: option;
	do
		case "$option" in
		p) csv_path=$OPTARG;;
		l) log_path=$OPTARG;;
		t) live=$OPTARG;;
		?) error "$commandusage" "init_env"
	           exit 1 
		;;
	   esac
	done

	if [ -z $csv_path ]; then
		stdout "Please provide valid path for csv files"
		error "$commandusage" "init_env"
		exit 1
	fi
	if [ ! -d $csv_path ]; then
		error ">$csv_path, not found" "init_env"
		exit 1
	fi

	if [ -z $log_path ]; then
		stdout "Please provide path for log file"
		error "$commandusage" "init_env"
		exit 1
	fi

	if [ ! -d $log_path ]; then
		error ">$log_path< not found" "init_env"
		exit 1
	fi

	if [ -z $live ]; then
		stdout "Nothing passed for Live or Test/Live mode, setting mode to test"
		live=test
		URL=$URL_test
	fi
	if [ $live == "live" ]; then
		stdout "Live URL Set"
	fi
	stdout "Checking host (https) protocol"
	check_service

	export csv_path log_path live URL 

}

stdout(){
	output=$1
	echo "$(date "+%Y-%m-%d %H:%M:%S") [INFO] : $output"
}

error(){

	echo "$(date "+%Y-%m-%d %H:%M:%S") [ERROR] : $1 in func: $2"
	echo "$(date "+%Y-%m-%d %H:%M:%S") [ABORTING] $0"
	exit 1

}
curl_check(){

	if [ "$1" -ne 0 ]; then
		error "Curl returned error ($1)" "($2)"
	else
		stdout "HTTP Active func: $2"
	fi

}

check_service() {
	curl --connect-timeout 5 --silent --output /dev/null http://www.google.com
	curl_check "$?" "check_service"
}

validate_http_response(){
	
	http_re="$1"
	
	echo "$http_re" |grep "200 OK" &> /dev/null
        if [ $? -ne 0 ] ; then
                error "Invalid http response $http_re" "$2"
        fi

}

process_JSON(){

	cont_type="Content-Type: application/json"
	app_tye="Accept: application/json"
	count=0
	for file in $(ls -t ${csv_path}/*.csv)
	do
		set -x exec >>${csv_path}/$file
		json=""
		json=$(cat ${file})
		if [ -z $json ]; then
			error "No data in $f" "process_JSON" ## ABORTS IF a FILE HAS NO JSON
		fi
		response=$(curl -i --user [ServiceAccount]:[ServiceAccountPassword] -H ${cont_type} -H ${app_type} -X POST -d '${json}' $URL)
		validate_http_response $response "process_JSON"
		count=$(expr $count + 1)

	done
	stdout "Done! Success Processed ($count)"
#--------------------------------------------------
}
# Start
#-----------
init_env
check_service
process_JSON
