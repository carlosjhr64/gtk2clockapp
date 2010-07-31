require 'net/http'
require 'timeout'

module Gtk2ClockApp
  class Fixed < Gtk2App::Fixed
    include Configuration

    def http_get(url)
      uri = URI.parse(url)
      Net::HTTP.start(uri.host, uri.port) do |http|
        path_query = (uri.query)? uri.path + '?' + uri.query: uri.path
        resp,data = http.get(path_query)
        raise resp.message if !(resp.code == '200')
        return data
      end
    end

    def weather
      temps = []

      data = http_get(WEATHER_URL)
      while md = TEMPERATURE_MATCH.match(data)
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
          temperatures = nil
          Timeout::timeout(60) do
            temperatures = weather
          end
          current[:temp0]	= temperatures[0]
          current[:temp3]	= temperatures[3]
          current[:temp4]	= temperatures[4]
          @count = 0
        end
      rescue
        puts_bang!
        current[:temp0] = 'N/A'
        current[:temp3] = nil
        current[:temp4] = nil
      end

      now = Time.now
      current[:day] = now.strftime("%A")
      current[:date] = now.strftime("%B %d, %Y")
      current[:time] = now.strftime("%I:%M %p").sub(/^0/,' ')

      [:day,:date,:time,:temp0,:temp3,:temp4].each{|key|
        if current[key] && !(@previous[key] == current[key]) then
          tag = key.to_s
	  remove_tag(tag)
          x,y = POSITION[key]
          OPTIONS[:font] = (key==:time)? FONT[:large]: FONT[:normal]
          put(current[key], x, y, tag)
          @previous[key] = current[key]
        end
      }

      self.show_all
    end

    def initialize(pack=nil)
      super(nil, pack, OPTIONS)
      @previous = {}
      @count = 14
      update
    end

  end
end
