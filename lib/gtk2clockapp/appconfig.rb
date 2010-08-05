module Gtk2AppLib
module Configuration

  # Need the weather.com url for your area
  # your area code should be enough
  AREA_CODE	= (ARGV[0])? ARGV.shift: '89433' # <= 89433 is for Sun Valley, NV. Edit it your area code.
  # or edit in your area's www.weather.com url
  WEATHER_URL	= 'http://www.weather.com/weather/today/' + AREA_CODE

  # You should not need to worry about these below, but just in case...

  TEMPERATURE_MATCH = /(\d+)\s*\&deg\;/

  UPDATE_TIME = 60_000 # in milliseconds

  MENU[:fs]	= '_Fullscreen'	# fullscreen
  MENU[:close]	= nil
  MENU[:dock]	= nil
  MENU[:help]	= nil

  BACKGROUND_COLOR = COLOR[:black]

  FONT[:normal] = Pango::FontDescription.new( 'Arial 50' )
  FONT[:large] = Pango::FontDescription.new( 'Arial 100' )

  OPTIONS	= {
	:font => FONT[:normal],
	:fg	=>  {Gtk::STATE_NORMAL=>COLOR[:maroon]}
  }

  POSITION	= {
	:day	=> [20,20],
	:date	=> [20,110],
	:time	=> [30,230],
	:temp0	=> [570,10],
	:temp3	=> [570,80],
	:temp4	=> [570,150],
  }

end
end
