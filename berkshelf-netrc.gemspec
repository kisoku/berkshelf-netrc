$:.unshift(File.dirname(__FILE__) + '/lib')
require 'berkshelf-netrc/version'

Gem::Specification.new do |s|
  s.name = 'berkshelf-netrc'
  s.version = BerkshelfNetrc::VERSION
  s.platform = Gem::Platform::RUBY
  s.summary = 'extend berkshelf to support http authentication via netrc'
  s.description = s.summary
  s.author = 'Mathieu Sauve-Frankel'
  s.email = 'msf@kisoku.net'
  s.homepage = 'http://kisoku.github.io'
  s.license = 'Apache 2.0'
  s.add_dependency 'berkshelf'
  s.add_dependency 'netrc'
  s.require_path = 'lib'
  s.files = %w(LICENSE README.md CHANGELOG.md Rakefile) + Dir.glob('{lib,spec}/**/*', File::FNM_DOTMATCH).reject {|f| File.directory?(f)}
end
