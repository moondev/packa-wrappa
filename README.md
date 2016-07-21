# Packa Wrappa
Wrapper for packer to support rosco multi-region bakes in spinnaker

## Installation on Rosco
```
./install.sh
```

Fill out the vpc and subnet info for each desired bake region in /opt/rosco/config/packer/aws-ebs-{region}.json

## Details
This wrappa is at /usr/local/bin/packer
 
The real packer binary is at /opt/packer

The script looks for region in the params and then adds that to the end of aws-ebs.json and calls it with the real packer at /opt/packer

Rosco goes:
```
packer build -color=false -var aws_region=us-west-2 -var aws_ssh_username=ubuntu -var aws_instance_type=t2.micro -var aws_source_ami=ami-d732f0b7 -var aws_target_ami=nginx-all-20160721161956-ubuntu -var aws_associate_public_ip_address=true -var package_type=deb -var packages=nginx -var configDir=/opt/rosco/config/packer /opt/rosco/config/packer/aws-ebs.json
```
Fake packer intercepts it because it is on the PATH and then calls:
```
/opt/packer build -color=false -var aws_region=us-west-2 -var aws_ssh_username=ubuntu -var aws_instance_type=t2.micro -var aws_source_ami=ami-d732f0b7 -var aws_target_ami=nginx-all-20160721161956-ubuntu -var aws_associate_public_ip_address=true -var package_type=deb -var packages=nginx -var configDir=/opt/rosco/config/packer /opt/rosco/config/packer/aws-ebs-west-2.json
```
aws-ebs-west-2.json and aws-ebs-east-1.json have their specific vpc and subnet info.