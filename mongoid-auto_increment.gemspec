# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

require 'mongoid/auto_increment/version'

Gem::Specification.new do |s|
  s.license     = 'MIT'
  s.name        = 'mongoid-auto_increment'
  s.version     = Mongoid::AutoIncrement::VERSION
  s.authors     = ['Geoffroy Planquart']
  s.email       = ['geoffroy@planquart.fr']
  s.homepage    = 'https://github.com/Aethelflaed/mongoid-auto_increment'
  s.summary     = 'Auto-incremented field for Mongoid'
  s.description = 'Let you define an auto-incremented field in Mongoid, which will behave like SQL id field.'

  s.files       = Dir['{lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files  = Dir['test/**/*']

  s.add_dependency 'mongoid',       '>= 5.0.0', '< 7.2.0'
  s.add_dependency 'activesupport', '>= 4.2.0', '< 6.1.0'
end
