#!/bin/bash
#The argument is to label the container. If non is given then a date will be used
label=$1
if [ $# -eq 0 ]
  then
    echo "No arguments supplied - date will be used for label"
	label=`date +%Y%m%d`
fi

#Build the docker image
docker build -f Dockerfile.1000 -t fhir_validator_config .
#Tag the docker image with today's date or provided label
docker tag fhir_validator_config nhsdigitalmait/fhir_validator_config:$label
echo Docker Image tagged with $label
