Installation Instruction on Windows 7
------------------------------

* Tools
    - [HTTP Proxy](#squid)
    - [SOCKS5 Proxy](#dante)
    - [VPN](#vpn)

<a name="squid"></a>
### HTTP Proxy ###

1. Open \`Control Panel\` --> \`Network and Internet\` --> \`Network and Sharing Center\` --> \`Internet Options\` --> \`Connections\` Tab --> \`LAN Settings\`. This will open another new window. Check the box in the "Use automatic configuration script" section, and uncheck the "Automatically detect settings" box. ![Illustration](/img/win_http1.png)
2. Copy the text in \`Address\`: \`http://$IP/config/http_proxy.pac \`
3. When you are done using your proxy and want to go back to your direct connection, open the LAN settings again, recheck the “Automatically detect settings” box and uncheck the box in the “Use automatic configuration script” section.

<a name="dante"></a>
###SOCKS5 Proxy###

1. Follow the first step of setting up [HTTP Proxy](#squid).
2. Copy the text in \`Address\`: \`http://$IP/config/socks.pac \`
3. When you are done using your proxy and want to go back to your direct connection, open the LAN settings again, recheck the “Automatically detect settings” box and uncheck the box in the “Use automatic configuration script” section.

<a name="vpn"></a>
###L2TP VPN###

1. Click on the Start Menu and go to the \`Control Panel\`. Go to the \`Network and Internet\` section. Click \`View network status and tasks\` to show the \`Network and Sharing Center\`. 
1. Click \`Set up a new connection or network\`. Select \`Connect to a workplace\` and click \`Next\`.
1. Click \`Use my Internet connection (VPN)\`:
    - \`Internet address\`: **$IP**
    - \`Destination name\`: **Databox VPN**
1. Check the *Don't connect now; just set it up so I can connect later* checkbox. Click *Next*:
    - \`User name\`: **databox**
    - \`Password\`: **$L2TP_PW**
    - Check the \`Remember this password\` checkbox
    - Click *Connect*, then \`Close\`.
1. Return to the Control Panel's \`Network and Internet\` section and click on the \`Connect to a network\` option. Right-click on the new *Databox VPN* connection and choose \`Properties\`:
    - Click the \`Options\` tab and uncheck \`Include Windows logon domain\`.
    - Click the \`Security\` tab and select \`Layer 2 Tunneling Protocol with IPsec (L2TP/IPSec)\` from the \`Type of VPN\` drop-down menu.
    - Click the \`Advanced settings\` button. Select \`Use preshared key for authentication\` and enter **$L2TP_PSK** for the \`Key\`.
1. Click \`OK\` twice to save the VPN connection details. To connect to the VPN, simply right-click on the wireless/network icon in your system tray, select *Databox VPN*, and click *Connect*.

You can verify that your traffic is being routed properly by [looking up your IP address](www.hashemian.com/whoami/). It should say *Your public IP address is {{ ip_address }}*.