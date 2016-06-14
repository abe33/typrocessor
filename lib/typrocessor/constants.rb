module Typrocessor
  module Constants
    FRACTIONS = [
      [1, 4,  "\u00bc"],
      [1, 2,  "\u00bd"],
      [3, 4,  "\u00be"],
      [1, 7,  "\u2150"],
      [1, 9,  "\u2151"],
      [1, 10, "\u2152"],
      [1, 3,  "\u2153"],
      [2, 3,  "\u2154"],
      [1, 5,  "\u2155"],
      [2, 5,  "\u2156"],
      [3, 5,  "\u2157"],
      [4, 5,  "\u2158"],
      [1, 6,  "\u2159"],
      [5, 6,  "\u215a"],
      [1, 8,  "\u215b"],
      [3, 8,  "\u215c"],
      [5, 8,  "\u215d"],
      [7, 8,  "\u215e"],
      [0, 3,  "\u2189"]
    ]

    UNIT_SCALES = [
      'y',
      'z',
      'a',
      'f',
      'p',
      'n',
      'µ',
      'm',
      'c',
      'd',
      '',
      'da',
      'h',
      'k',
      'M',
      'G',
      'T',
      'P',
      'E',
      'Z',
      'Y'
    ]

    SCALABLE_UNITS = [
      'm',
      'm²',
      'm³',
      'g',
      's',
      'l',
      'L',
      'b',
      'B',
      'K',
      'W',
      'V',
      'Hz',
      'Ω',
      'A',
      'mol',
      'cd'
    ]

    SURFACE_UNITS = [
      'mile',
      'miles',
      'in',
      'yd',
      'ft',
      'm'
    ]

    VOLUME_UNITS = [
      'in',
      'yd',
      'ft',
      'm'
    ]

    OTHER_UNITS = [
      # temperatures
      '°C',
      '°F',
      '°Ré',
      '°N',
      '°Ra',
      # distances
      'mi',
      'in',
      'ft',
      'yd',
      'nautical mile',
      'nautical miles',
      # speed
      'kmph',
      'km/h',
      'mps',
      'm/s',
      'mph',
      'mi/h',
      'knot',
      'knots',
      'nautical mile/h',
      'nautical miles/h',
      'ma',
      # surfaces
      'ha',
      'a',
      'ca',
      'mile²',
      'miles²',
      'in²',
      'yd²',
      'ft²',
      'ro',
      'acre',
      'acres',
      'nautical mile²',
      'nautical miles²',
      # volumes
      'in³',
      'ft³',
      'yd³',
      'gal',
      'bbl',
      'pt',
      'fluid pt',
      'dry pt',
      # weight
      't',
      'carat',
      'grain',
      'oz',
      'lb',
      'cwt',
      'ton',
      'st',
      # time
      'h',
      'min',
      # electric
      'dBm',
      'dBW',
      'var',
      'VA',
      'F',
      'H',
      'S',
      'C',
      'Ah',
      'J',
      'kWh',
      'eV',
      'Ω∙m',
      'S/m',
      'V/m',
      'N/C',
      'V·m',
      'T',
      'G',
      'Wb',
      'dB',
      'ppm'
    ]

    ALL_UNITS = OTHER_UNITS + UNIT_SCALES.product(SCALABLE_UNITS).map(&:join)

  end
end
