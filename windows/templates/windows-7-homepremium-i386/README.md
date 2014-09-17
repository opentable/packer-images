Windows 7 Home Premium Edition x86 (with no configuration management tools)


Machine Specific
----------------

Box size around 3 GB <br/>
Configured as 2 CPU and 2 GB memory by default <br/>
No updates or services packs applied <br/>

This box is not activated. It has been created for testing and evaluation purposes only.
Use of this machine for greater than 30 days will require a full license either via MSDN or your local Microsoft Reseller.

This box has been created with [packer.io](http://www.packer.io/) using the templates we have made available [here](https://github.com/opentable/packer-images)

Software Pre-installed
----------------------
The following software is installed and pre-configured:

* Openssh (via Cygwin)
* Git (via Cygwin)
* Curl and Wget (via Cygwin)
* Guest Additions (provider specific)

Preconfigured
-------------
The following configuration is set:

* WinRM configured for vagrant-windows plugin
* Local Administrator account enabled
* Powershell is installed with Remote Execution policy is set unrestricted
