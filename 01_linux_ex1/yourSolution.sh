tar -zxvf secretGenerator.tar.gz
cd src/
chmod +x generateSecret.sh
mkdir secretDir
touch secretDir/.secret
chmod u+rw secretDir/.secret
chmod go-rw secretDir/.secret
rm maliciousFiles/*
rmdir maliciousFiles/
rm important.link
./generateSecret.sh