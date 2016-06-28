class Typrocessor::Replace
  Primes = ruleset do
    replace 'quadruple prime', /(\d)(""|'''')/, "\\1\u2057"
    replace 'triple prime', /(\d)(''')/, "\\1\u2034"
    replace 'double prime', /(\d)("|'')/, "\\1\u2033"
    replace 'single prime', /(\d)'/, "\\1\u2032"
  end
end
