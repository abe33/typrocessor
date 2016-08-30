module Typrocessor::Replace::En_UK
  extend Typrocessor::RulesetMaker

  sp = Typrocessor::Constants::ANY_SPACE
  spg = Typrocessor::Constants::SPACE_GROUP

  Spaces = ruleset do
    replace 'no space before punctuation', /#{sp}+(\.|,|;|:|!|\?|%|\)|\u2019|\u2026|\u2030|\u2031)/, '\1'
    replace 'no space after parenthesis', /(\()#{sp}+/, '\1'
    replace 'no space after quote', /([^s])(\u2019)#{sp}+/, '\1\2'
    replace 'space after punctuation', /(,|;|!|\?|%|\u2026|\u2030|\u2031)([^#{spg}\)])/, '\1 \2'
    replace 'space after period or colon', /(\D)(\.|:)([^#{spg}\)])/, '\1\2 \3'
    replace 'space after parenthesis', /(\))(\w)/, '\1 \2'
    replace 'space before parenthesis', /([^#{spg}])(\()/, '\1 \2'

    replace 'no space around en dash between numbers', /(\d)#{sp}*\u2013#{sp}*(\d)/, "\\1\u2013\\2"
    replace 'no space around em dash', /#{sp}*(\u2014)#{sp}*/, '\1'
    replace 'space around en dash', /([^\d#{spg}])#{sp}*(\u2013)#{sp}*(\D)/, "\\1\u00a0\\2 \\3"

    replace 'no space after left quote', /(\u201c)#{sp}*([^#{spg}])/, '\1\2'
    replace 'no space before right quote', /([^#{spg}])#{sp}*(\u201d)/, '\1\2'

    replace 'non breaking space after honorific', /(Mr|Mrs|Ms|Miss|Sir|Lady)#{sp}*([A-Z])/, "\\1\u00a0\\2"
  end

  Currencies = ruleset do
    replace 'no space after currency', /([#{Typrocessor::Constants::CURRENCIES_REGEX}])#{sp}?(\d)/, '\1\2'
  end

  HTML = ruleset do
    replace 'ordinal numbers', /(\d)(st|nd|rd|th)/, '\1<span class="ord">\2</span>'
  end
end
