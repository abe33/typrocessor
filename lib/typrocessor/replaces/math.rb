module Typrocessor::Replace::Math
  extend Typrocessor::RulesetMaker

  Symbols = ruleset do
    replace 'minus sign', /-/, "\u2212"
    replace 'multiply sign', /\*/, "\u00d7"
    replace 'multiply sign', /(\d\s*)x(\s*\d)/, "\\1\u00d7\\2"
    replace 'divide sign', /\//, "\u00f7"
    replace 'greater than or equal to sign', />=/, "\u2265"
    replace 'lower than or equal to sign', /<=/, "\u2264"
    replace 'strictly equivalent sign', /===/, "\u2263"
    replace 'not equivalent sign', /!==/, "\u2262"
    replace 'equivalent sign', /==/, "\u2261"
    replace 'not equal sign', /!=/, "\u2260"
  end

  Fractions = ruleset do
    Typrocessor::Constants::FRACTIONS.each do |a,b,char|
      replace "#{a}/#{b}", /\b#{a}\s*\/\s*#{b}\b/, char
    end
  end

  Primes = ruleset do
    replace 'quadruple prime', /""|''''/, "\u2057"
    replace 'triple prime', /'''/, "\u2034"
    replace 'double prime', /"|''/, "\u2033"
    replace 'single prime', /'/, "\u2032"
  end
end
