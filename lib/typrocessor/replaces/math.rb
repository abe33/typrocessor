module Typrocessor::Replace::Math
  extend Typrocessor::RulesetMaker

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
