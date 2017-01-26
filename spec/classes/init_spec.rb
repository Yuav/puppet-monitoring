require 'spec_helper'

describe 'monitoring' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context 'monitoring class without any parameters' do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('monitoring::params') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'monitoring class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          osfamily:        'Solaris',
          operatingsystem: 'Nexenta'
        }
      end

      it { expect { is_expected.to contain_package('monitoring') }.to raise_error(Puppet::Error, %r{Nexenta not supported}) }
    end
  end
end
