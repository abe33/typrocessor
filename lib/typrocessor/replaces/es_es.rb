module Typrocessor::Replace::Es_ES
  extend Typrocessor::RulesetMaker

  sp = Typrocessor::Constants::ANY_SPACE
  spg = Typrocessor::Constants::SPACE_GROUP

  Spaces = ruleset do
    replace 'nbsp before punctuation', /([^#{spg}])#{sp}?([?!])/, "\\1\u202F\\2"
    replace 'nbsp after punctuation', /([¿¡])[#{spg}]*([^#{spg}])/, "\\1\u202F\\2"
    replace 'no space before  punctuation', /[#{spg}]+(\.|,|;|:|%|\)|\u2019|\u2026|\u2030|\u2031)/, '\1'
    replace 'no space after  punctuation', /(\u2019|\()[#{spg}]+/, '\1'
    replace 'no space around en-dash between numbers', /(\d)[#{spg}]*\u2013[#{spg}]*(\d)/, "\\1\u2013\\2"
    replace 'space around en-dash', /([^\d#{spg}])[#{spg}]*(\u2013)[#{spg}]*(\D)/, "\\1\u00a0\\2 \\3"
    replace 'space after  punctuation', /(\.|;|!|\?|%|\u2026|\u2030|\u2031)([^#{spg}\)])/, '\1 \2'
    replace 'space after colon', /(\D[#{spg}]?)(:)([^#{spg}\)])/, '\1\2 \3'
    replace 'space after comma', /(\D)(,)([^#{spg}\)])/, '\1\2 \3'
    replace 'space after left quote', /(\u00ab)[#{spg}]*([^#{spg}])/, "\\1\u202F\\2"
    replace 'space before right quote', /([^#{spg}])[#{spg}]*(\u00bb)/, "\\1\u202F\\2"
    replace 'space after parenthesis', /(\))(\w)/, '\1 \2'
    replace 'space before parenthesis', /([^#{spg}])(\()/, '\1 \2'
  end

  Currencies = ruleset do
    replace 'space before currency', /(\d)\x20?([#{Typrocessor::Constants::CURRENCIES_REGEX}])/, "\\1\u00a0\\2"
  end
end
