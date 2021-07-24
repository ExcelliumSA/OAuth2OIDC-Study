#!/bin/bash
##############################################
# Script to generate the markdown content 
# to use on https://markmap.js.org/repl/
# to generate the mind map image
##############################################
work_file="/tmp/mindmap.md"
prefixes=(CLT API BFF STS)
echo "# Validations" > $work_file
for prefix in ${prefixes[@]}; do
	check_count=$(grep -Ec "\-\s$prefix[0-9]{2}:" OAauth2_OIDC_Security_Validations.md)
	component_name=$prefix
	case $prefix in
		CLT)
			component_name="Client"
			;;
		STS)
			component_name="Security Token Service"
			;;	
		BFF)
			component_name="Backend-For-Frontend"
			;;			
	esac
	echo "## $component_name: $check_count checks" >> $work_file
done
echo "[+] Use the following content on 'https://markmap.js.org/repl/' to generate the mind map:"
cat $work_file
