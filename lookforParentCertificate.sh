#!/bin/bash

if [ "$1" == "" ]; then
    echo "Positional parameter 1 is empty"
    exit
fi
    
echo "Certificate $1"

#now I should get the issuer

issuer=$(openssl x509 -inform pem -in $1  --issuer --noout|sed 's/.*issuer=//' )
echo $issuer

#Now that I have the issuer I will look for the certificate which sucjetc match with our issuer
echo "for:"
find . -iname "*.cer" | while read x 
do
	echo "$x:"
	issuer_x=$(openssl x509 -inform dem --subject --noout -in $x | sed 's/.*subject=//')
	echo $issuer_x
	#exit
	if [[ $issuer == $issuer_x ]];then
		echo "certificado $x es el padre"
		echo "$1 --> padre $x";
		newDir=$(echo  $1 | sed 's/\..*//')
		echo $newDir
		mkdir $newDir
		certFileName=$(basename $x)
		cp $x "$newDir/$certFileName"
		#for last I copy the origin cert
		cp $1 "$newDir/$1"
		issuer_issuer=$(openssl x509 -inform der -in $x  --issuer --noout|sed 's/.*issuer=//' )
		echo $issuer_issuer
		exit
	fi
done

