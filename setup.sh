#!/bin/bash

USUARIO=`id -u`
VERSAO=$1

clear
if [ $USUARIO == "0" ]; then
    if [ "$1" != '' ]; then

        echo -e " Instalando pacotes necessários, aguarde... "

        echo -e "============================================================"
        echo -e ""
        echo -e " *** CONFIGURANDO A REDE *** "
        echo -e ""
        echo -e "============================================================"
        echo -e ""
        
        echo ""
        echo " (1) - wan"
        echo " (2) - lan"
        read -p " Selecione o que deseja configurar: [2] " TYPE

        if [ -z $TYPE ]; then
            TYPE="2"  
        fi

        case $TYPE in
            1)
                TYPE="wan"
            ;;
            2)
                TYPE="lan"
            ;;
            *)
                echo ""
                echo -e " Opção Inválida, por padrão será escolhido [2]"
                TYPE="lan"
            ;;
        esac

        echo -e " Configurando a $TYPE, aguarde... "
        sleep 2
        echo -e ""
        echo -e " *** INTERFACES *** "
        echo -e "============================================================"
        sed '/:/!d;s/:.*//;s/^ */ /' /proc/net/dev
        echo -e "============================================================"
        echo -e ""
        read -p " Qual interface você gostaria de configurar: [eth0] " INT 

        if [ -z $INT ]; then
            INT="eth0"
        fi

        echo -e "# This file describes the network interfaces available on your system" > "/etc/network/interfaces"
        echo -e "# and how to activate them. For more information, see interfaces(5)." >> "/etc/network/interfaces" 
        echo -e "" >> "/etc/network/interfaces"
        echo -e "source /etc/network/interfaces.d/*" >> "/etc/network/interfaces"
        echo -e "" >> "/etc/network/interfaces"
        echo -e "# The loopback network interface" >> "/etc/network/interfaces"
        echo -e "auto lo" >> "/etc/network/interfaces"
        echo -e "iface lo inet loopback" >> "/etc/network/interfaces"
        echo -e "" >> "/etc/network/interfaces"
        echo -e "auto $INT" >> "/etc/network/interfaces"
        echo -e "iface $INT inet dhcp" >> "/etc/network/interfaces"
        echo -e "" >> "/etc/network/interfaces"
        
        case $TYPE in
            wan)            
                echo ""
                echo " (1) - dhcp"
                echo " (2) - static"
                read -p " Como deseja usar a interface: [2] " MODO

                if [ -z $MODO ]; then
                    MODO="2"
                fi

                case $MODO in
                    1)
                        MODO="dhcp"
                    ;;
                    2)
                        MODO="static"
                    ;;
                    *)
                        echo ""
                        echo -e " Opção Inválida, por padrão será escolhido [2]"
                        MODO="static" 
                    ;;
                esac

                case $MODO in
                    static)
                        read -p " Digite o ip [192.168.0.254]: " IP

                        if [ -z $IP ]; then
                            IP="192.168.0.254"
                        fi
            
                        echo ""
                        echo " (1) - 255.255.255.0"
                        echo " (2) - 255.255.0.0"
                        echo " (3) - 255.0.0.0"
                        read -p " Escolha uma opção de máscara [1]: " MASK

                        if [ -z $MASK ]; then
                            MASK="1"  
                        fi

                        case $MASK in
                            1)
                                MASK="255.255.255.0"
                            ;;
                            2)
                                MASK="255.255.0.0"
                            ;;
                            3)
                                MASK="255.0.0.0"
                            ;;
                            *)
                                echo ""
                                echo -e " Opção Inválida, por padrão será escolhido [1]"
                                MASK="255.255.255.0" 
                            ;;
                        esac

                        read -p " Digite o gateway : " GW
                        echo -e "# This file describes the network interfaces available on your system" > "/etc/network/interfaces"
                        echo -e "# and how to activate them. For more information, see interfaces(5)." >> "/etc/network/interfaces" 
                        echo -e "" >> "/etc/network/interfaces"
                        echo -e "source /etc/network/interfaces.d/*" >> "/etc/network/interfaces"
                        echo -e "" >> "/etc/network/interfaces"
                        echo -e "# The loopback network interface" >> "/etc/network/interfaces"
                        echo -e "auto lo" >> "/etc/network/interfaces"
                        echo -e "iface lo inet loopback" >> "/etc/network/interfaces"
                        echo -e "" >> "/etc/network/interfaces"
                        echo -e "# The primary network interface" >> "/etc/network/interfaces"
                        echo -e "auto $INT" >> "/etc/network/interfaces"
                        echo -e "iface $INT inet static" >> "/etc/network/interfaces"
                        echo -e "address $IP " >> "/etc/network/interfaces"
                        echo -e "netmask $MASK" >> "/etc/network/interfaces"
                        echo -e "gateway $GW" >> "/etc/network/interfaces"
                    ;;
                    dhcp)
                        echo -e "# This file describes the network interfaces available on your system" > "/etc/network/interfaces"
                        echo -e "# and how to activate them. For more information, see interfaces(5)." >> "/etc/network/interfaces" 
                        echo -e "" >> "/etc/network/interfaces"
                        echo -e "source /etc/network/interfaces.d/*" >> "/etc/network/interfaces"
                        echo -e "" >> "/etc/network/interfaces"
                        echo -e "# The loopback network interface" >> "/etc/network/interfaces"
                        echo -e "auto lo" >> "/etc/network/interfaces"
                        echo -e "iface lo inet loopback" >> "/etc/network/interfaces"
                        echo -e "" >> "/etc/network/interfaces"
                        echo -e "# The primary network interface" >> "/etc/network/interfaces"
                        echo -e "auto $INT" >> "/etc/network/interfaces"
                        echo -e "iface $INT inet dhcp" >> "/etc/network/interfaces"
                    ;;
                    *)
                        echo ""
                        echo -e " Opção Inválida, por padrão será escolhido [static]"
                        MODO="static"
                    ;;
                esac

                clear
                echo -e "============================================================"
                echo -e ""
                echo -e " *** CONFIGURANDO A REDE *** "
                echo -e ""
                echo -e "============================================================"
                read -p " Deseja configurar a lan (sim ou nao): [sim] " OPC

                if [ -z $OPC ]; then
                    OPC="sim"
                fi

                TYPE="lan"

                case $OPC in
                    sim)
                        echo -e " Configurando a $TYPE, aguarde... "
                        sleep 2
                        echo -e ""
                        echo -e " *** INTERFACES *** "
                        echo -e    "============================================================"
                        sed '/:/!d;s/:.*//;s/^ */ /' /proc/net/dev
                        echo -e    "============================================================"
                        echo -e ""
                        read -p " Qual interface você gostaria de configurar: [eth1] " INT 

                        if [ -z $INT ]; then
                            INT="eth1"
                        fi

                        ifdown $INT > /dev/null 2>&1

                        echo ""
                        echo " (1) - dhcp"
                        echo " (2) - static"
                        read -p " Como deseja usar a interface: [2] " MODO

                        if [ -z $MODO ]; then
                            MODO="2"
                        fi

                        case $MODO in
                            1)
                                MODO="dhcp"
                            ;;
                            2)
                                MODO="static"
                            ;;
                            *)
                                echo ""
                                echo -e " Opção Inválida, por padrão será escolhido [2]"
                                MODO="static" 
                            ;;
                        esac
                
                        case $MODO in
                            static)
                                read -p " Digite o ip [192.168.0.254]: " IP

                                if [ -z $IP ]; then
                                    IP="192.168.0.254"
                                fi
                    
                                echo ""
                                echo " (1) - 255.255.255.0"
                                echo " (2) - 255.255.0.0"
                                echo " (3) - 255.0.0.0"
                                read -p " Escolha uma opção de máscara [1]: " MASK

                                if [ -z $MASK ]; then
                                    MASK="1"  
                                fi

                                case $MASK in
                                    1)
                                        MASK="255.255.255.0"
                                    ;;
                                    2)
                                        MASK="255.255.0.0"
                                    ;;
                                    3)
                                        MASK="255.0.0.0"
                                    ;;
                                    *)
                                        echo ""
                                        echo -e " Opção Inválida, por padrão será escolhido [1]"
                                        MASK="255.255.255.0" 
                                    ;;
                                esac

                                echo "" >> "/etc/network/interfaces"
                                echo -e "# The second network interface" >> "/etc/network/interfaces"
                                echo -e "auto $INT" >> "/etc/network/interfaces"
                                echo -e "iface $INT inet static" >> "/etc/network/interfaces"
                                echo -e "address $IP " >> "/etc/network/interfaces"
                                echo -e "netmask $MASK" >> "/etc/network/interfaces"
                            ;;
                            dhcp)
                                echo -e "\n # The second network interface" >> "/etc/network/interfaces"
                                echo -e "auto $INT" >> "/etc/network/interfaces"
                                echo -e "iface $INT inet dhcp" >> "/etc/network/interfaces"
                            ;;
                            *)
                                echo ""
                                echo -e " Opção Inválida, por padrão será escolhido [static]"
                                MODO="static"
                            ;;
                        esac
                    ;;
                    nao)
                        echo -e " Continuando script ..."    
                    ;;
                    *)
                        echo -e " Opção Inválida, por padrão será escolhido [sim]"
                        OPC="sim"
                    ;;
                esac 
            ;;
            lan)

                echo ""
                echo " (1) - dhcp"
                echo " (2) - static"
                read -p " Como deseja usar a interface: [2] " MODO

                if [ -z $MODO ]; then
                    MODO="2"
                fi

                case $MODO in
                    1)
                        MODO="dhcp"
                    ;;
                    2)
                        MODO="static"
                    ;;
                    *)
                        echo ""
                        echo -e " Opção Inválida, por padrão será escolhido [2]"
                        MODO="static" 
                    ;;
                esac
            
                case $MODO in
                    static)
                        read -p " Digite o ip [192.168.0.254]: " IP

                        if [ -z $IP ]; then
                            IP="192.168.0.254"
                        fi
            
                        echo ""
                        echo " (1) - 255.255.255.0"
                        echo " (2) - 255.255.0.0"
                        echo " (3) - 255.0.0.0"
                        read -p " Escolha uma opção de máscara [1]: " MASK

                        if [ -z $MASK ]; then
                            MASK="1"  
                        fi

                        case $MASK in
                            1)
                                MASK="255.255.255.0"
                            ;;
                            2)
                                MASK="255.255.0.0"
                            ;;
                            3)
                                MASK="255.0.0.0"
                            ;;
                            *)
                                echo ""
                                echo -e " Opção Inválida, por padrão será escolhido [1]"
                                MASK="255.255.255.0" 
                            ;;
                        esac

                        read -p " Digite o gateway : " GW
                        echo -e "# This file describes the network interfaces available on your system" > "/etc/network/interfaces"
                        echo -e "# and how to activate them. For more information, see interfaces(5)." >> "/etc/network/interfaces" 
                        echo -e "" >> "/etc/network/interfaces"
                        echo -e "source /etc/network/interfaces.d/*" >> "/etc/network/interfaces"
                        echo -e "" >> "/etc/network/interfaces"
                        echo -e "# The loopback network interface" >> "/etc/network/interfaces"
                        echo -e "auto lo" >> "/etc/network/interfaces"
                        echo -e "iface lo inet loopback" >> "/etc/network/interfaces"
                        echo -e "" >> "/etc/network/interfaces"

                        echo -e "# The primary network interface" >> "/etc/network/interfaces"
                        echo -e "auto $INT" >> "/etc/network/interfaces"
                        echo -e "iface $INT inet static" >> "/etc/network/interfaces"
                        echo -e "address $IP " >> "/etc/network/interfaces"
                        echo -e "netmask $MASK" >> "/etc/network/interfaces"
                        echo -e "gateway $GW" >> "/etc/network/interfaces"
                    ;;
                    dhcp)
                        echo -e "# This file describes the network interfaces available on your system" > "/etc/network/interfaces"
                        echo -e "# and how to activate them. For more information, see interfaces(5)." >> "/etc/network/interfaces" 
                        echo -e "" >> "/etc/network/interfaces"
                        echo -e "source /etc/network/interfaces.d/*" >> "/etc/network/interfaces"
                        echo -e "" >> "/etc/network/interfaces"
                        echo -e "# The loopback network interface" >> "/etc/network/interfaces"
                        echo -e "auto lo" >> "/etc/network/interfaces"
                        echo -e "iface lo inet loopback" >> "/etc/network/interfaces"
                        echo -e "" >> "/etc/network/interfaces"
                        echo -e "# The primary network interface" >> "/etc/network/interfaces"
                        echo -e "auto $INT" >> "/etc/network/interfaces"
                        echo -e "iface $INT inet dhcp" >> "/etc/network/interfaces"
                    ;;
                    *)
                        echo -e " Opção Inválida, por padrão será escolhido [static]"
                        MODO="static"
                    ;;
                esac
            ;;
            *)
                echo -e " Opção Inválida, por padrão será escolhido [lan]"
                TYPE="lan"
            ;;
        esac

        clear
        
        sleep 1

        echo -e "Atualizando Repositório e Pacotes \n"
        
        export DEBIAN_FRONTEND=noninteractive
        apt update && apt upgrade -y
        
        echo -e
        echo -e
        echo -e "Limpando o cache do apt, aguarde... \n"
       
        apt autoclean 
        apt clean 
       
        echo -e
        echo -e
        echo -e "Instalando pacotes necessários \n"
    
        apt install resolvconf ifupdown vim wget acl attr autoconf bind9utils bison build-essential \
            debhelper dnsutils docbook-xml docbook-xsl flex gdb libjansson-dev krb5-user \
            libacl1-dev libaio-dev libarchive-dev libattr1-dev libblkid-dev libbsd-dev \
            libcap-dev libcups2-dev libgnutls28-dev libgpgme-dev libjson-perl \
            libldap2-dev libncurses5-dev libpam0g-dev libparse-yapp-perl \
            libpopt-dev libreadline-dev nettle-dev perl perl-modules pkg-config \
            python-all-dev python-crypto python-dbg python-dev python-dnspython \
            python3-dnspython python-markdown python3-markdown \
            python3-dev xsltproc zlib1g-dev liblmdb-dev lmdb-utils -y 
        echo -e
        echo -e 
        cd /usr/src
        echo -e "Baixando os arquivos do samba, aguarde... \n"

        if [ -f samba-$VERSAO.tar.gz ]; then
            echo -e "Arquivos do samba já foram baixados, continuando... \n"
        else
            wget https://download.samba.org/pub/samba/stable/samba-$VERSAO.tar.gz
        fi

        ifdown $INT > /dev/null 2>&1
        ifup $INT > /dev/null 2>&1
        
        echo -e "Extraindo os arquivos do samba, aguarde... \n"

        tar -zxvf samba-$VERSAO.tar.gz
        
        echo
        echo
        echo -e "Compilando o samba, aguarde... \n"

        cd /usr/src/samba-$VERSAO
        ./configure --prefix=/opt/samba --enable-fhs --with-systemd -j 2
        make -j 2
        make install -j 2
        
        egrep -qx "PATH=$PATH:/opt/samba/bin/:/opt/samba/sbin/" ~/.bashrc || echo "PATH=$PATH:/opt/samba/bin/:/opt/samba/sbin/" >> ~/.bashrc
        . ~/.bashrc
      
        echo
        echo
        echo -e "Provisionando o domínio, aguarde... \n"
        echo
        read -p "Defina o nome do host [dc01]: " HOST

        if [ -z $HOST ]; then
            HOST="dc01"
        fi

        echo
        read -p "Defina o domínio [empresa.local]: " REALM

        if [ -z $REALM ]; then
            REALM="empresa.local"
        fi

        sleep 1
        echo
        stty -echo
        printf "Defina a senha do administrator [123@mudar]: "
        read PASS
        
        if [ -z $PASS ]; then
            PASS="123@mudar"
        fi
        
        sleep 1

        HOSTNAME="$HOST" 
        echo -e "$HOST" > /etc/hostname

        hostname $HOST
        
        UDOMAIN=${REALM^^}
        DOMAIN=${UDOMAIN%%.*}

        

        if [ -e /opt/samba/etc/samba/smb.conf ]; then
            mv -f /opt/samba/etc/samba/smb.conf /opt/samba/etc/samba/smb.conf~
        fi

        samba-tool domain provision --realm=$REALM --domain=$DOMAIN --use-rfc2307 \
        --server-role=dc --dns-backend=SAMBA_INTERNAL --adminpass=$PASS

        # Configuração do arquivo smb.conf

        echo -e "# Global parameters" > "/opt/samba/etc/samba/smb.conf"
        echo -e "[global]" >> "/opt/samba/etc/samba/smb.conf"
        echo -e "" >> "/opt/samba/etc/samba/smb.conf"
        echo -e "netbios name = $HOSTNAME" >> "/opt/samba/etc/samba/smb.conf"
        echo -e "realm = $REALM" >> "/opt/samba/etc/samba/smb.conf"
        echo -e "server role = active directory domain controller" >> "/opt/samba/etc/samba/smb.conf"
        echo -e "workgroup = $DOMAIN" >> "/opt/samba/etc/samba/smb.conf"
        echo -e "dns forwarder = 8.8.8.8" >> "/opt/samba/etc/samba/smb.conf"
	    echo -e "ldap server require strong auth = no" >> "/opt/samba/etc/samba/smb.conf"
	    echo -e "time server = yes" >> "/opt/samba/etc/samba/smb.conf"
        echo -e "" >> "/opt/samba/etc/samba/smb.conf"
        echo -e "[sysvol]" >> "/opt/samba/etc/samba/smb.conf"
	    echo -e "path = /opt/samba/var/lib/samba/sysvol" >> "/opt/samba/etc/samba/smb.conf"
	    echo -e "read only = No" >> "/opt/samba/etc/samba/smb.conf"
        echo -e "" >> "/opt/samba/etc/samba/smb.conf"
        echo -e "[netlogon]" >> "/opt/samba/etc/samba/smb.conf"
	    echo -e "path = /opt/samba/var/lib/samba/sysvol/$REALM/scripts" >> "/opt/samba/etc/samba/smb.conf"
        echo -e "read only = No" >> "/opt/samba/etc/samba/smb.conf"

        cp /usr/src/samba-$VERSAO/bin/default/packaging/systemd/samba.service /etc/systemd/system/samba-ad-dc.service

        sed -i "s/Type=notify/Type=simple/g" /etc/systemd/system/samba-ad-dc.service 

        mkdir -p /opt/samba/etc/sysconfig

        echo -e 'SAMBAOPTIONS="-D"' > /opt/samba/etc/sysconfig/samba 

        systemctl daemon-reload \
        && systemctl start samba-ad-dc.service \
        && systemctl enable samba-ad-dc.service

        ln -s /opt/samba/lib/libnss_winbind.so.2 /lib/x86_64-linux-gnu/libnss_winbind.so.2
        ln -s /lib/x86_64-linux-gnu/libnss_winbind.so.2 /lib/x86_64-linux-gnu/libnss_winbind.so

        if [ -e /etc/krb5.conf ]; then
            mv -f /etc/krb5.conf /etc/krb5.conf~
        fi

        cp /opt/samba/var/lib/samba/private/krb5.conf /etc/krb5.conf

        # Configurando o arquivo hosts

        echo -e "127.0.0.1 \t localhost" > "/etc/hosts"
        echo -e "$IP \t $HOSTNAME.$REALM $HOSTNAME" >> "/etc/hosts"
        echo -e "" >> "/etc/hosts"
        echo -e "# The following lines are desirable for IPv6 capable hosts" >> "/etc/hosts"
        echo -e "::1     localhost ip6-localhost ip6-loopback" >> "/etc/hosts"
        echo -e "ff02::1 ip6-allnodes" >> "/etc/hosts"
        echo -e "ff02::2 ip6-allrouters" >> "/etc/hosts"

        # Configurando o arquivo nsswitch

        echo -e "# /etc/nsswitch.conf" > "/etc/nsswitch.conf.conf"
        echo -e "#" >> "/etc/nsswitch.conf"
        echo -e "# Example configuration of GNU Name Service Switch functionality." >> "/etc/nsswitch.conf"
        echo -e "# If you have the \`glibc-doc-reference' and \`info' packages installed, try:" >> "/etc/nsswitch.conf"
        echo -e "# \`info libc \"Name Service Switch\"' for information about this file." >> "/etc/nsswitch.conf"
        echo -e "" >> "/etc/nsswitch.conf"
        echo -e "passwd: \t files systemd winbind" >> "/etc/nsswitch.conf"
        echo -e "group: \t\t files systemd winbind" >> "/etc/nsswitch.conf"
        echo -e "shadow: \t files" >> "/etc/nsswitch.conf"
        echo -e "gshadow: \t files" >> "/etc/nsswitch.conf"
        echo -e "" >> "/etc/nsswitch.conf"
        echo -e "hosts: \t\t files dns" >> "/etc/nsswitch.conf"
        echo -e "networks: \t files" >> "/etc/nsswitch.conf"
        echo -e "" >> "/etc/nsswitch.conf"
        echo -e "protocols: \t db files" >> "/etc/nsswitch.conf"
        echo -e "services: \t db files" >> "/etc/nsswitch.conf"
        echo -e "ethers: \t db files" >> "/etc/nsswitch.conf"
        echo -e "rpc: \t\t db files" >> "/etc/nsswitch.conf"
        echo -e "" >> "/etc/nsswitch.conf"
        echo -e "netgroup: \t nis" >> "/etc/nsswitch.conf"

        rm -rf /usr/src/samba-$VERSAO*

        echo -e "dns-nameservers $IP" >> "/etc/network/interfaces"
        echo -e "dns-search $REALM" >> "/etc/network/interfaces"

        echo -e "Reiniciando o computador... \n"
        echo
        sleep 2
        reboot
    else
        echo -e "Você não passou a versão do samba! Ex. sudo ./setup.sh 4.12.5"
        echo -e "Pressione <Enter> para finalizar o script"
	    read
    fi
else
    echo -e "Usuário não é root, execute o comando como root"
	echo -e "Pressione <Enter> para finalizar o script"
	read
fi