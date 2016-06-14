class Typrocessor::Replace
  Punctuations = ruleset do
    replace 'collapse multiple punctuation', /([!?])\1+/, '\1'
    replace 'short etc', /([Ee]tc)(\.{3}|\u2026)/, '\1.'
    replace 'triple periods', /\.{3,}/, "\u2026"
    replace 'non breaking hyphen', /(\w)-(\w)/, "\\1\u2011\\2"
  end
end
