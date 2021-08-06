echo $PWD
echo "Running as UID $UID"
echo "trustStore = " $trustStore
echo "trustStorePassword = " $trustStorePassword
echo "keyStore = " $keyStore
echo "keyStorePassword = " $keyStorePassword
echo "Making sure output structure is available"
cd /home/service/data
tar -xvf /home/service/TKW/config/FHIR_VALIDATOR_SERVER/tkwoutputstructure.tar
cd /home/service
javastring="-XX:+UseContainerSupport -XX:MaxRAMPercentage=80.0 -jar /home/service/TKW/TKW-x.jar -httpinterceptor /home/service/TKW/config/FHIR_VALIDATOR_SERVER/tkw-x.multiversion.properties"
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
