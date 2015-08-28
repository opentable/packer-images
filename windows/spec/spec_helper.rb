require 'serverspec'
require 'winrm'

include Serverspec::Helper::Windows
include Serverspec::Helper::WinRM

RSpec.configure do |c|
  c.before :suite do
    endpoint = "http://localhost:55985/wsman"
    c.winrm = ::WinRM::WinRMWebService.new(endpoint, :plaintext, :user => 'Administrator', :pass => 'vagrant', :disable_sspi => true)
    c.winrm.set_timeout 300
  end
  c.color = true
  c.formatter = :documentation
end
