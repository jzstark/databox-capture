# Running VPN on a Cloud Server

## Run OpenVPN 

- [run.sh](/ovpn/run.sh): install and start container "ovpn"; user need to manually input a key that is requred every time a client configuration file is created. Creating DH parameters may take a long time in this step. 
- [generate.sh](/ovpn/generate.sh): generate installing instruction openvpn.md and a client configuration file databox.ovpn

## Run Docs

- The config file and instruction are processed with Mkdocs by running [run.sh](/mkdocs/run.sh) 

## Run Nginx

- [run.sh](/nginx/run.sh) start an Nginx docker to host instruction and config files for VPN tools

## Client Side 

- follow the instruction hosted on cloud server to install the config file to user devices on different platforms.
