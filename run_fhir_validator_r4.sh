#!/bin/bash
#
#
if [[ "$1" == "-d" ]]
then
docker-compose -f docker-compose_fhir_validator_r4.yml up -d
else
	docker-compose -f docker-compose_fhir_validator_r4.yml up
fi
