require 'net/http'
require 'timeout'
require 'date'

if !(DateTime.method_defined? :to_time) then
  class DateTime
    def to_time
      Time.mktime(self.year, self.month, self.day, self.hour, self.min, self.sec)
    end
  end
end

module Gtk2AppLib
module Configuration
  MENU[:fs]	= '_Fullscreen'	# fullscreen
  MENU[:close]	= '_Close'
  MENU[:dock]	= nil
  MENU[:help]	= nil

  FONT[:SMALL]	= Pango::FontDescription.new( 'Arial 26' )
  FONT[:NORMAL]	= Pango::FontDescription.new( 'Arial 79' )
  FONT[:LARGE]	= Pango::FontDescription.new( 'Arial 210' )
end
end

module Gtk2ClockApp

  def self.http_get(url)
    Timeout::timeout(15) do
      uri = URI.parse(url)
      Net::HTTP.start(uri.host, uri.port) do |http|
        path_query = (uri.query)? uri.path + '?' + uri.query: uri.path
        response = http.get(path_query)
        raise response.message if !(response.code == '200')
        return response.body
      end
    end
  end

  def self.location(args)
    if args.length > 0 then
      return args.join('+')
    else
      area = []
      data = Gtk2ClockApp.http_get(Configuration::IP2LOCATION)
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
      data = Gtk2ClockApp.http_get(Configuration::TIME_SERVER)
      if data =~ Configuration::TIMEX then
        utc = DateTime.parse($1.strip).to_time.to_i
        now = Time.now.to_i
        ret = utc - now
      end
    end
    $stderr.puts "OFFSET = #{ret}"	if $trace
    return ret
  end

module Configuration

  BACKGROUND_COLOR = Gtk2AppLib::Color['Black']

  IP2LOCATION	= 'http://www.geoiptool.com/'

  TIMEX		= /<BR>([^<>]+)UTC/
  TIME_SERVER	= 'http://tycho.usno.navy.mil/cgi-bin/timer.pl'

  # Assumes time might be upto an hour off, and uses TIME_SERVER to fix it.
  OFFSET = Gtk2ClockApp.offset

  # Need the weather url for your area
  # your area code should be enough
  # If note given in ARGV, then will use IP2LOCATION
  AREA_CODE	= Gtk2ClockApp.location(ARGV)
  $stderr.puts "Area Code: #{AREA_CODE}" if $trace
  WEATHER_URL	= 'http://www.google.com/ig/api?weather=' + AREA_CODE
  $stderr.puts WEATHER_URL if $trace

  # You should not need to worry about these below, but just in case...

  TEMPERATURE_MATCH = /data="-?(\d{1,3})"/

  UPDATE_TIME = 60_000 # in milliseconds

  OPTIONS = {
	:modify_fg => [Gtk::STATE_NORMAL,Gtk2AppLib::Color['Maroon']],
	:modify_font=>Gtk2AppLib::Configuration::FONT[:NORMAL],
  }

  POSITION	= {
	:time	=> [0,   0],
	:timep	=> [705, 210],
	:temp	=> [25,  275],
	:day	=> [335, 300],
	:more	=> [25,  425],
  }
end
end
