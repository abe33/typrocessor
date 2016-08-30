# Preferred rules order:
#
# - Punctuations
# - Abbreviations
# - Numbers
# - Quotes
# - Spaces
# - Currencies
# - Ordinals
# - Dates
# - Ligatures
# - HTML
module Typrocessor::Replace::Fr_FR
  extend Typrocessor::RulesetMaker

  sp = Typrocessor::Constants::ANY_SPACE
  spg = Typrocessor::Constants::SPACE_GROUP

  Spaces = ruleset do
    replace 'collapse multiple spaces', /\x20{2,}/, ' '
    replace 'no space before punctuation', /#{sp}+(,|\.|\)|\u2026|\u2019)/, '\1'
    replace 'no space after punctuation', /(\u2019|\()#{sp}+/, '\1'
    replace 'no space around en dash between numbers', /(\d)#{sp}*\u2013#{sp}*(\d)/, "\\1\u2013\\2"
    replace 'non breaking space before punctuation', /([^#{spg}])(?:\x20)?([?!;%\u2030\u2031])/, "\\1\u202F\\2"
    replace 'non breaking space before colon', /([^#{spg}\d])(?:\x20)?(:)/, "\\1\u202F\\2"
    replace 'non breaking space before colon between two numbers 1', /(\d)#{sp}*(:)(#{sp}\d)/, "\\1\u202F\\2\\3"
    replace 'non breaking space before colon between two numbers 2', /(\d)#{sp}(:)(\d)/, "\\1\u202F\\2\\3"
    replace 'non breaking space before colon after number', /(\d)#{sp}*(:)(\D)/, "\\1\u202F\\2\\3"
    replace 'space after punctuation', /(;|!|\?|%|\u2026|\u2030|\u2031)([^#{sp}\)])/, '\1 \2'
    replace 'space after period', /(\.)([^\)\u2011#{spg}-])/, '\1 \2'
    replace 'space after colon', /(\D#{sp}?)(:)([^#{spg}\)])/, '\1\2 \3'
    replace 'space after comma', /(\D)(,)([^#{spg}\)])/, '\1\2 \3'
    replace 'space after parenthesis', /(\))(\w)/, '\1 \2'
    replace 'space before parenthesis', /(\S)(\()/, '\1 \2'
    replace 'space around en dash', /([^\d#{spg}])\x20*(\u2013)\x20*(\D)/, "\\1\u00a0\\2 \\3"
    replace 'space after left quote', /(\u00ab)\x20*([^#{spg}])/, "\\1\u202F\\2"
    replace 'space before right quote', /([^#{spg}])\x20*(\u00bb)/, "\\1\u202F\\2"
    replace 'non breaking space after honorific', /(MM\.|M\.|Mme|Mmes|Mlle|Mlles|Dr|Me|Mgr)\x20([A-Z])/, "\\1\u00a0\\2"
  end

  Punctuations = ruleset do
    replace 'en dash between words', /(\D\x20)-(\x20\D)/, "\\1\u2013\\2"
    replace 'en dash between numbers', /(\d)#{sp}*(?:-|\u2011)#{sp}*(\d)/, "\\1\u2013\\2"
    replace 'anti', /anti(?:-|\u2011)([^i]\w+)(?!-|\u2011)\b/, 'anti\1'
  end

  Abbreviations = ruleset do
    replace 'male honorific', /Mr\.?/, 'M.'
    replace 'possessive interrogative', /a(-|\u2011)t'il/, "a\u2011t\u2011il"
    replace 'cad', /(?<!\w)c\.?(-|\u2011)?[aà](-|\u2011)?d\.?(?!\w)/, "c.\u2011à\u2011d."
    replace 'number abbr', /(n|N)°/, "\\1\u00ba"
  end

  Currencies = ruleset do
    replace 'space before currency', /(\d)\x20?([#{Typrocessor::Constants::CURRENCIES_REGEX}])/, "\\1\u00a0\\2"
  end

  Ordinals = ruleset do
    replace 'greater than 10', /(\d{2,})emes\b/, '\1èmes'
    replace 'first female plural', /(\d{1})[èe]res\b/, '\1res'
    replace 'lower than 10', /((^|[^\d])\d)[èe]mes\b/, '\1es'
    replace 'first female', /(\d)[èe]re\b/, '\1re'
    replace 'first male', /(\d)[èe]me(?!s)\b/, '\1e'
  end

  Quotes = ruleset do
    replace 'single quote', /(\w)'(\w)/, "\\1\u2019\\2"
    replace 'double quote', /"([^"]+)"/, "\u00ab\\1\u00bb"
  end

  Dates = ruleset do
    replace 'days and months', /(Lundi|Mardi|Mercredi|Jeudi|Vendredi|Samedi|Dimanche|Janvier|Février|Mars|Avril|Mai|Juin|Juillet|Aout|Septembre|Octobre|Novembre|Décembre)/ do |s|
      s.downcase
    end
  end

  Ligatures = ruleset do
    replace 'lower oe', /oe/, "\u0153"
    replace 'upper oe', /O[eE]/, "\u0152"
    replace 'lower ae', /ae/, "\u00e6"
    replace 'upper ae', /A[eE]/, "\u00c6"
  end

  Numbers = ruleset do
    scales = {
      '1000000' => 'million',
      '1000000000' => 'milliard',
      '1000000000000' => 'billion',
      '1000000000000000' => 'billiard',
      '1000000000000000000' => 'trillion',
      '1000000000000000000000' => 'trilliard',
    }

    scales.each_pair do |value, word|
      divider = value.to_f
      size = value.size

      replace "#{value}s", /(?<!\d)[1-9]\d{#{size-1},#{size+1}}(?![,.\d])/ do |m|
        if m =~ /0{#{size-2},#{size-1}}$/
          n = m.to_i / divider
          n >= 2 ? "#{n} #{word}s" : "#{n} #{word}"
        else
          m
        end
      end
    end

    replace 'number spacing', /(?<!\d)[1-9]\d{3}\d+/ do |m|
      m.reverse.split(/(\d{3})/).select {|s| !s.empty? }.join(' ').reverse
    end
    replace 'dot in number', /(\d)\.(\d)/, '\1,\2'
  end

  HTML = ruleset do
    replace 'abbr with super text', /\b(Mmes|Mme|Mlles|Mlle|Me|Mgr|Dr|cie|Cie|Sté)\b/ do |m|
      "#{m[0]}<sup>#{m[1..-1]}</sup>"
    end
    replace 'ordinal numbers', /(\d)(res|re|es|e|èmes)/, '\1<sup class="ord">\2</sup>'
  end
end
