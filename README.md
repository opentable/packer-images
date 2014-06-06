
##Introduction

The packer-images project was created with intention of building all the virtual machine images that were required to support our other open-source efforts.

In this repository you will find a number of templates that can be used by [packer](http://www.packer.io/) to create those virtual images.

They have been built with as little configuration as possible so that they can be used in any number of scenarios, not just those required by us here at OpenTable.

[vagrant](http://www.vagrantup.com/) users can find the boxes created by these templates at [our page on vagrantcloud.com](https://vagrantcloud.com/opentable)

##Usage

Within in each template your will find an individual README (for example: README.md) which will describe how to use the template to build an image.

What you will first need is an iso for the operating system that you are looking to build and you will place that within the `iso` directory (`en_windows_server_2008_datacenter_enterprise_standard_x64_dvd_x14-26714.iso`)

Then from within each template directory you will find a json file (e.g. `windows/templates/windows-2008R2-serverstandard-amd64/windows_2008_r2.json`)

From there you can run packer: `packer build windows_2008_r2.json` which will build you your image


##Acknowledgements
This repo began as a fork of the [packer-windows](https://github.com/joefitzgerald/packer-windows) project and it continues to be a point of reference for our windows machines.
We have also taken bits from the great [veewee templates](https://github.com/jedi4ever/veewee/tree/master/templates) which has many great community contributions.

##Limitations
You may see images appear here before they are available on vagrantcloud. They maybe be a work-in-progress and the README should indicate as such.

When running the windows images under vagrant (< 1.6) you will be required to install the [vagrant-windows](https://github.com/WinRb/vagrant-windows) plugin.

##Development

###Contributing

Please read CONTRIBUTING.md for full details on contributing to this project.
