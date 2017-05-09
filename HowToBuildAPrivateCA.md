# How to setup your own private certificate authority

1. Create your private key
```
# the simple version
openssl genrsa -out myRootCA.key 2048

# the password saved version
openssl genrsa -des3 -out myRootCA.key 2048
```

2. Create a certificate and sign it with your private key
```
# create your own root certificate
openssl req -x509 -new -nodes -key myRootCA.key -sha256 -days 1024 -out myRootCA.pem
```

3. Install root certificate in keystore for browsers and stuff

4. Create a key for your machine/service that want provide SSL
```
openssl genrsa -out machine.key 2048
```

5. Create a certificate signing request
```
openssl req -new -key machine.key -out machine.csr
```

6. Sign the request and get a signed certificate
```
openssl x509 -req -in machine.csr -CA myRootCA.pem -CAkey myRootCA.key -CAcreateserial -out machine.crt -days 500 -sha256
```

