#!/bin/bash
##############################################
# Script to generate the mermaid content 
# to generate the mind map image
##############################################
work_file="/tmp/mindmap.mmd"
echo "[+] Generate the mermaid content for the graph..."
prefixes=(CLT API BFF STS)
dte=$(date +'%Y%m%d')
echo "graph LR" > $work_file
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
	echo "    CHECK([Validations_$dte]) ---|$check_count checks| $prefix([$component_name])" >> $work_file
done
cat $work_file
echo "[+] Generate the PNG image of the graph..."
sha256sum OAauth2_OIDC_Security_Validations.png
npx -p @mermaid-js/mermaid-cli mmdc -i $work_file -o OAauth2_OIDC_Security_Validations.png -t forest
sha256sum OAauth2_OIDC_Security_Validations.png
rm $work_file
