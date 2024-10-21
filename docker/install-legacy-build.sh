cd /

wget https://github.com/jwgrenning/legacy-build/archive/refs/heads/master.zip
unzip master.zip
rm master.zip
mkdir /legacy-build
mv legacy-build-master/*.sh /legacy-build
rm -r legacy-build-master

echo "For rebuild legacy-build update 10/21/2024 2x"
