#!/bin/bash

trap 'echo EXIT; [[ RA-TA-TA-TA ]] && pkill asterisk; exit' EXIT

echo "INICIANDO ASTERISK......"
[[ -z "$DOMINIO" ]] && { echo "Erro: Dominio nao configurado"; exit 1; }
[[ -z "$PORTA_TLS" ]] && { echo "Erro: Porta TLS nao configurada"; exit 1; }
[[ -z "$PORTA_UDP" ]] && { echo "Erro: Porta UDP nao configurada"; exit 1; }
[[ -z "$RTP_INICIO" ]] && { echo "Erro: RTP Inicio nao configurado"; exit 1; }
[[ -z "$RTP_FIM" ]] && { echo "Erro: RTP Fim nao configurado"; exit 1; }
[[ -z "$TRONCO_HOST" ]] && { echo "Erro: Tronco Host nao configurado"; exit 1; }
[[ -z "$TRONCO_PORTA" ]] && { echo "Erro: Tronco Porta nao configurado"; exit 1; }
[ -f /etc/asterisk/certs/certificado.pem ] && echo "Certificado Encontrado" || exit 1
[ -f /etc/asterisk/certs/privada.key ] && echo "Chave Privada Encontrado" || exit 1


IPEXTERNO=$(curl -4 --silent ifconfig.io)

echo "IP EXTERNO: $IPEXTERNO"
echo "DOMINIO: $DOMINIO"
echo "PORTA TLS: $PORTA_TLS"
echo "PORTA UDP: $PORTA_UDP"
echo "RTP INICIO: $RTP_INICIO"
echo "RTP FIM: $RTP_FIM"
echo "TRONCO HOST: $TRONCO_HOST"
echo "TRONCO PORTA $TRONCO_PORTA"



[[ -z "$DOMINIO" ]] && { echo "Erro: Dominio nao configurado"; exit 1; }

sed -i "s/ASTERISK_IP_EXTERNO/$IPEXTERNO/g" /etc/asterisk/pjsip.conf
sed -i "s/ASTERISK_PORTA_TLS/$PORTA_TLS/g" /etc/asterisk/pjsip.conf
sed -i "s/ASTERISK_PORTA_UDP/$PORTA_UDP/g" /etc/asterisk/pjsip.conf
sed -i "s/ASTERISK_DOMINIO/$DOMINIO/g" /etc/asterisk/pjsip.conf
sed -i "s/ASTERISK_DOMINIO/$DOMINIO/g" /etc/asterisk/res_pjsip_nat.conf

sed -i "s/ASTERISK_TRONCO_HOST/$TRONCO_HOST/g" /etc/asterisk/pjsip.conf
sed -i "s/ASTERISK_TRONCO_PORTA/$TRONCO_PORTA/g" /etc/asterisk/pjsip.conf


sed -i "s/ASTERISK_RTP_INICIO/$RTP_INICIO/g" /etc/asterisk/rtp.conf
sed -i "s/ASTERISK_RTP_FIM/$RTP_FIM/g" /etc/asterisk/rtp.conf


/usr/sbin/asterisk -cv
