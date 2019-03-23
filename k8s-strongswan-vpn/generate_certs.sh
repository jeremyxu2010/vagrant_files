#!/bin/bash

/usr/libexec/strongswan/pki --gen --type ed25519 --outform pem > strongswanKey.pem
/usr/libexec/strongswan/pki --self --ca --lifetime 3652 --in strongswanKey.pem \
           --dn "C=CN, O=strongSwan, CN=strongSwan Root CA" \
           --outform pem > strongswanCert.pem

/usr/libexec/strongswan/pki --gen --type ed25519 --outform pem > k8sVMKey.pem
/usr/libexec/strongswan/pki --req --type priv --in k8sVMKey.pem \
          --dn "C=CN, O=strongSwan, CN=k8s-vm" \
          --san k8s-vm \
          --san 192.168.33.10 \
          --outform pem > k8sVMReq.pem
/usr/libexec/strongswan/pki --issue --cacert strongswanCert.pem --cakey strongswanKey.pem \
            --type pkcs10 --in k8sVMReq.pem --serial 01 --lifetime 1826 \
            --outform pem > k8sVMCert.pem

/usr/libexec/strongswan/pki --gen --type ed25519 --outform pem > normalVMKey.pem
/usr/libexec/strongswan/pki --req --type priv --in normalVMKey.pem \
          --dn "C=CN, O=strongSwan, CN=normal-vm" \
          --san normal-vm \
          --san 192.168.33.11 \
          --outform pem > normalVMReq.pem
/usr/libexec/strongswan/pki --issue --cacert strongswanCert.pem --cakey strongswanKey.pem \
            --type pkcs10 --in normalVMReq.pem --serial 01 --lifetime 1826 \
            --outform pem > normalVMCert.pem