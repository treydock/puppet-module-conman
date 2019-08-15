require 'spec_helper_acceptance'

describe 'conman class:' do
  context 'default parameters' do
    it 'runs successfully' do
      pp = <<-EOS
      class { 'conman': }
      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe package('conman') do
      it { is_expected.to be_installed }
    end

    describe service('conman') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe file('/etc/conman.conf') do
      it { is_expected.to be_file }
      it { is_expected.to be_mode 644 }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
    end
  end
end
