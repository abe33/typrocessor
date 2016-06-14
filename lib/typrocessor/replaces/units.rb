class Typrocessor::Replace
  Units = ruleset do
    replace 'surface', "(#{Typrocessor::Constants::SURFACE_UNITS.join('|')})2", '\1²'
    replace 'volume', "(#{Typrocessor::Constants::VOLUME_UNITS.join('|')})3", '\1³'

    replace 'unit space', "(\\d)\\s*(#{Typrocessor::Constants::ALL_UNITS.join('|')})(?=[\\.,\\)\\s]|$)", "\\1\u202f\\2"
    replace 'no period after unit', "(#{Typrocessor::Constants::ALL_UNITS.join('|')})\\.(\\s[#{Typrocessor::Constants::LOWERCASE.join('')}])", '\1\2'
  end
end
