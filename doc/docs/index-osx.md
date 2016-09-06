Installation Instruction on iOS
------------------------------

* Tools
    - [HTTP Proxy](#squid)
    - [SOCKS5 Proxy](#dante)
    - [VPN](#vpn)

<a name="squid"></a>
### HTTP Proxy ###

?

<a name="dante"></a>
###SOCKS5 Proxy###

?

<a name="vpn"></a>
###L2TP VPN###

1. Download VPN configuration profile to the device (right-click and 'Save as ...').
1. Double-click the file to install, click twice 'Continue' and ignore username. Requires user to type in his computer password to complete.
1. Open System Preferences -> Network and select '{{UCN Study}}' from the left column.
1. Type the device specific VPN login ({{username.devicename}}) to the 'Account Name' field.
1. Click 'Authentication Settings ...' and type in user {{password}} (same for all devices) created above.
1. Check 'Show VPN status in menu bar' for quick access to VPN connect/disconnect.
1. Click 'Connect'.

You can verify that your traffic is being routed properly by [looking up your IP address](www.hashemian.com/whoami/). It should say *Your public IP address is {{ streisand_ipv4_address }}*.