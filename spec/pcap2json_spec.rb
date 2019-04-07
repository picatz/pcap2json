require "spec_helper"
require "pry"

RSpec.describe Pcap2JSON do
  it "has a version number" do
    expect(Pcap2JSON::VERSION).not_to be nil
  end

  it "can read packets from a pcap" do
    Pcap2JSON.from_file('spec/test.pcapng') do |packet|
      expect(packet).to be_a(String)
    end
  end
  
  it "can read packets from a network interface" do
    Pcap2JSON.from_interface(PacketGen.default_iface, max: 1) do |packet|
      expect(packet).to be_a(String) 
    end
  end
end
