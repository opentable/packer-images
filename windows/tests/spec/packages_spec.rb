require 'spec_helper'

describe package('Bitvise SSH Server 6.07 (remove only)') do
  it { should be_installed }
end
