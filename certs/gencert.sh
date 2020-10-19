HOSTNAME=$(hostname)
openssl genrsa -out rootCA.key 4096
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1024 -out rootCA.pem \
	-subj "/C=PL/ST=lesserpoland/O=Org/CN=${HOSTNAME}"
openssl genrsa -out client.key 2048
openssl req -new -sha256 -key client.key -out client.csr \
	-subj "/C=PL/ST=lesserpoland/O=Org/CN=${HOSTNAME}"
openssl x509 -req -in client.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out client.pem -days 500 -sha256

openssl genrsa -out server.key 2048
openssl req -new -sha256 -key server.key -out server.csr \
        -subj "/C=PL/ST=lesserpoland/O=Org/CN=${HOSTNAME}"
openssl x509 -req -in server.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out server.pem -days 500 -sha256
