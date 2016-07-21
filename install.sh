#!/usr/bin/env bash

#install packa-wrappa
rm -f /usr/local/bin/packer
mv wrappa /usr/local/bin/packer

#install packer
wget https://releases.hashicorp.com/packer/0.10.1/packer_0.10.1_linux_amd64.zip
unzip packer_0.10.1_linux_amd64.zip
mv packer /opt/packer

#duplicate aws-ebs.json for each region. They will need to be manually filled out for correct region vpc-id and subnet-id

for REGION in us-east-1 us-west-1 us-west-2 ap-south-1 ap-northeast-2 ap-southeast-1 ap-southeast-2 ap-northeast-1 eu-central-1 eu-west-1 sa-east-1
do
	cp /opt/rosco/config/packer/aws-ebs.json /opt/rosco/config/packer/aws-ebs-$REGION.json
done
