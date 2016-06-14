class Typrocessor::Replace
  Fractions = ruleset do
    Typrocessor::Contants::FRACTIONS.each do |a,b,char|
      replace "#{a}/#{b}", /\b#{a}\s*\/\s*#{b}\b/, char
    end
  end
end
