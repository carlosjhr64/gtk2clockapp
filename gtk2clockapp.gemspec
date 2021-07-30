Gem::Specification.new do |s|

  s.name     = 'gtk2clockapp'
  s.version  = '2.0.210730'

  s.homepage = 'https://github.com/carlosjhr64/gtk2clockapp'

  s.author   = 'carlosjhr64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2021-07-30'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
A clock/bulletin board with a STDIN interface.

It's up to the user to wrap `gtk2clockapp` to provide additional functionality besides the clock.
It assumes it'll get weather info, spot prices, and alerts... but
one can put anything in those labels.
DESCRIPTION

  s.summary = <<SUMMARY
A clock/bulletin board with a STDIN interface.
SUMMARY

  s.require_paths = ['lib']
  s.files = %w(
README.md
bin/gtk2clockapp
lib/gtk2clockapp.rb
lib/gtk2clockapp/config.rb
lib/gtk2clockapp/gui.rb
  )
  s.executables << 'gtk2clockapp'
  s.add_runtime_dependency 'help_parser', '~> 7.0', '>= 7.0.200907'
  s.add_runtime_dependency 'gtk3', '~> 3.4', '>= 3.4.6'
  s.add_runtime_dependency 'such', '~> 2.0', '>= 2.0.210201'
  s.requirements << 'ruby: ruby 3.0.2p107 (2021-07-07 revision 0db68f0233) [x86_64-linux]'

end
