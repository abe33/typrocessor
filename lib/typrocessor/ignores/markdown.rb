class Typrocessor::Ignore
  Markdown = ruleset do
    ignore 'link or image start', /!?\[/
    ignore 'link or image url', /\]\s*\([^\)]+\)/
    ignore 'link or image from external definition', /\]\s*\[[^\]]*\]/
    ignore 'link or image external definition', /\[[^\]]+\]:.*$/
    ignore 'code block', /(```)(.|\n)*?\1/m
    ignore 'preformatted block', /^\x20{4}.*$/
    ignore 'inline code', /(`{1,2}).*?\1/
    ignore 'strong', /\*\*|__/

    ignore 'urls', /\bhttp(s?)[^\s\)\]]*/ # more complex regex induces VERY long processing times
  end
end
