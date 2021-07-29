module Gtk2ClockApp
  VERSION = '2.0.210729'

  def self.run
    require 'gtk3'
    require 'such'
    Such::Things.in Gtk::Widget
    require 'gtk2clockapp/config'
    Such::Thing.configure(CONFIG)
    require 'gtk2clockapp/gui'
    Gui.new
  end
end
=begin
    program = Gtk2AppLib::Program.new( {
            'name'		=> 'Ruby-Gnome Clock',
            'authors'	=> ['carlosjhr64@gmail.com'],
            'website'	=> 'https://github.com/carlosjhr64/gtk2clockapp',
            'website-label'	=> 'Gtk2ClockApp',
            'license'	=> 'GPL',
            'copyright'	=> '2011-04-29 10:10:51',
            } )

    begin
      program.window do |window|
         window.modify_bg(Gtk::STATE_NORMAL, Gtk2ClockApp::Configuration::BACKGROUND_COLOR)
         fixed = Gtk2ClockApp::Fixed.new( window )
         tick = Gtk.timeout_add(Gtk2ClockApp::Configuration::UPDATE_TIME){ fixed.update }
         window.signal_connect('destroy'){ Gtk.timeout_remove(tick) }
         window.show_all
      end
    rescue Exception
      $!.puts_bang!
    ensure
      program.finalize
    end
=end
