class Typrocessor::Ignore
  HTML = ruleset do
    ignore 'tag', /<[^>]+>/
    ignore 'tag content', /<(pre|kbd|code|style|script|textarea)[^>]*>.*?<\/\1>/
  end
end
