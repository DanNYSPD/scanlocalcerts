#!/bin/bash

if [ "$1" == "" ]; then
    echo "Positional parameter 1 is empty"
    exit
fi
    
echo "Certificate $1"

#now I should get the issuer

issuer=$(openssl x509 -inform pem -in $1  --subject --noout)
echo $issuer

#Now that I have the issuer I will look for the certificate which sucjetc match with our issuer
echo "for:"
for x in *.cer; do
	echo "$x:"
	issuer_x=$(openssl x509 -inform dem --issuer --noout -in $x)
	echo $issuer_x
done

