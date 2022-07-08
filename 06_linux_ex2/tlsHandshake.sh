curl -X POST  http://16.16.53.16:8080/clienthello -H "Content-Type: application/json" -d '{ "clientVersion": "3.2", "message": "Client Hello"}' > A
cat A | jq -r '.sessionID'
SESSION_ID=$(!!)
echo $SESSION_ID
cat A | jq -r '.serverCert' > cert.pem
openssl verify -CAfile cert-ca-aws.pem cert.pem
VERIFICATION_RESULT=$( openssl verify -CAfile cert-ca-aws.pem cert.pem )

if [ "$VERIFICATION_RESULT" != "cert.pem: OK" ]; then
  echo "Server Certificate is invalid."
  exit 1
fi
openssl rand -base64 32 > masterkey.txt
openssl smime -encrypt -aes-256-cbc -in masterKey.txt -outform DER cert.pem | base64 -w 0
MASTER_KEY=$(!!)
curl -X POST  http://16.16.53.16:8080/keyexchange -H "Content-Type: application/json" -d '{ "sessionID": "'$SESSION_ID'", "masterKey": "'$MASTER_KEY'", "sampleMessage": "Hi server, please encrypt me and send to client!" }' > B.txt
cat B.txt | jq -r '.encryptedSampleMessage' > encSampleMsg.txt
cat encSampleMsg.txt | base64 -d > encSampleMsgReady.txt

