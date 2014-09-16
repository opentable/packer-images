#!/bin/bash

TEMPLATE=$1
PROVIDER=$2

BOX=$TEMPLATE"_"$PROVISIONER".box"

cd templates/$TEMPLATE

vagrant box remove $TEMPLATE
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

PROVISIONER="$PROVISIONER" vagrant up --provider=$PROVIDER
bundle exec rake spec
vagrant destroy -f
