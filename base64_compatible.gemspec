begin
  require 'rake'
  require 'lib/base64_compatible'

  Gem::Specification.new do |s|
  	s.name = "base64_compatible"
  	s.version = Base64Compatible::VERSION
  	s.summary = "A non-MIME ruby base64 library"
  	s.description = "Standards compliant port of ruby std lib Base64"
  	s.author = "Alan Da Costa"
  	s.email = "alandacosta@gmail.com"
  	s.homepage = "http://github.com/adacosta/base64_compatible"
  	s.has_rdoc = false

  	s.files = FileList["Rakefile", "{lib,test}/**/*"]
  end
rescue LoadError
  puts "Rake not available. Install it with: sudo gem install rake"
end