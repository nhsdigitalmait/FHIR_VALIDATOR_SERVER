#/bin/bash
configDirectory=$PWD
if [ -z "$1" ]
  then
	echo "No config directory supplied. Assuming '" $configDirectory "' as config directory."
  else
    configDirectory=$1
fi

# Update all instances of local dir with docker image directories for all config/contrib entries
sed -i -e 's|/home/riro/TKW-5.0.5/TKW/|/home/service/TKW/|g' ${configDirectory}/tkw-x.multiversion.properties

# Update all output directories with docker image volume directories
sed -i -e "/^tks.evidencemetadata.location/c\tks.evidencemetadata.location /home/service/data/all_evidence" ${configDirectory}/tkw-x.multiversion.properties
sed -i -e "/^tks.validator.reports/c\tks.validator.reports /home/service/data/all_evidence" ${configDirectory}/tkw-x.multiversion.properties
sed -i -e "/^tks.logdir/c\tks.logdir /home/service/data/logs" ${configDirectory}/tkw-x.multiversion.properties
sed -i -e "/^tks.savedmessages/c\tks.savedmessages /home/service/data/all_evidence" ${configDirectory}/tkw-x.multiversion.properties

# Update FHIR profile directory with docker image volume directories (This should be done in a more programatic fasion with a loop - run out of time :-)) 
sed -i -e "/^tks.validator.hapifhirvalidator.stu3.assetdir.ignore/c\tks.validator.hapifhirvalidator.stu3.assetdir.ignore /home/service/fhir/STU3/examples/" ${configDirectory}/tkw-x.multiversion.properties
sed -i -e "/^tks.validator.hapifhirvalidator.stu3.assetdir /c\tks.validator.hapifhirvalidator.stu3.assetdir /home/service/fhir/STU3" ${configDirectory}/tkw-x.multiversion.properties
sed -i -e "/^tks.validator.hapifhirvalidator.stu3.profileversionfilelocation/c\tks.validator.hapifhirvalidator.stu3.profileversionfilelocation /home/service/fhir/STU3/package.json" ${configDirectory}/tkw-x.multiversion.properties

sed -i -e "/^tks.validator.hapifhirvalidator.r4.assetdir.ignore/c\tks.validator.hapifhirvalidator.r4.assetdir.ignore /home/service/fhir/R4/examples/" ${configDirectory}/tkw-x.multiversion.properties
sed -i -e "/^tks.validator.hapifhirvalidator.r4.assetdir /c\tks.validator.hapifhirvalidator.r4.assetdir /home/service/fhir/R4" ${configDirectory}/tkw-x.multiversion.properties
sed -i -e "/^tks.validator.hapifhirvalidator.r4.profileversionfilelocation/c\tks.validator.hapifhirvalidator.r4.profileversionfilelocation /home/service/fhir/R4/package.json" ${configDirectory}/tkw-x.multiversion.properties

# Update Simulator ruleset with docker image directories
sed -i -e 's|/home/riro/TKW-5.0.5/TKW/|/home/service/TKW/|g' ${configDirectory}/simulator_config/test_tks_rule_config.multiversion.txt
# Update Validator ruleset with docker image directories
sed -i -e 's|/home/riro/TKW-5.0.5/TKW/|/home/service/TKW/|g' ${configDirectory}/validator_config/validator.multiversion.conf

