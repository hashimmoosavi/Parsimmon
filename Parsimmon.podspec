Pod::Spec.new do |s|
  # pod customization goes in here
  s.name     = 'Parsimmon'
  s.version  = '0.5.0'

  s.ios.deployment_target = “10.0”
  s.osx.deployment_target = "10.9"
  s.tvos.deployment_target = "9.0"

  s.license  = { :type => 'MIT' }
  s.homepage = 'http://www.parsimmon.com'
  s.summary  = 'Linguistics toolkit for iOS'
  s.requires_arc = true

  s.author = {
    'Syed Ali Hashim Moosavi' => ‘hashim.moosavi@gmail.com’
  }
  s.source = {
    :git => 'https://github.com/hashimmoosavi/Parsimmon.git',
    :tag => s.version
  }
  s.source_files = 'Parsimmon/*.swift'
end
