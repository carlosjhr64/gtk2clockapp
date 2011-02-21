require 'net/http'
require 'timeout'
require 'date'

module Gtk2ClockApp
  include Gtk2AppLib
    include Gtk2AppLib::Configuration

  def self.http_get(url)
    uri = URI.parse(url)
    Net::HTTP.start(uri.host, uri.port) do |http|
      path_query = (uri.query)? uri.path + '?' + uri.query: uri.path
      resp,data = http.get(path_query)
      raise resp.message if !(resp.code == '200')
      return data
    end
  end

  def self.location(args)
    if args.length > 0 then
      return args.join('+')
    else
      area = []
      data = Gtk2ClockApp.http_get(IP2LOCATION)
      data = data.gsub(/\s*<[^<>]*>\s*/,'|').gsub(/\|+/,'|').gsub(/\s+/,'+')
      if data =~ /City:\|([\w\+]+)\|/ then
        area.push($1)
      end
      if data =~ /Region:\|([\w\+]+)\|/ then
        area.push('+'+$1)
      end
      if data =~ /Country\+code:\|(\w+)/ then
        area.push(','+$1)
      end
      return area.join('')
    end
  end

  def self.offset
    ret = 0
    Exception.puts_bang! do
      data = Gtk2ClockApp.http_get(TIME_SERVER)
      if data =~ TIMEX then
        utc = DateTime.parse($1.strip)
        utc = Time.utc( utc.year, utc.month, utc.day, utc.hour, utc.min, utc.sec ).to_i
        diff = utc - Time.now.to_i
        ret = diff.abs % 3600
        ret = -ret	if diff < 0
      end
    end
    $stderr.puts "OFFSET = #{ret}"	if $trace
    return ret
  end

  class Fixed < Widgets::Fixed
    include Gtk2AppLib::Configuration

    def weather
      data = Gtk2ClockApp.http_get(WEATHER_URL)
      temps = []
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
          current[:temp] = temperatures[0]
          current[:more] =
		" #{temperatures[2]}/#{temperatures[3]}   #{temperatures[4]}/#{temperatures[5]}   #{temperatures[6]}/#{temperatures[7]}"
          @count = 0
        end
      rescue Exception
        $!.puts_bang!
        current[:temp] = ''
        current[:more] = ''
      end

      now = Time.now + OFFSET
      current[:day] = now.strftime("%A\n%B %d, %Y")
      current[:date] = now.strftime("%B %d, %Y")
      current[:time] = now.strftime("%I:%M").sub(/^0/,' ')
      current[:timep] = now.strftime("%p")

      [:time,:timep,:temp,:day, :more].each{|key|
        if current[key] && !(@previous[key] == current[key]) then
          tag = key.to_s
	  remove_tag(tag)
          self.options[:modify_font] = (key==:time)? FONT[:Large]: (key==:temp)? FONT[:Normal]: FONT[:Small]
          x_coord, y_coord = POSITION[key]
          put(current[key], x_coord, y_coord, [tag])
          @previous[key] = current[key]
        end
      }

      self.show_all
    end

    def initialize(pack)
      super(pack, OPTIONS)
      @previous = {}
      @count = 14
      @previous = {}
      update
    end

  end
end
