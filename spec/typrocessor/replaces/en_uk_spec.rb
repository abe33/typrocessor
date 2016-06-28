require 'spec_helper'

describe 'Typrocessor::Replace::En_UK::Spaces' do
  let(:processor) { Typrocessor::Processor.new(options) }
  let(:options) do { rules: [Typrocessor::Replace::En_UK::Spaces] } end

  chars_with_space_after = [',', '.', "\u2026", '!', '?', ';', ':', '%', "\u2030", "\u2031"]
  chars_with_space_after.each do |char|
    it "adds a space after #{char} if there is no space" do
      expect(processor.process("Foo#{char}bar")).to eq("Foo#{char} bar")
    end

    it "does not add a space after #{char} if followed by a )" do
      expect(processor.process("(Foo#{char})")).to eq("(Foo#{char})")
    end
  end

  chars_with_no_space_before = [',', '.', "\u2026", '!', '?', ';', ':', '%', ')', "\u2019", "\u2030", "\u2031"]
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

  it "removes spaces after \u2019 only if it is preceded by a s" do
    expect(processor.process("ain\u2019 t no sunshine")).to eq("ain\u2019t no sunshine")
    expect(processor.process("sisters\u2019 bar")).to eq("sisters\u2019 bar")
    expect(processor.process("sister\u2019 s bar")).to eq("sister\u2019s bar")
  end

  it "removes a non-breaking space after \u2019" do
    expect(processor.process("ain\u2019\u00a0t no sunshine")).to eq("ain\u2019t no sunshine")
  end

  it 'adds a space before (' do
    expect(processor.process('bar(foo)')).to eq('bar (foo)')
  end

  it 'removes spaces after (' do
    expect(processor.process('( bar')).to eq('(bar')
    expect(processor.process('(  bar')).to eq('(bar')
  end

  it 'removes a non-breaking space after (' do
    expect(processor.process("(\u00a0bar")).to eq('(bar')
    expect(processor.process("(\u00a0\u00a0bar")).to eq('(bar')

    expect(processor.process("(\u202Fbar")).to eq('(bar')
    expect(processor.process("(\u202F\u202Fbar")).to eq('(bar')
  end

  it 'adds a space after a ) if the following char is not a punctuation' do
    expect(processor.process('foo (bar)foo')).to eq('foo (bar) foo')
    expect(processor.process('foo (bar). foo')).to eq('foo (bar). foo')
  end

  it 'removes spaces around em dashes' do
    expect(processor.process("foo \u2014 bar")).to eq("foo\u2014bar")
    expect(processor.process("foo\u2014 bar")).to eq("foo\u2014bar")
    expect(processor.process("foo \u2014bar")).to eq("foo\u2014bar")
  end

  it 'adds spaces around en dashes between words' do
    expect(processor.process("foo\u2013bar")).to eq("foo\u00a0\u2013 bar")
    expect(processor.process("foo \u2013bar")).to eq("foo\u00a0\u2013 bar")
    expect(processor.process("foo\u2013 bar")).to eq("foo\u00a0\u2013 bar")
  end

  it 'removes spaces around en dashes between numbers' do
    expect(processor.process("1000 \u2013 1500")).to eq("1000\u20131500")
  end

  it 'removes spaces inside quotation marks' do
    expect(processor.process("in \u201c Moby Dick \u201d")).to eq("in \u201cMoby Dick\u201d")
  end

  it 'does not add a space after a period used in a floating number' do
    expect(processor.process('as.30. 37.5')).to eq('as. 30. 37.5')
  end

  it 'does not add spaces before and after a colon between two numbers' do
    expect(processor.process('bar:12:21:56')).to eq('bar: 12:21:56')
  end

  honorifics = ['Mr', 'Mrs', 'Ms', 'Miss', 'Sir', 'Lady']
  honorifics.each do |honorific|
    it "adds a non-breaking space after #{honorific} followed by a name" do
      expect(processor.process("#{honorific} Smith")).to eq("#{honorific}\u00a0Smith")

      expect(processor.process("#{honorific} is served")).to eq("#{honorific} is served")
    end
  end
end

describe 'Typrocessor::Replace::En_UK::HTML' do
  let(:processor) { Typrocessor::Processor.new(options) }
  let(:options) do { rules: [Typrocessor::Replace::En_UK::HTML] } end

  it 'wraps ordinal number suffix in a ord span' do
    expect(processor.process('1st')).to eq('1<span class="ord">st</span>')
    expect(processor.process('2nd')).to eq('2<span class="ord">nd</span>')
    expect(processor.process('3rd')).to eq('3<span class="ord">rd</span>')
    expect(processor.process('4th')).to eq('4<span class="ord">th</span>')
    expect(processor.process('10th')).to eq('10<span class="ord">th</span>')
    expect(processor.process('21st')).to eq('21<span class="ord">st</span>')
  end
end
