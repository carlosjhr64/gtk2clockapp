module Gtk2ClockApp
  class Gui
    def now(key)
      Time.now.strftime(CONFIG[key])
    end

    def initialize
      window = Such::Window.new :window! do Gtk.main_quit end
      vbox = Such::Box.new window, :vbox!

      hbox = Such::Box.new vbox, :hbox!
      date = Such::Label.new hbox, :medium_label!
      date.set_text now(:date1)
      dkey = 0
      GLib::Timeout.add(5*1000) do
        dkey = (dkey+1)%2
        date.set_text now([:date1,:date2][dkey])
      end

      hbox = Such::Box.new vbox, :hbox!
      time = Such::Label.new hbox, :big_label!
      time.set_text now(:time)
      GLib::Timeout.add(60*1000) do
        time.set_text now(:time)
      end

      hbox = Such::Box.new vbox, :hbox!
      weather = Such::Label.new hbox, :medium_label!
      weather.set_text '70F 95F/66F'
      GLib::Timeout.add(15*60*1000) do
        weather.set_text '70F 95F/66F'
      end

      hbox = Such::Box.new vbox, :hbox!
      spot = Such::Label.new hbox, :medium_label!
      spot.set_text 'BTC: $40,000'
      skey = 0
      GLib::Timeout.add(3*1000) do
        skey = (skey+1)%3
        spot.set_text(['BTC: $40,000','BCH: $500', 'WMT: $100'][skey])
      end

      hbox = Such::Box.new vbox, :hbox!
      alerts = Such::Label.new hbox, :small_label!
      alerts.set_text 'Squirrel!!!'

      window.show_all
      Gtk.main
    end
  end
end
=begin
  class Fixed < Gtk2AppLib::Widgets::Fixed

    def initialize(pack)
      super(pack, Configuration::OPTIONS)
      @previous = {}
      @count = 14
      @previous = {}
      self.update # update defined below
    end

    def weather
      data = Gtk2ClockApp.http_get(Configuration::WEATHER_URL)
      temps = []
      while md = Configuration::TEMPERATURE_MATCH.match(data)
        temps.push( md[1]+'F' )
        data = md.post_match
      end
      return temps
    end

    def update
      current = {}
      @count += 1

      begin
        if @count > 14 then
          @count = 0
          temperatures = nil
          temperatures = weather
          current[:temp] = temperatures[0]
          current[:more] =
		" #{temperatures[2]}/#{temperatures[3]}   #{temperatures[4]}/#{temperatures[5]}   #{temperatures[6]}/#{temperatures[7]}"
        end
      rescue Exception
        $!.puts_bang!
        current[:temp] = ''
        current[:more] = ''
      end

      now = Time.now + Configuration::OFFSET
      current[:day] = now.strftime("%A\n%B %d, %Y")
      current[:date] = now.strftime("%B %d, %Y")
      current[:time] = now.strftime("%I:%M").sub(/^0/,' ')
      current[:timep] = now.strftime("%p")

      [:time,:timep,:temp,:day, :more].each{|key|
        if current[key] && !(@previous[key] == current[key]) then
          tag = key.to_s
	  self.remove_tag(tag) # removed_tag defined by super class
          self.options[:modify_font] = (key==:time)? Gtk2AppLib::Configuration::FONT[:LARGE]: (key==:temp)? Gtk2AppLib::Configuration::FONT[:NORMAL]: Gtk2AppLib::Configuration::FONT[:SMALL]
          x_coord, y_coord = Configuration::POSITION[key]
          self.put(current[key], x_coord, y_coord, [tag]) # put defined by super class
          @previous[key] = current[key]
        end
      }

      self.show_all
    end

  end
=end
