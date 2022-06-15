#!/bin/bash
# 
# Script for individually validating each message 
#

messageArchiveLocation="/home/riro/TKW-5.0.5/TKW/config/FHIR_VALIDATOR_SERVER/validatorMessages"
messages_for_validationLocation="/home/riro/TKW-5.0.5/TKW/config/FHIR_VALIDATOR_SERVER/messages_for_validation"
config_location="/home/riro/TKW-5.0.5/TKW/config/FHIR_VALIDATOR_SERVER"
cd $config_location

#Give user time to change their mind
echo "Individually Validating Messages"
echo "Delete all previous messages in messages_for_validation"
read -n 1 -p "Press any key to continue..."
echo "continuing"


#Delete all existing validation messages
rm $messages_for_validationLocation/*.[xX][mM][lL]

#Loop through all messages 
for filepath in $messageArchiveLocation/*.[xX][mM][lL]; do
	[ -e "$filepath" ] || continue

	# get the filename only from filepath
	xbase=${filepath##*/}
	filename=${xbase%.*}

	#copy request file into messages_for_validation folder
	cp $filepath  $messages_for_validationLocation
	
	#validate using TKW
	echo validating $filepath
	java -jar ../../TKW-x.jar -validate tkw-x.multiversion.properties

	#remove the request file from messages_for_validation folder
	rm $messages_for_validationLocation/*.[xX][mM][lL]
done
