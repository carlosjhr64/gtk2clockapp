require 'gtk2clockapp'

module Gtk2AppLib
module Configuration

  IP2LOCATION	= 'http://www.geoiptool.com/'

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

  MENU[:fs]	= '_Fullscreen'	# fullscreen
  MENU[:close]	= nil
  MENU[:dock]	= nil
  MENU[:help]	= nil

  BACKGROUND_COLOR = Color['Black']

  FONT[:Small]	= Pango::FontDescription.new( 'Arial 26' )
  FONT[:Normal]	= Pango::FontDescription.new( 'Arial 79' )
  FONT[:Large]	= Pango::FontDescription.new( 'Arial 210' )

  OPTIONS = {
	:modify_fg => [Gtk::STATE_NORMAL,Color['Maroon']],
	:modify_font=>FONT[:Normal],
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
