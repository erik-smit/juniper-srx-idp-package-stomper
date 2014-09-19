#!/bin/bash

mkdir -p sec-download
pushd sec-download
curl --output SignatureUpdate.xml.gz -L 'https://services.netscreen.com/cgi-bin/index.cgi?device=jsrx240&feature=idp&detector=12.6.160121210&os=11.4&from=&to=latest&type=update'
while read URL; do
  curl --remote-name "$URL"
done < <(zcat SignatureUpdate.xml.gz | sed -e 's/<[^>]*>//g' | grep https://)
gunzip *.gz
popd
