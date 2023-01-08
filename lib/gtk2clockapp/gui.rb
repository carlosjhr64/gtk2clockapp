module Gtk2ClockApp
  class Gui
    def new_label(key)
      hbox = Such::Box.new @vbox, :hbox!
      Such::Label.new hbox, key
    end
   
    def initialize
      @window = Such::Window.new :window! do Gtk.main_quit end
      @window.set_decorated !OPTIONS.notdecorated?
      @window.fullscreen if OPTIONS.fullscreen?
      @vbox = Such::Box.new @window, :vbox!

      @date    = new_label(:medium_label!)
      @time    = new_label(:big_label!)
      @weather = new_label(:medium_label!)
      @spot    = new_label(:medium_label!)
      @alert   = new_label(:small_label!)

      @window.show_all
    end

    def set_date(text)    = @date.set_text text
    def set_time(text)    = @time.set_text text
    def set_weather(text) = @weather.set_text text
    def set_spot(text)    = @spot.set_text text
    def set_alert(text)   = @alert.set_text text
    def labels     = [@date, @time, @weather, @spot, @alert]
    def day_mode   = labels.each{_1.override_color(:normal,CONFIG[:Day])}
    def dusk_mode  = labels.each{_1.override_color(:normal,CONFIG[:Dusk])}
    def night_mode = labels.each{_1.override_color(:normal,CONFIG[:Night])}
  end
end
