# -*- encoding: utf-8 -*-
require File.expand_path('../lib/chinapay/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["lg2046"]
  gem.email         = ["lg2046@gmail.com"]
  gem.description   = %q{支持支付宝 财付通的ruby 即时到账}
  gem.summary       = %q{支持支付宝 财付通的ruby 即时到账}
  gem.homepage      = "http://github.com/lg2046"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "chinapay"
  gem.require_paths = ["lib"]

  gem.version       = Chinapay::VERSION
end
