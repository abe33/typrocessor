class Typrocessor::Replace
  LineBreaks = ruleset do
    replace 'number before word', /(\d)\x20(\D)/, "\\1\u00a0\\2"
    replace 'short words', /\b(\w{1,3})\x20/, "\\1\u00a0"
    replace 'widont', /([\w]+)\x20([\w\u2011-]+\.)\x20*$/m, "\\1\u00a0\\2"
  end
end
