Installation Instruction on Windows 7
------------------------------

* Tools
    - [HTTP Proxy](#squid)
    - [SOCKS5 Proxy](#dante)
    - [VPN](#vpn)

<a name="squid"></a>
### HTTP Proxy ###

1. Open `Control Panel` --> `Network and Internet` --> `Network and Sharing Center` --> `Internet Options` --> `Connections` Tab --> `LAN Settings`. This will open another new window. Check the box in the "Use automatic configuration script" section, and uncheck the "Automatically detect settings" box. ![Illustration](/img/win_http1.png)
2. Copy the text below to the "Address" domain: http://*%ip_addr*/proxy.pac
3. When you are done using your proxy and want to go back to your direct connection, open the LAN settings again, recheck the “Automatically detect settings” box and uncheck the box in the “Use automatic configuration script” section.

<a name="dante"></a>
###SOCKS5 Proxy###

1. Open `Control Panel` --> `Network and Internet` --> `Network and Sharing Center` --> `Internet Options` --> `Connections` Tab --> `LAN Settings`. This will open another new window. Check the box in the "Use automatic configuration script" section, and uncheck the "Automatically detect settings" box. 
2. Copy the text below to the "Address" domain: http://*%ip_addr*/socks.pac
3. When you are done using your proxy and want to go back to your direct connection, open the LAN settings again, recheck the “Automatically detect settings” box and uncheck the box in the “Use automatic configuration script” section.

<a name="vpn"></a>
###L2TP VPN###

1. Click on the Start Menu and go to the `Control Panel`. Go to the `Network and Internet` section. Click `View network status and tasks` to show the `Network and Sharing Center`. 
1. Click `Set up a new connection or network`. Select `Connect to a workplace` and click `Next`.
1. Click *Use my Internet connection (VPN)*. Enter **`{{ streisand_ipv4_address }}`** in the *Internet address* field. Enter `{{ streisand_server_name }}` in the *Destination name* field.
1. Check the *Don't connect now; just set it up so I can connect later* checkbox. Click *Next*.
1. Enter `streisand` in the *User name* field. Enter `{{ chap_password.stdout }}` in the *Password* field. Check the *Remember this password* checkbox. Click *Connect*, then click the *Close* button.
1. Return to the Control Panel's *Network and Internet* section and click on the *Connect to a network* option. Right-click on the new *{{ streisand_server_name }}* connection and choose *Properties*.
1. Click the *Options* tab and uncheck *Include Windows logon domain*.
1. Click the *Security* tab and select *Layer 2 Tunneling Protocol with IPsec (L2TP/IPSec)* from the *Type of VPN* drop-down menu.
1. Click the *Advanced settings* button.
1. Select *Use preshared key for authentication* and enter `{{ ipsec_preshared_key.stdout }}` for the *Key*.
1. Click *OK* to close the *Advanced settings*. Click *OK* to save the VPN connection details.
1. To connect to the VPN, simply right-click on the wireless/network icon in your system tray, select *{{ streisand_server_name }}*, and click *Connect*.

You can verify that your traffic is being routed properly by [looking up your IP address on Google](https://encrypted.google.com/search?hl=en&q=ip%20address). It should say *Your public IP address is {{ streisand_ipv4_address }}*.