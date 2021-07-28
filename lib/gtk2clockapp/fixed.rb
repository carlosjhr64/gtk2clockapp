module Gtk2ClockApp
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
end
