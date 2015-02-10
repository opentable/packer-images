#!/bin/bash

if [ -f floppy01.img ]; then
  rm -f floppy01.img
fi

vagrant up

vagrant ssh -c "sudo dd bs=512 count=2880 if=/dev/zero of=floppy01.img"
vagrant ssh -c "sudo mkfs.msdos floppy01.img"
vagrant ssh -c "sudo mount -o loop floppy01.img /mnt"
vagrant ssh -c "sudo mkdir /tmp/floppy && sudo chown vagrant:vagrant /tmp/floppy"

scp -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no" -i ~/.vagrant.d/insecure_private_key -P 2222 ../../templates/$1/winnt.sif vagrant@localhost:/tmp/floppy/winnt.sif
scp -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no" -i ~/.vagrant.d/insecure_private_key -P 2222 ../regedit.bat vagrant@localhost:/tmp/floppy/regedit.bat
scp -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no" -i ~/.vagrant.d/insecure_private_key -P 2222 ../runonce.bat vagrant@localhost:/tmp/floppy/runonce.bat
scp -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no" -i ~/.vagrant.d/insecure_private_key -P 2222 ../bitvisessh.bat vagrant@localhost:/tmp/floppy/bitvisessh.bat
scp -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no" -i ~/.vagrant.d/insecure_private_key -P 2222 ../BvSshServer-Settings.wst vagrant@localhost:/tmp/floppy/BvSshServer-Settings.wst
scp -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no" -i ~/.vagrant.d/insecure_private_key -P 2222 ../ps.bat vagrant@localhost:/tmp/floppy/ps.bat
scp -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no" -i ~/.vagrant.d/insecure_private_key -P 2222 ../downloadFile.vbs vagrant@localhost:/tmp/floppy/downloadFile.vbs
scp -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no" -i ~/.vagrant.d/insecure_private_key -P 2222 ../vagrant-ssh.bat vagrant@localhost:/tmp/floppy/vagrant-ssh.bat
scp -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no" -i ~/.vagrant.d/insecure_private_key -P 2222 ../oracle-cert.cer vagrant@localhost:/tmp/floppy/oracle-cert.cer
scp -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no" -i ~/.vagrant.d/insecure_private_key -P 2222 ../winrm.bat vagrant@localhost:/tmp/floppy/winrm.bat
scp -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no" -i ~/.vagrant.d/insecure_private_key -P 2222 ../vm-guest-tools.bat vagrant@localhost:/tmp/floppy/vm-guest-tools.bat

vagrant ssh -c "sudo cp /tmp/floppy/winnt.sif /mnt/winnt.sif"
vagrant ssh -c "sudo cp /tmp/floppy/regedit.bat /mnt/regedit.bat"
vagrant ssh -c "sudo cp /tmp/floppy/runonce.bat /mnt/runonce.bat"
vagrant ssh -c "sudo cp /tmp/floppy/bitvisessh.bat /mnt/bitvisessh.bat"
vagrant ssh -c "sudo cp /tmp/floppy/BvSshServer-Settings.wst /mnt/BvSshServer-Settings.wst"
vagrant ssh -c "sudo cp /tmp/floppy/vagrant-ssh.bat /mnt/vagrant-ssh.bat"
vagrant ssh -c "sudo cp /tmp/floppy/ps.bat /mnt/ps.bat"
vagrant ssh -c "sudo cp /tmp/floppy/downloadFile.vbs /mnt/downloadFile.vbs"
vagrant ssh -c "sudo cp /tmp/floppy/oracle-cert.cer /mnt/oracle-cert.cer"
vagrant ssh -c "sudo cp /tmp/floppy/winrm.bat /mnt/winrm.bat"
vagrant ssh -c "sudo cp /tmp/floppy/vm-guest-tools.bat /mnt/vm-guest-tools.bat"
vagrant ssh -c "sudo chown root:root /mnt/*.*"
vagrant ssh -c "sudo umount /mnt"

scp -o "UserKnownHostsFile /dev/null" -o "StrictHostKeyChecking no" -i ~/.vagrant.d/insecure_private_key -P 2222 vagrant@localhost:/home/vagrant/floppy01.img .

vagrant destroy -f
