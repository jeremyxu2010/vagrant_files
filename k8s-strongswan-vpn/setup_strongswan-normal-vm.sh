yum install -y strongswan

cp -f files/strongswanCert.pem /etc/strongswan/swanctl/x509ca/
cp -f files/normalVMCert.pem /etc/strongswan/swanctl/x509/
cp -f files/normalVMKey.pem /etc/strongswan/swanctl/private/

cp -f files/ipsec-normal-vm.conf /etc/strongswan/swanctl/conf.d/ipsec.conf

systemctl start strongswan-swanctl
systemctl enable strongswan-swanctl