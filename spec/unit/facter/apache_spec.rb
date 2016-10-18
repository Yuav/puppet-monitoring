require "spec_helper"

describe Facter::Util::Fact do
  before do
    Facter.clear
  end

  describe "apache_present" do
    context 'with apachectl present' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with("apachectl").returns(true)
        expect(Facter.value(:apache_present)).to eq(true)
      end
    end

    context 'with apachectl absent and apache2ctl absent' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with("apachectl").returns(false)
        Facter::Util::Resolution.expects(:which).with("apache2ctl").returns(false)
        expect(Facter.value(:apache_present)).to eq(false)
      end
    end

    context 'with apachectl absent and apache2ctl present' do
      it do
        Facter::Util::Resolution.stubs(:exec)
        Facter::Util::Resolution.expects(:which).with("apachectl").returns(false)
        Facter::Util::Resolution.expects(:which).with("apache2ctl").returns(true)
        expect(Facter.value(:apache_present)).to eq(true)
      end
    end
  end
  
  describe "apache server-status page present" do
    it do
      
      
#      original_get_response = Net::HTTP.method(:get_response)
#      Net::HTTP.stub(:get_response) do |uri|
#        (uri.to_s == 'http://google.de') ? FakeResponse.new : original_get_response.call(uri)
#      end
      
      #Net::HTTP.get_response(URI.parse(uri))
      expect(Facter.value(:apache_statuspage_present)).to eq(true)
    end
  end
end