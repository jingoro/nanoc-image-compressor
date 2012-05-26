# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["John Nishinaga"]
  gem.email         = ["jingoro@casa-z.org"]
  gem.description   = %q{Nanoc image compressor filter}
  gem.summary       = %q{A nanoc filter that compresses gif, jpg and png images losslessly}
  gem.homepage      = "https://github.com/jingoro/nanoc-image-compressor"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "nanoc-image-compressor"
  gem.require_paths = ["lib"]
  gem.version       = '0.1.1'

  gem.add_dependency 'nanoc', '>= 3.3.1'
  gem.add_dependency 'image_optim'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'bluecloth'
end
