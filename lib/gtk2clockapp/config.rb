module Gtk2ClockApp
  OPTIONS ||= nil

  g      = 2 - (1 + Math.sqrt(5))/2
  big    = OPTIONS&.size? || 186
  medium = (big*g).round
  small  = (big*g*g).round
  pad    = (big*g*g*g).round

  fontname = OPTIONS&.font || 'Courier'
  font = {
    BIG:    Pango::FontDescription.new("#{fontname} #{big}"),
    MEDIUM: Pango::FontDescription.new("#{fontname} #{medium}"),
    SMALL:  Pango::FontDescription.new("#{fontname} #{small}"),
  }

  color = {
    Background: '#'+(OPTIONS&.background || '000000'),
    Day:        '#'+(OPTIONS&.day        || '00FF00'),
    Dusk:       '#'+(OPTIONS&.dusk       || 'FF0000'),
    Night:      '#'+(OPTIONS&.night      || '3F0000'),
  }

  CONFIG = {
    Time:  '%l:%M %p',
    DateA: '%Y-%m-%d',
    DateB: '%A %B %e',

    Background: color[:Background],
    Day:        color[:Day],
    Dusk:       color[:Dusk],
    Night:      color[:Night],

    # Window
    WINDOW: [],
    window: {
      set_title: 'Gtk2ClockApp',
      override_background_color: [:normal, color[:Background]],
    },
    window!: [:WINDOW, :window, 'destroy'],

    # Vbox
    VBOX: [:vertical],
    vbox: {},
    vbox!: [:VBOX, :vbox],

    # Hbox
    HBOX: [:horizontal],
    hbox: {
      into: [:pack_start, expand: false, fill: true, padding: pad],
    },
    hbox!: [:HBOX, :hbox],

    # Labels
    LABEL: [''],

    # Big label
    big_label: {
      override_font: font[:BIG],
      override_color: [:normal, color[:Day]],
      into: [:pack_start, expand: false, fill: true, padding: pad],
    },
    big_label!: [:LABEL, :big_label],

    # Medium label
    medium_label: {
      override_font: font[:MEDIUM],
      override_color: [:normal, color[:Day]],
      into: [:pack_start, expand: false, fill: true, padding: pad],
    },
    medium_label!: [:LABEL, :medium_label],

    # Small label
    small_label: {
      override_font: font[:SMALL],
      override_color: [:normal, color[:Day]],
      into: [:pack_start, expand: false, fill: true, padding: pad],
    },
    small_label!: [:LABEL, :small_label],
  }
end
