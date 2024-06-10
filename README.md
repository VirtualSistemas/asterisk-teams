Imagem Asterisk para Teams Usando Docker

O Objetivo desta imagem, é fazer uma ponte entre o Teams e o seu Servidor SIP

Chamada Teams -> Telefonia
Cliente Teams --- > Servidor Teams ---> imagem ---> Servidor SIP --> Ramal

Chamada Sip -> Teams
Ramal ---> Servidor SIP ---> Imagem ---> Servidor Teams ---> Cliente Teams


Há um docker-compose com as variaveis de ambiente que devem ser configuradas.
Atentar-se as váriaveis TRONCO_HOST e TRONCO_PORTA, onde devem apontar para o Tronco de destino
Atentar-se também ao certificado digital (deverá ter o nome de certificado.pem)
Atentar-se a chave privada (deverá ter o nome de privada.key)

Para buildar a imagem:

docker -t vsgroup/asterisk-teams .

É possível debugar o trafego TLS entre a Imagem e o Teams:

docker exec -it asterisk-teams /usr/bin/sngrep -d lo