#!/bin/bash

wget https://get.helm.sh/helm-v3.8.0-linux-amd64.tar.gz
echo -n '8408c91e846c5b9ba15eb6b1a5a79fc22dd4d33ac6ea63388e5698d1b2320c8b helm-v3.8.0-linux-amd64.tar.gz' | sha256sum --check
tar -zxvf helm-v3.8.0-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm
