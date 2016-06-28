module Typrocessor::Replace::Math
  extend Typrocessor::RulesetMaker

  Fractions = ruleset do
    Typrocessor::Constants::FRACTIONS.each do |a,b,char|
      replace "#{a}/#{b}", /\b#{a}\s*\/\s*#{b}\b/, char
    end
  end
end
