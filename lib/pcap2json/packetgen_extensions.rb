require "pry"

class PacketGen::Packet
  def to_h
    data = Hash.new
    data["time"] = Time.now.to_i
    self.headers.each do |header|
      data[header.protocol_name.downcase] = header.to_h
    rescue # => error
      header.fields.reject { |field| field == :body }.each do |field|
        data[field.to_s] = header.send(field)
      end
    end
    unless self.body.nil?
      data["payload"] = self.body.to_s.encode(Encoding.find('UTF-8'), {invalid: :replace, undef: :replace, replace: ''})
    end
    data
  end

  def to_json
    Oj.dump(self.to_h)
  end
end

class PacketGen::Header::DHCP
  def to_h
    data = Hash.new
    
    data["magic"] = self.magic
    
    data["options"] = []

    self.options.each do |option|
      data["options"] << option.to_human
    end
    
    data
  end
end

class PacketGen::Header::BOOTP
  def to_h
    {
      "op" => self.op,
      "htype" => self.htype,
      "hlen" => self.hlen,
      "xid" => self.xid,
      "secs" => self.secs,
      "flags" => self.flags,
      "ciaddr" => self.ciaddr,
      "yiaddr" => self.yiaddr,
      "siaddr" => self.siaddr,
      "giaddr" => self.giaddr,
      "chaddr" => self.chaddr,
      "sname" => self.sname,
      "file" => self.file,
    }
  end

end

class PacketGen::Header::DNS
  def to_h 
    data = Hash.new
    data["id"] = self.id
    #data[:flags] = self.flags
    data["opcode"] = self.opcode
    data["rcode"] = self.rcode
    data["qdcount"] = self.qdcount
    data["ancount"] = self.ancount
    data["nscount"] = self.nscount
    data["arcount"] = self.arcount
    data["qd"] = []
    data["an"] = []
    data["ns"] = []
    data["ar"] = []
    self.qd.to_a.each do |qd|
      data["qd"] << qd.to_human
    end
    self.an.to_a.each do |an|
      data["an"] << an.to_human
    end
    self.ns.to_a.each do |ns|
      data["ns"] << ns.to_human 
    end
    self.ar.to_a.each do |ar|
      data["ar"] << ar.to_human 
    end
    data
  end
end

class PacketGen::Header::Eth
  def to_h 
    { 
      "dst" =>  self.dst, 
      "src" =>  self.src, 
      "ethertype" =>  self.ethertype 
    } 
  end
end

class PacketGen::Header::IP
  def to_h
    { 
      "u8" =>  self.u8, 
      "version" =>  self.version, 
      "ihl" =>  self.ihl,
      "tos" =>  self.tos,
      "length" =>  self.length,
      "frag" =>  self.frag,
      # flags =>  self.flags,
      # frag_offset =>  self.frag_offset,
      "ttl" =>  self.ttl,
      "protocol" =>  self.protocol,
      "checksum" =>  self.checksum,
      "src" =>  self.src,
      "dst" =>  self.dst
    } 
  end
end

class PacketGen::Header::TCP
  def to_h 
    {
      "sport"       =>  self.sport,
      "dport"       =>  self.dport,
      "seqnum"      =>  self.seqnum,
      "acknum"      =>  self.acknum,
      "u16"         =>  self.u16,
      "data_offset" =>  self.data_offset,
      "reserved"    =>  self.reserved,
      "flags"       =>  self.flags,
      "window"      =>  self.window,
      "checksum"    =>  self.checksum,
      "urg_pointer" =>  self.urg_pointer,
      # options =>  self.options
    }
  end
end

class PacketGen::Header::UDP
  def to_h
    { 
      "sport"    =>  self.sport, 
      "dport"    =>  self.dport, 
      "length"   =>  self.length, 
      "checksum" =>  self.checksum 
    }
  end
end

class PacketGen::Header::ARP
  def to_h
    { 
      "hrd" => self.hrd, 
      "pro" => self.pro, 
      "hln" => self.hln, 
      "op"  => self.op, 
      "sha" => self.sha, 
      "tha" => self.tha, 
      "tpa" => self.tpa 
    }
  end
end
