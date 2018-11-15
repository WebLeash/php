#!/usr/bin/env bash 
#Ver 1.0
#------------------------------------------------------------------
#--------------------------------------------------------------------
#set -x

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
		cfile=$(basename $file)
	        echo "$(date "+%Y-%m-%d %H:%M:%S") ">${csv_path}/$cfile.log
		exec 2>>${csv_path}/$cfile.log
		json=""
		json=$(cat ${file})
		if [ "$json" == "" ]; then
			error "No data in $f" "process_JSON" 
		fi
		#response=$(curl -i --user [ServiceAccount]:[ServiceAccountPassword] -H ${cont_type} -H ${app_type} -X POST -d '${json}' $URL)
		response="200 OK"
		validate_http_response "$response" "process_JSON"
		count=$(expr $count + 1)

	done
	stdout "Done! Success Processed ($count)"
#--------------------------------------------------
}
#-------------------------
# Start (main)
#------------------------
if [[ -n ${https_proxy} ]] ; then
	export https_proxy 
fi

if [[ -n ${http_proxy} ]] ; then
	export http_proxy 
fi


while getopts ":p:l:t:" option; do
    case "${option}" in
      p)
      	  csv_path=${OPTARG}
            ;;
      l)
          log_path=${OPTARG}
            ;;
      t)
          live=${OPTARG}
            ;;
      *)
          echo  "$commandusage" "main"
           ;;
    esac
done

if [ -z $csv_path ]; then
	stdout "Please provide valid path for csv files"
	error "$commandusage" "main"
	exit 1
fi
if [ ! -d $csv_path ]; then
	error ">$csv_path, path found" "main"
	exit 1
fi

if [ -z $log_path ]; then
	stdout "Please provide path for log file"
	error "$commandusage" "main"
	exit 1
fi

if [ ! -d $log_path ]; then
	error ">$log_path< path found" "main"
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
process_JSON
