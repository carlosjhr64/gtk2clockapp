module Gtk2ClockApp
  FONT = {
    SMALL:  Pango::FontDescription.new('Arial 36'),
    MEDIUM: Pango::FontDescription.new('Arial 96'),
    BIG:    Pango::FontDescription.new('Arial 250'),
  }

  COLOR = {
    BACKGROUND: '#000000',
    DAY:        '#00FF00',
    NIGHT:      '#3F0000',
  }

  CONFIG = {
    time:  '%l:%M %p',
    date1: '%Y-%m-%d',
    date2: '%A %B %e',

    background: COLOR[:BACKGROUND],
    day:        COLOR[:DAY],
    night:      COLOR[:NIGHT],

    # Window
    WINDOW: [],
    window: {
      set_title: 'Gtk2ClockApp',
      override_background_color: [:normal, Gdk::RGBA.parse(COLOR[:BACKGROUND])],
    },
    window!: [:WINDOW, :window, 'destroy'],

    # Vbox
    VBOX: [:vertical],
    vbox: {},
    vbox!: [:VBOX, :vbox],

    # Hbox
    HBOX: [:horizontal],
    hbox: {},
    hbox!: [:HBOX, :hbox],

    # Labels
    LABEL: [''],

    # Big label
    big_label: {
      override_font: FONT[:BIG],
      override_color: [:normal, Gdk::RGBA.parse(COLOR[:DAY])],
      into: [:pack_start, expand: false, fill: true, padding: 20],
    },
    big_label!: [:LABEL, :big_label],

    # Medium label
    medium_label: {
      override_font: FONT[:MEDIUM],
      override_color: [:normal, Gdk::RGBA.parse(COLOR[:DAY])],
      into: [:pack_start, expand: false, fill: true, padding: 20],
    },
    medium_label!: [:LABEL, :medium_label],

    # Small label
    small_label: {
      override_font: FONT[:SMALL],
      override_color: [:normal, Gdk::RGBA.parse(COLOR[:DAY])],
      into: [:pack_start, expand: false, fill: true, padding: 20],
    },
    small_label!: [:LABEL, :small_label],
  }
end
