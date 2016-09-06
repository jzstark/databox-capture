#!/bin/sh

IP=`curl --silent ipecho.net/plain`
L2TP_PW=`cat ../../l2tp/l2tp.env | awk '/PASSWORD/{print $0}' | sed -r s/VPN_PASSWORD=//`
L2TP_PSK=`cat ../../l2tp/l2tp.env | awk '/PSK/{print $0}' | sed -r s/VPN_IPSEC_PSK=//`
cat > index-android.md << EOF 
Installation Instruction on Android
------------------------------

* Tools
    - [HTTP Proxy](#squid)
    - [SOCKS5 Proxy](#dante)
    - [VPN](#vpn)

<a name="squid"></a>
### HTTP Proxy ###

1. Connect to WIFI network. 
1. Go to \`Settings\` --> \`WIFI\`
1. Long tap on connected network's name. 
1. \`Modify network config\`, check the \`Show advanced options\` box. 
1. Choose \`Manual\` from the \`Proxy Setings\` drop-down menu. 
1. Enter **\`$IP\`** as \`Proxy host name\`. Enter **\`3128\`** as \`Proxy port\`

<a name="dante"></a>
###SOCKS5 Proxy###

Follow Step 1-5 as in [HTTP Proxy](#squid). Then choose \`Manual\` from the \`Proxy Setings\` drop-down menu. Enter **\`$IP\`** as \`Proxy host name\`. Enter **\`1194\`** as \`Proxy port\`. Click \`Save\`.

<a name="vpn"></a>
###L2TP VPN###

1. Configure and activate the VPN: Launch the \`Settings\`, in the \`Wireless & Networks\` section. Tap \`VPN\`. (You may need to setup PIN code protection first.) Tap the *+* icon in the top-right of the screen. ![illustration](/img/android_l2tp1.png)
1. Enter required information as below:
    - Name: \`Databox VPN\`
    - Type: \`L2TP/IPSec PSK\`
    - Server addres: \`$IP\`
    - IPSec pre-shared key : \`$L2TP_PSK\`
![illustration](/img/android_l2tp2.png)
1. Tap *Save*. Tap the \`Databox VPN\` connection:
    - Username: \`databox\`
    - Password: \`$L2TP_PW\`
![illustration](/img/android_l2tp3.png)
1. Check the \`Save account information\` checkbox. Tap \`Connect\`. Once connected, you will see a VPN icon in the notification bar. 

You can verify that your traffic is being routed properly by [looking up your IP address](http://www.hashemian.com/whoami/). It should say *Your public IP address is $IP*.
EOF
