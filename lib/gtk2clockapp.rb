module Gtk2ClockApp
  VERSION = '2.1.210812'

  def self.gui
    require 'gtk3'
    require 'such'
    Such::Things.in Gtk::Widget
    require 'gtk2clockapp/config'
    Such::Thing.configure(CONFIG)
    require 'gtk2clockapp/gui'
    Gui.new
  end
end
# Requires:
#`ruby`
