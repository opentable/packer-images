require 'spec_helper'

def is_vmware?
  endpoint = "http://localhost:5985/wsman"
  winrm = ::WinRM::WinRMWebService.new(endpoint, :plaintext, :user => 'Administrator', :pass => 'vagrant', :disable_sspi => true)
  winrm.set_timeout 300
  response = ''
  winrm.cmd('wmic path win32_videocontroller Where DeviceID="VideoController1" get Description /value | find "="') do |stdout, stderr|
    response = stdout
  end
  return response.include?('VMware')
end


describe "virtualbox", :unless => is_vmware? do
  context package('Oracle VM VirtualBox Guest Additions 4.3.12') do
    it { should be_installed }
  end
end

describe "vmware", :if => is_vmware? do
  context package('VMware Tools') do
    it { should be_installed }
  end
end
