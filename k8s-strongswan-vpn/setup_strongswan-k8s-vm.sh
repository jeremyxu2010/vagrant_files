yum install -y strongswan

cp -f files/strongswanCert.pem /etc/strongswan/swanctl/x509ca/
cp -f files/k8sVMCert.pem /etc/strongswan/swanctl/x509/
cp -f files/k8sVMKey.pem /etc/strongswan/swanctl/private/

cp -f files/ipsec-k8s-vm.conf /etc/strongswan/swanctl/conf.d/ipsec.conf

systemctl start strongswan-swanctl
systemctl enable strongswan-swanctl
