#!/bin/bash

# "[SRX/IDP] How to perform offline policy templates update/install on SRX" - http://kb.juniper.net/InfoCenter/index?page=content&id=KB27087 
# "How to perform offline IDP and Application signature database update in SRX" - http://kb.juniper.net/InfoCenter/index?page=content&id=TN83
# "[SRX] Update IDP in the secondary node of a SRX Chassis Cluster (High Availability)" - http://kb.juniper.net/InfoCenter/index?page=content&id=KB21052

DEVICE=jsrx240
FEATURE=idp
DETECTOR=12.6.160121210
OS=11.4
FROM=
TO=2105

SIGURL="https://services.netscreen.com/cgi-bin/index.cgi?device=$DEVICE&feature=$FEATURE&detector=$DETECTOR&os=$OS&from=$FROM&to=$TO&type=update"

mkdir -p sec-download
pushd sec-download
rm -f *
curl --output SignatureUpdate.xml.gz -L "$SIGURL"
while read URL; do
  curl --insecure --remote-name "$URL"
done < <(zcat SignatureUpdate.xml.gz | sed -e 's/<[^>]*>//g' | grep https://)
gunzip *.gz
popd
