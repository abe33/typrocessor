class Typrocessor::Replace
  Symbols = ruleset do
    replace 'copyright', /\([cC]\)/, '©'
    replace 'trademark', /\bTM\b/, '™'
    replace 'registered', /\([rR]\)/, '®'
  end
end
