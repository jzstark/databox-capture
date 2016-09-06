#!/bin/sh

mv ../squid/squid.pac docs/config/http_proxy.pac
mv ../dante/dante.pac docs/config/socks.pac
mv ../l2tp/l2tp.mobileconfig docs/config/l2tp.mobileconfig

cd gen_config

sh generate_md_android.sh
sh generate_md_ios.sh
sh generate_md_win.sh


cd ..
mv gen_config/index-android.md docs/index.md
mkdocs build --clean
cp site/index.html index-android.html

mv gen_config/index-ios.md docs/index.md
mkdocs build --clean
cp site/index.html index-ios.html

mv gen_config/index-win.md docs/index.md
mkdocs build --clean
cp site/index.html index-win.html

rsync -ar --delete site/  ../nginx/html
mv index-* ../nginx/html/
cp index.html ../nginx/html/
cp platform.js ../nginx/html/
