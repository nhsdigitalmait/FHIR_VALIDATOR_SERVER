echo $PWD
echo "Running as UID $UID"
echo "trustStore = " $trustStore
echo "trustStorePassword = " $trustStorePassword
echo "keyStore = " $keyStore
echo "keyStorePassword = " $keyStorePassword
echo "terminologyserveraccesstokenlocation = " $terminologyserveraccesstokenlocation
echo "Making sure output structure is available"
cd /home/service/data
tar -xvf /home/service/TKW/config/FHIR_VALIDATOR_SERVER/tkwoutputstructure.tar
cd /home/service

if [ -z "$terminologyserveraccesstokenlocation"]
then
	javastring="-Djava.net.preferIPv4Stack=true -XX:+UseContainerSupport -XX:MaxRAMPercentage=80.0 -jar /home/service/TKW/TKW-x.jar -httpinterceptor /home/service/TKW/config/FHIR_VALIDATOR_SERVER/tkw-x.multiversion.properties"
else
	javastring="-Djava.net.preferIPv4Stack=true -Duk.nhs.digital.mait.tkwx.tk.internalservices.validation.hapifhir.r4.terminologyserveraccesstokenlocation=$terminologyserveraccesstokenlocation -XX:+UseContainerSupport -XX:MaxRAMPercentage=80.0 -jar /home/service/TKW/TKW-x.jar -httpinterceptor /home/service/TKW/config/FHIR_VALIDATOR_SERVER/tkw-x.multiversion.properties"
fi

# set the external properties folder
export TKWROOT="/home/service/TKW"
echo TKWROOT: $TKWROOT
export EXT_CONFIG_ROOT="/home/service/config"
echo External properties directory: $EXT_CONFIG_ROOT
export FHIR_ASSETS_NPMTAR_ROOT="/home/service/fhir/R4"
echo FHIR Assets NPM tars directory: $FHIR_ASSETS_NPMTAR_ROOT
export FHIR_ASSETS_STU3_ROOT="/home/service/fhir/STU3"
echo FHIR DSTU3 NPM directory: $FHIR_ASSETS_STU3_ROOT

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
