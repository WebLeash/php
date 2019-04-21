#!/usr/bin/env bash
workspace=$(pwd)
: "${GO_PIPELINE_LABEL:=DEFAULT_VALUE}"
package_name=""
package_version="RELEASE"
package_type="jar"
package_repository="uk-releases"
package_group=""
package_artifact=""
source_code_repository=""
usage(){
	echo "usage: $0 options"
	echo "Download Artifact from Nexus 3 - Scan to Nexus IQ"
	ENV VARS:
 	echo "GO_PIPELINE_LABEL Mandatory.  The GoCD pipeline details."
	echo "OPTIONS:"
  	echo "-n               Mandatory. Package Name. PACKAGE_ARTIFACT (Pipeline Parameter)"
  	echo "-v               Mandatory. Package version.  Defaults to "RELEASE". ${GO_PIPELINE_LABEL}"
  	echo "-t [jar|war|ear] Mandatory. Package type.  Defaults to "jar". PACKAGE_TYPE (Pipeline Parameter)"
  	echo "-r               Mandatory. Package repository.  PACKAGE_REPOSITORY (Pipeline Parameter)"
  	echo "-g               Mandatory. Package group id. PACKAGE_GROUP (Pipeline Parameter)"
  	echo "-a               Mandatory. Package artifact id. PACKAGE_ARTIFACT (Pipeline Parameter)"
}
init_vals(){

    echo "Nexus IQ Scan"
    echo "GoCD label ....... ${GO_PIPELINE_LABEL}"
    echo "Package name ..... ${package_name}"
    echo "Package version .. ${package_version}"
    echo "Package type ..... ${package_type}"
    echo "Package repository ${package_repository}"
    echo "Package group .... ${package_group}"
    echo "Package artifact . ${package_artifact}"

}
# Get the parameters
while getopts n:v:t:r:g:a:b:s:S:Z: option; do
    case "$option" in
        n) package_name=$OPTARG;;
        v) package_version=$OPTARG;;
        t) package_type=$OPTARG;;
        r) package_repository=$OPTARG;;
        g) package_group=$OPTARG;;
        a) package_artifact=$OPTARG;;
        ?) usage
           exit 1;;
    esac
done
if [ -z "${package_name}" -o -z "${package_version}" -o -z "${package_type}" \
     -o -z "${package_repository}" -o -z "${package_group}" -o -z "${package_artifact}" ] ; then
    usage
    exit 1
fi
init_vals
cd "${workspace}"
echo "Running from ${workspace}"
echo "Tidying up current directory".
binary_filename="${package_artifact}-${package_version}.${package_type}"
~/build-scripts/nexus_get_artifact.py -r ${package_repository} -g ${package_group} -n ${package_name} -v ${package_version} -t ${package_type}

echo "Now ready for the Nexus IQ Scan check what it's brought down from Nexus"
if [ $? -ne 0 ] ; then
    echo "ABORTING. Could not download binary file"
    exit 1
fi


