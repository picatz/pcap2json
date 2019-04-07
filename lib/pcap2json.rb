require "packetgen"
require "oj"
require "pcap2json/version"
require "pcap2json/packetgen_extensions"

module Pcap2JSON
  def self.from_file(filename)
    PacketGen::PcapNG::File.new.read_packets(filename) do |packet|
      yield packet.to_json
    end
  rescue StandardError => e
    raise ArgumentError, e unless File.extname(filename.downcase) == '.pcap'
    PCAPRUB::Pcap.open_offline(filename).each_packet do |packet|
      next unless (packet = PacketGen.parse(packet.to_s))
      yield packet.to_json
    end
  end

  def self.from_interface(interface, **options)
    PacketGen.capture(iface: interface, **options) do |packet|
      yield packet.to_json
    end
  end
end
