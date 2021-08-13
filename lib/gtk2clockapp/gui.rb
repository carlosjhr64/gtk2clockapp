module Gtk2ClockApp
  class Gui
    def now(key)
      Time.now.strftime(CONFIG[key])
    end

    def new_label(key)
      hbox = Such::Box.new @vbox, :hbox!
      Such::Label.new hbox, key
    end

    def time_label(key, seconds, *formats)
      label = new_label(key)
      i = 0
      label.set_text now(formats[i])
      GLib::Timeout.add(seconds*1000) do
        i = (i+1)%formats.length
        label.set_text now(formats[i])
      end
      label
    end
   
    def initialize
      @window = Such::Window.new :window! do Gtk.main_quit end
      @window.set_decorated !OPTIONS.notdecorated?
      @window.fullscreen if OPTIONS.fullscreen?
      @vbox = Such::Box.new @window, :vbox!

      @date = time_label(:medium_label!, 5, :DateA, :DateB)
      @time = time_label(:big_label!, 60, :Time)

      @weather = new_label(:medium_label!)
      @spot    = new_label(:medium_label!)
      @alert   = new_label(:small_label!)

      @window.show_all
    end

    def set_weather(text)
      @weather.set_text text
    end

    def set_spot(text)
      @spot.set_text text
    end

    def set_alert(text)
      @alert.set_text text
    end

    def labels
      [@date, @time, @weather, @spot, @alert]
    end

    def day_mode
      labels.each do |label|
        label.override_color(:normal, CONFIG[:Day])
      end
    end

    def dusk_mode
      labels.each do |label|
        label.override_color(:normal, CONFIG[:Dusk])
      end
    end

    def night_mode
      labels.each do |label|
        label.override_color(:normal, CONFIG[:Night])
      end
    end
  end
end
