echo $PWD
echo "Running as UID $UID"
echo "trustStore = " $trustStore
echo "trustStorePassword = " $trustStorePassword
echo "keyStore = " $keyStore
echo "keyStorePassword = " $keyStorePassword
echo "TERMINOLOGY_SERVER_ACCESS_TOKEN_ROOT = " $TERMINOLOGY_SERVER_ACCESS_TOKEN_ROOT
echo "Making sure output structure is available"
cd /home/service/data
tar -xvf /home/service/TKW/config/FHIR_VALIDATOR_SERVER/tkwoutputstructure.tar
cd /home/service

if [ -f "$TERMINOLOGY_SERVER_ACCESS_TOKEN_ROOT/fhir_terminology_server_access_token.txt" ]
then
	javastring="-Djava.net.preferIPv4Stack=true -XX:+UseContainerSupport -XX:MaxRAMPercentage=80.0 -jar /home/service/TKW/TKW-x.jar -httpinterceptor /home/service/TKW/config/FHIR_VALIDATOR_SERVER/tkw-x.multiversion.properties"
else
	javastring="-Djava.net.preferIPv4Stack=true -Duk.nhs.digital.mait.tkwx.tk.internalservices.validation.hapifhir.r4.terminologyserveraccesstokenlocation=$TERMINOLOGY_SERVER_ACCESS_TOKEN_ROOT/fhir_terminology_server_access_token.txt -XX:+UseContainerSupport -XX:MaxRAMPercentage=80.0 -jar /home/service/TKW/TKW-x.jar -httpinterceptor /home/service/TKW/config/FHIR_VALIDATOR_SERVER/tkw-x.multiversion.properties"
fi


# decide whether its TLSMA or not
if [ "$trustStore" == 'default' ]
then
	#ClearText
	java -version
	echo java $javastring
	java $javastring
else
	#TLSMA
	java -version
	java -Djavax.net.ssl.trustStore=$trustStore -Djavax.net.ssl.trustStorePassword=$trustStorePassword -Djavax.net.ssl.keyStore=$keyStore -Djavax.net.ssl.keyStorePassword=$keyStorePassword $javastring
fi
