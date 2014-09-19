#!/bin/bash

TEMPLATE=$1
PROVISIONER=$2

BOX=$TEMPLATE"_"$PROVISIONER".box"

cd templates/$TEMPLATE

for B in `vagrant box list | grep windows | awk '{print $1}'`; do vagrant box remove --provider=virtualbox $B; done
for B in `vagrant box list | grep windows | awk '{print $1}'`; do vagrant box remove --provider=vmware_desktop $B; done

rm -f $BOX
rm -rf output-$PROVISIONER-iso

packer build -debug -only=$PROVISIONER-iso packer.json
vagrant box add --force --name $TEMPLATE $BOX

cd ../../tests

gem install bundler --no-ri --no-rdoc
rm Gemfile.lock
bundle install --path=vendor

if [ $PROVISIONER == 'vmware' ]; then
  PROVIDER='vmware_fusion'
else
  PROVIDER='virtualbox'
fi

BOX="$BOX" TEMPLATE="$TEMPLATE" vagrant up --provider=$PROVIDER
bundle exec rake spec
BOX="$BOX" TEMPLATE="$TEMPLATE" vagrant destroy -f
