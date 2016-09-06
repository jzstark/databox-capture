Installation Instruction on iOS
------------------------------

* Tools
    - [HTTP Proxy](#squid)
    - [SOCKS5 Proxy](#dante)
    - [VPN](#vpn)

<a name="squid"></a>
### HTTP Proxy ###
1. Navigate to the ‘Settings’ app and tap on ‘WiFi’
2. Next, tap on the currently connected WiFi network. 
3. Scroll down to the `HTTP Proxy` settings and tap `Auto`. 
4. Fill in the `URL` as `http://$IP/http_proxy.pac`

<a name="dante"></a>
###SOCKS5 Proxy###

Follow Step 1-5 as in [HTTP Proxy](#squid). Then fill in the `URL` as `http://$IP/socks.pac`

<a name="vpn"></a>
###L2TP VPN###
1. Download [VPN configuration profile](/config/l2tp.mobileconfig) to the device (right-click and 'Save as ...').
2. Double-click the file to install.
3. Click 'Connect' and provide
    - `Secret`: `$L2TP_PSK`

You can verify that your traffic is being routed properly by [looking up your IP address](www.hashemian.com/whoami/). It should say *Your public IP address is {{ streisand_ipv4_address }}*.