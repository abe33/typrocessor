class Typrocessor::Replace
  Spaces = ruleset do
    replace 'collapse multiple spaces', /\x20+/, ' '
  end
end
