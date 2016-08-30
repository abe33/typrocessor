class Typrocessor::Ignore
  Markdown = ruleset do
    ignore 'link or image start', /!?\[/
    ignore 'link or image url', /\]\([^\)]+\)/
    ignore 'link or image from external definition', /\]\s*\[[^\]]*\]/
    ignore 'link or image external definition', /\[[^\]]+\]:.*$/
    ignore 'code block', /(```)(.|\n)*?\1/m
    ignore 'preformatted block', /^\x20{4}.*$/
    ignore 'inline code', /(`{1,2}).*?\1/
    ignore 'strong', /\*\*|__/

    ignore 'urls', /\b((?:[a-zA-Z][\w-]+:(?:\/{1,3}|[a-zA-Z0-9%])|www\d{0,3}[.]|[a-zA-Z0-9.\-]+[.][a-zA-Z]{2,4}\/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'".,<>?\u00AB\u00BB\u201C\u201D\u2018\u2019]))/
  end
end
