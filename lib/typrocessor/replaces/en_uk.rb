module Typrocessor::Replace::En_UK
  extend Typrocessor::RulesetMaker

  HTML = ruleset do
    replace 'ordinal numbers', /(\d)(st|nd|rd|th)/, '\1<span class="ord">\2</span>'
  end
end
