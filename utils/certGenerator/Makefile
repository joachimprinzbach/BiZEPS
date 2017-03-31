CA_NAME=DockerHost
SERVER_NAME=DockerHost
SERVER_ALTNAMES=DNS:${SERVER_NAME},IP:127.0.0.1
SERVER_BIND=0.0.0.0

SYSTEMD_FILE=/etc/systemd/system/docker.service.d/docker-tls.conf
CERT_DIR=/etc/docker/certs

CA_CERT=ca-cert.pem
CA_KEY=ca-key.pem
CA_SRL=$(basename ${CA_CERT}).srl
CA_DAYS=3650

SERVER_CERT=server-cert.pem
SERVER_KEY=server-key.pem
SERVER_CSR=server.csr
SERVER_DAYS=3650

CLIENT_NAME=client
CLIENT_CERT=client-cert.pem
CLIENT_KEY=client-key.pem
CLIENT_CSR=client.csr
CLIENT_DAYS=3650

EXT_FILE=extfile.cnf

all: ca server client

ca:
	openssl genrsa -out ${CA_KEY} 4096
	openssl req -new -x509 -sha256 \
	  -subj "/CN=${CA_NAME}" \
	  -days ${CA_DAYS} \
	  -key ${CA_KEY} \
	  -out ${CA_CERT}

server:
	openssl genrsa -out ${SERVER_KEY} 4096
	openssl req -new -sha256 \
	  -subj "/CN=${SERVER_NAME}" \
	  -key ${SERVER_KEY} \
	  -out ${SERVER_CSR}
	echo subjectAltName = ${SERVER_ALTNAMES} > ${EXT_FILE}
	openssl x509 -req -sha256 \
	  -in ${SERVER_CSR} \
	  -days ${SERVER_DAYS} \
	  -CA ${CA_CERT} \
	  -CAkey ${CA_KEY} \
	  -CAcreateserial \
	  -extfile ${EXT_FILE} \
	  -out ${SERVER_CERT}
	rm ${SERVER_CSR}
	rm ${EXT_FILE}

client:
	openssl genrsa -out ${CLIENT_KEY} 4096
	openssl req -new -sha256 \
	  -subj "/CN=${CLIENT_NAME}" \
	  -key ${CLIENT_KEY} \
	  -out ${CLIENT_CSR}
	echo extendedKeyUsage = clientAuth > ${EXT_FILE}
	openssl x509 -req -sha256 \
	  -in ${CLIENT_CSR} \
	  -days ${CLIENT_DAYS} \
	  -CA ${CA_CERT} \
	  -CAkey ${CA_KEY} \
	  -CAcreateserial \
	  -extfile ${EXT_FILE} \
	  -out ${CLIENT_CERT}
	rm ${CLIENT_CSR}
	rm ${EXT_FILE}

install:
	mkdir -p ${CERT_DIR}
	install -m0400 ${CA_KEY} ${SERVER_KEY} ${CLIENT_KEY} ${CERT_DIR}
	install -m0444 ${CA_CERT} ${SERVER_CERT} ${CLIENT_CERT} ${CERT_DIR}
	install -m0644 ${CA_SRL} ${CERT_DIR}
	mkdir -p $(dir ${SYSTEMD_FILE})
	echo [Service] > ${SYSTEMD_FILE}
	echo ExecStart= >> ${SYSTEMD_FILE}
	echo ExecStart=/usr/bin/dockerd \
	  -H=${SERVER_BIND}:2376 \
	  --tlsverify \
	  --tlscacert=$(abspath ${CERT_DIR}/${CA_CERT}) \
	  --tlscert=$(abspath ${CERT_DIR}/${SERVER_CERT}) \
	  --tlskey=$(abspath ${CERT_DIR}/${SERVER_KEY}) \
	   >> ${SYSTEMD_FILE}
	systemctl daemon-reload
