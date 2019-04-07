
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pcap2json/version"

Gem::Specification.new do |spec|
  spec.name          = "pcap2json"
  spec.version       = Pcap2JSON::VERSION
  spec.authors       = ["Kent 'picat' Gruber"]
  spec.email         = ["kgruber1@emich.edu"]

  spec.summary       = %q{Convert packets to json from a file or a live network interface.}
  #spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/picatz/pcap2json"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.files         = Dir['lib/**/*.rb']
  spec.bindir        = 'bin'
  spec.executable    = 'pcap2json'
  spec.require_paths = ['lib']

  spec.add_dependency "packetgen", "~> 3.1.2"
  spec.add_dependency "oj", "~> 3.7.11"

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.8.0"
  spec.add_development_dependency "pry", "~> 0.12.2"
end
