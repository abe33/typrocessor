require 'spec_helper'

describe 'Typrocessor::Replace::Es_ES::Spaces' do
  let(:processor) { Typrocessor::Processor.new(options) }
  let(:options) do { rules: [Typrocessor::Replace::Es_ES::Spaces] } end

  chars_with_space_after = [',', '.', "\u2026", ';', ':', '%', "\u2030", "\u2031"]
  chars_with_space_after.each do |char|
    it "adds a space after #{char} if there is no space" do
      expect(processor.process("Foo#{char}bar")).to eq("Foo#{char} bar")
    end

    it "does not add a space after #{char} if followed by a )" do
      expect(processor.process("(Foo#{char})")).to eq("(Foo#{char})")
    end
  end

  chars_with_no_space_before = [',', '.', "\u2026", ';', ':', '%', ')', "\u2019", "\u2030", "\u2031"]
  chars_with_no_space_before.each do |char|
    it "removes space before #{char}" do
      expect(processor.process("Foo #{char}")).to eq("Foo#{char}")
      expect(processor.process("Foo  #{char}")).to eq("Foo#{char}")
    end

    it "removes a non-breaking space before #{char}" do
      expect(processor.process("Foo\u00a0#{char}")).to eq("Foo#{char}")
      expect(processor.process("Foo\u00a0\u00a0#{char}")).to eq("Foo#{char}")
    end
  end

  chars_with_no_space_after = ["\u2019", '(']
  chars_with_no_space_after.each do |char|
    it "removes spaces after #{char}" do
      expect(processor.process("#{char} bar")).to eq("#{char}bar")
      expect(processor.process("#{char}  bar")).to eq("#{char}bar")
    end

    it "removes a non-breaking space after #{char}" do
      expect(processor.process("#{char}\u00a0bar")).to eq("#{char}bar")
      expect(processor.process("#{char}\u00a0\u00a0bar")).to eq("#{char}bar")

      expect(processor.process("#{char}\u202Fbar")).to eq("#{char}bar")
      expect(processor.process("#{char}\u202F\u202Fbar")).to eq("#{char}bar")
    end
  end

  it 'adds thin non-breaking spaces in questions' do
    expect(processor.process('¿Como te llamo?')).to eq("¿\u202fComo te llamo\u202f?")
  end

  it 'adds thin non-breaking spaces in exclamations' do
    expect(processor.process('¡Madre de dios!')).to eq("¡\u202fMadre de dios\u202f!")
  end

  it 'adds a space after a ) if the following char is not a punctuation' do
    expect(processor.process('foo (bar)foo')).to eq('foo (bar) foo')
    expect(processor.process('foo (bar). foo')).to eq('foo (bar). foo')
  end

  it 'does not add spaces before and after a colon between two numbers' do
    expect(processor.process('bar:12:21:56')).to eq('bar: 12:21:56')
  end

  it 'adds spaces around en dashes between words' do
    expect(processor.process("foo\u2013bar")).to eq("foo\u00a0\u2013 bar")
    expect(processor.process("foo \u2013bar")).to eq("foo\u00a0\u2013 bar")
    expect(processor.process("foo\u2013 bar")).to eq("foo\u00a0\u2013 bar")
  end

  it 'removes spaces around en dashes between numbers' do
    expect(processor.process("1000 \u2013 1500")).to eq("1000\u20131500")
  end

  it 'does not add a space after a comma used in a floating number' do
    expect(processor.process('as,30, 37,5')).to eq('as, 30, 37,5')
  end
end

describe 'Typrocessor::Replace::Es_ES::Quotes' do
  let(:processor) { Typrocessor::Processor.new(options) }
  let(:options) do { rules: [Typrocessor::Replace::Es_ES::Quotes] } end

  it 'replaces single quotes with typographic ones' do
    expect(processor.process("qu'es el morir")).to eq("qu\u2019es el morir")
  end

  it 'replaces double quotes around a sentence by typographic quotes' do
    expect(processor.process('Él me dijo, "Estoy muy feliz".')).to eq("Él me dijo, \u00abEstoy muy feliz\u00bb.")
    expect(processor.process('Él me dijo, " Estoy muy feliz ".')).to eq("Él me dijo, \u00ab Estoy muy feliz \u00bb.")
  end
end

describe 'Typrocessor::Replace::Es_ES::Currencies' do
  let(:processor) { Typrocessor::Processor.new(options) }
  let(:options) do { rules: [Typrocessor::Replace::Es_ES::Currencies] } end

  Typrocessor::Constants::CURRENCIES.keys.each do |char|
    it "replaces a simple space before #{char} a non-breaking one" do
      expect(processor.process("10 #{char}")).to eq("10\u00a0#{char}")
    end

    it "adds a non-breaking space before #{char} if there is no space" do
      expect(processor.process("10#{char}")).to eq("10\u00a0#{char}")
    end
  end
end
