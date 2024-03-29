Gem::Specification.new do |s|

  s.name     = 'gtk2clockapp'
  s.version  = '2.2.230108'

  s.homepage = 'https://github.com/carlosjhr64/gtk2clockapp'

  s.author   = 'CarlosJHR64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2023-01-08'
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
  s.add_runtime_dependency 'help_parser', '~> 8.1', '>= 8.1.221206'
  s.add_runtime_dependency 'gtk3', '~> 4.0', '>= 4.0.5'
  s.add_runtime_dependency 'such', '~> 2.1', '>= 2.1.230106'
  s.requirements << 'ruby: ruby 3.2.0 (2022-12-25 revision a528908271) [aarch64-linux]'

end
