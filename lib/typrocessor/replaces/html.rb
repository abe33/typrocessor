class Typrocessor::Replace
  HTML = ruleset do
    replace 'quotes', /(\u00ab|\u00bb|\u201c|\u201d)/, '<span class="dquo">\1</span>'
    replace 'ampersand', /(&amp;|&)($|\s)/, '<span class="amp">\1</span>\2'
    replace 'caps', /(([A-Z]\.?){2,})/, '<span class="caps">\1</span>'
  end
end
