openssl genpkey -outform PEM -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out t3labs.key
openssl req -new -nodes -key t3labs.key -config csrconfig.txt -nameopt utf8 -utf8 -out t3labs.csr
openssl req -x509 -nodes -in t3labs.csr -days 3650 -key t3labs.key -config certconfig.txt -extensions req_ext -nameopt utf8 -utf8 -out t3labs.crt
