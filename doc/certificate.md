# Dump the content of a public key certificate

Command:

    openssl x509 -text -noout -in "${server_cert}"

Result:

    Certificate:
        Data:
            Version: 1 (0x0)
            Serial Number: 1 (0x1)
            Signature Algorithm: sha256WithRSAEncryption
            Issuer: C = FR, ST = Paris, L = Parys, O = Certification Authority, OU = IT, CN = ca.com
            Validity
                Not Before: Dec 17 10:57:59 2019 GMT
                Not After : Oct 25 10:57:59 2029 GMT
            Subject: C = FR, ST = Paris, L = Parys, O = Your Company 1, OU = IT, CN = client.com
            Subject Public Key Info:
                Public Key Algorithm: rsaEncryption
                    RSA Public-Key: (2048 bit)
                    Modulus:
                        00:9e:98:fe:dc:d1:58:1a:33:69:93:fb:b1:20:91:
                        f5:da:20:4b:28:9d:0f:61:50:cf:0c:63:74:ae:4a:
                        a3:3a:56:76:f4:7e:fa:ed:14:fb:01:10:91:fa:b4:
                        a2:a7:7b:e2:01:8c:f5:1b:4f:e2:e9:29:8e:05:9f:
                        e5:c1:1f:46:64:9b:4d:eb:50:2d:ef:48:ba:9f:57:
                        d1:f4:05:ae:94:15:4e:2f:ce:f6:3b:08:01:c0:11:
                        0f:c5:d5:32:4b:28:06:6b:fe:a8:b7:5c:30:99:63:
                        71:59:c9:40:ab:a8:c8:ce:ee:00:ab:7a:69:d3:a4:
                        d3:4a:94:61:3e:47:1b:e6:d4:b9:86:f1:09:92:d0:
                        6a:20:e6:91:a0:09:34:1b:8b:7d:23:c3:6e:75:c1:
                        43:14:0e:dd:ec:b7:83:b7:20:a4:a5:29:ee:d1:17:
                        dc:30:e4:17:99:d2:ee:36:49:c4:8d:26:16:f5:d5:
                        d3:88:ca:4d:09:0d:71:04:eb:e7:1c:65:bf:7f:2e:
                        28:54:c6:6c:a2:40:ee:e7:d8:71:9b:d2:17:4d:d5:
                        26:a7:30:79:9d:c5:8e:cb:61:ff:0b:75:38:8d:30:
                        80:70:c8:39:1a:26:71:6d:3a:f0:3b:38:00:c9:36:
                        de:7f:34:62:dd:7f:1c:f4:83:78:a2:4d:73:09:01:
                        bb:99
                    Exponent: 65537 (0x10001)
        Signature Algorithm: sha256WithRSAEncryption
             72:8b:51:fe:d2:00:08:db:c1:5c:db:fd:1c:69:4a:61:6e:89:
             08:41:5a:17:63:4e:2d:c1:7c:0f:d2:19:23:db:62:ca:6e:33:
             e5:25:52:22:d5:d7:c5:17:81:1b:a3:af:0f:6e:3a:a9:76:9a:
             d0:8a:02:39:9e:4f:29:a7:3c:3d:1b:26:55:f0:4a:85:4e:81:
             98:b5:47:91:0c:57:e0:c7:1c:0f:7b:ce:bc:3a:ba:f3:27:74:
             54:25:44:49:df:a6:17:60:25:31:09:6b:f6:ec:90:12:09:2a:
             10:4a:99:4e:a9:42:6b:f6:c9:53:32:04:cd:0d:0c:4e:ba:a8:
             f7:c9:65:b9:79:76:e2:4b:58:11:b4:a5:a5:cc:75:bc:71:05:
             a9:a5:58:ca:ab:fa:f5:77:91:d3:0a:00:7d:a7:e6:78:d1:2d:
             73:97:5f:c4:03:92:c4:3e:17:ef:2d:05:b3:7d:c7:e6:29:30:
             1a:ac:38:0b:82:25:87:a1:44:11:70:83:52:fc:50:df:f2:70:
             d4:a6:83:93:7f:63:e6:be:ce:85:8b:38:15:53:3d:ce:ad:9a:
             54:e6:c2:e4:49:31:03:de:b8:a3:32:d5:cf:6b:99:12:fb:28:
             a0:f8:94:88:f8:e3:d3:9d:6d:d4:9e:48:bb:40:d1:22:0c:0b:
             13:cb:9a:da

A public key certificate contains the following data:

The identity of the certificate owner.

    Subject: C = FR, ST = Paris, L = Parys, O = Your Company 1, OU = IT, CN = client.com

the identity of the certification authority that issued the certificate.

    Issuer: C = FR, ST = Paris, L = Parys, O = Certification Authority, OU = IT, CN = ca.com

The validity period of the certificate.

    Validity
        Not Before: Dec 17 10:57:59 2019 GMT
        Not After : Oct 25 10:57:59 2029 GMT

The public key of the certificate owner.

    Subject Public Key Info:
        Public Key Algorithm: rsaEncryption
            RSA Public-Key: (2048 bit)
            Modulus:
                00:9e:98:fe:dc:d1:58:1a:33:69:93:fb:b1:20:91:
                f5:da:20:4b:28:9d:0f:61:50:cf:0c:63:74:ae:4a:
                a3:3a:56:76:f4:7e:fa:ed:14:fb:01:10:91:fa:b4:
                a2:a7:7b:e2:01:8c:f5:1b:4f:e2:e9:29:8e:05:9f:
                e5:c1:1f:46:64:9b:4d:eb:50:2d:ef:48:ba:9f:57:
                d1:f4:05:ae:94:15:4e:2f:ce:f6:3b:08:01:c0:11:
                0f:c5:d5:32:4b:28:06:6b:fe:a8:b7:5c:30:99:63:
                71:59:c9:40:ab:a8:c8:ce:ee:00:ab:7a:69:d3:a4:
                d3:4a:94:61:3e:47:1b:e6:d4:b9:86:f1:09:92:d0:
                6a:20:e6:91:a0:09:34:1b:8b:7d:23:c3:6e:75:c1:
                43:14:0e:dd:ec:b7:83:b7:20:a4:a5:29:ee:d1:17:
                dc:30:e4:17:99:d2:ee:36:49:c4:8d:26:16:f5:d5:
                d3:88:ca:4d:09:0d:71:04:eb:e7:1c:65:bf:7f:2e:
                28:54:c6:6c:a2:40:ee:e7:d8:71:9b:d2:17:4d:d5:
                26:a7:30:79:9d:c5:8e:cb:61:ff:0b:75:38:8d:30:
                80:70:c8:39:1a:26:71:6d:3a:f0:3b:38:00:c9:36:
                de:7f:34:62:dd:7f:1c:f4:83:78:a2:4d:73:09:01:
                bb:99
            Exponent: 65537 (0x10001)

The algorithm used to sign the certificate.

    Signature Algorithm: sha256WithRSAEncryption

A signature of the certificate body by the issuer's private key.

    72:8b:51:fe:d2:00:08:db:c1:5c:db:fd:1c:69:4a:61:6e:89:
    08:41:5a:17:63:4e:2d:c1:7c:0f:d2:19:23:db:62:ca:6e:33:
    e5:25:52:22:d5:d7:c5:17:81:1b:a3:af:0f:6e:3a:a9:76:9a:
    d0:8a:02:39:9e:4f:29:a7:3c:3d:1b:26:55:f0:4a:85:4e:81:
    98:b5:47:91:0c:57:e0:c7:1c:0f:7b:ce:bc:3a:ba:f3:27:74:
    54:25:44:49:df:a6:17:60:25:31:09:6b:f6:ec:90:12:09:2a:
    10:4a:99:4e:a9:42:6b:f6:c9:53:32:04:cd:0d:0c:4e:ba:a8:
    f7:c9:65:b9:79:76:e2:4b:58:11:b4:a5:a5:cc:75:bc:71:05:
    a9:a5:58:ca:ab:fa:f5:77:91:d3:0a:00:7d:a7:e6:78:d1:2d:
    73:97:5f:c4:03:92:c4:3e:17:ef:2d:05:b3:7d:c7:e6:29:30:
    1a:ac:38:0b:82:25:87:a1:44:11:70:83:52:fc:50:df:f2:70:
    d4:a6:83:93:7f:63:e6:be:ce:85:8b:38:15:53:3d:ce:ad:9a:
    54:e6:c2:e4:49:31:03:de:b8:a3:32:d5:cf:6b:99:12:fb:28:
    a0:f8:94:88:f8:e3:d3:9d:6d:d4:9e:48:bb:40:d1:22:0c:0b:
    13:cb:9a:da

> RSA(SHA256({certificate body}), {issuer's private key})
