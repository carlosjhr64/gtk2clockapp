module Configuration
  WEATHER_URL	= 'http://www.weather.com/weather/today/Sun+Valley+NV+89433'
  TEMPERATURE_MATCH = /(\d+)\s*\&deg\;/

  UPDATE_TIME = 60_000 # in milliseconds

  MENU[:fs]	= '_Fullscreen'	# fullscreen
  MENU[:close]	= nil
  MENU[:dock]	= nil
  MENU[:help]	= nil

  BACKGROUND_COLOR = COLOR[:black]

  FONT[:normal] = Pango::FontDescription.new( 'Arial 50' )
  FONT[:large] = Pango::FontDescription.new( 'Arial 125' )

  OPTIONS	= {
	:font => FONT[:normal],
	:fg	=>  {Gtk::STATE_NORMAL=>COLOR[:maroon]}
  }

  POSITION	= {
	:day	=> [20,20],
	:date	=> [20,110],
	:time	=> [25,220],
	:temp0	=> [500,10],
	:temp3	=> [500,80],
	:temp4	=> [500,150],
  }
end
