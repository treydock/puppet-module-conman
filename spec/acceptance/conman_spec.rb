require 'spec_helper_acceptance'

describe 'conman class:' do
  context 'default parameters' do
    it 'should run successfully' do
      pp =<<-EOS
      class { 'conman': }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe package('conman') do
      it { should be_installed }
    end

    describe service('conman') do
      it { should be_enabled }
      it { should be_running }
    end

    describe file('/etc/conman.conf') do
      it { should be_file }
      it { should be_mode 644 }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end
  end
end
