require 'spec_helper'

describe 'conman' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to create_class('conman') }

      it do
        is_expected.to contain_package('conman').only_with(ensure: 'present',
                                                           name: 'conman')
      end

      it do
        is_expected.to contain_concat('/etc/conman.conf').with(ensure: 'present',
                                                               owner: 'root',
                                                               group: 'root',
                                                               mode: '0640',
                                                               require: 'Package[conman]')
      end

      it do
        is_expected.to contain_service('conman').only_with(ensure: 'running',
                                                           enable: 'true',
                                                           name: 'conman',
                                                           hasstatus: 'true',
                                                           hasrestart: 'true',
                                                           subscribe: 'Concat[/etc/conman.conf]')
      end

      context 'when server => false' do
        let(:params) { { server: false } }

        it { is_expected.to contain_package('conman') }
        it { is_expected.not_to contain_concat('/etc/conman.conf') }
        it do
          is_expected.to contain_service('conman').only_with(ensure: 'stopped',
                                                             enable: 'false',
                                                             name: 'conman',
                                                             require: 'Package[conman]')
        end
      end
    end # end context
  end # end on_supported_os loop
end # end describe
