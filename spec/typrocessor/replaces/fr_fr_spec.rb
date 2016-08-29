require 'spec_helper'

describe 'Typrocessor::Replace::Fr_FR::Spaces' do
  let(:processor) { Typrocessor::Processor.new(options) }
  let(:options) do { rules: [Typrocessor::Replace::Fr_FR::Spaces] } end

  it 'replaces consecutive spaces with a single space' do
    expect(processor.process('Un    jour')).to eq('Un jour')
  end

  ['!', '?', ';', ':', '%', "\u2030", "\u2031"].each do |char|
    it "replaces a simple space before #{char} with a non-breaking one" do
      expect(processor.process("Foo #{char} bar")).to eq("Foo\u202F#{char} bar")
    end

    it "adds a non-breaking space before #{char} if there is no space" do
      expect(processor.process("Foo#{char}bar")).to eq("Foo\u202F#{char} bar")
    end
  end

  it 'adds a thin breaking space before a : with numbers before and text after' do
    expect(processor.process('Pour 2016 : pas de prévision')).to eq("Pour 2016\u202F: pas de prévision")
    expect(processor.process('Pour 2016: pas de prévision')).to eq("Pour 2016\u202F: pas de prévision")

    expect(processor.process("Pour 2016 : 50\u202F% de chance")).to eq("Pour 2016\u202F: 50\u202F% de chance")
    expect(processor.process("Pour 2016: 50\u202F% de chance")).to eq("Pour 2016\u202F: 50\u202F% de chance")
    expect(processor.process("Pour 2016 :50\u202F% de chance")).to eq("Pour 2016\u202F: 50\u202F% de chance")

    expect(processor.process("Pour le reste : 50\u202F% de chance")).to eq("Pour le reste\u202F: 50\u202F% de chance")
    expect(processor.process("Pour le reste :50\u202F% de chance")).to eq("Pour le reste\u202F: 50\u202F% de chance")
  end

  ['('].each do |char|
    it "adds a space before #{char} if there is no space" do
      expect(processor.process("Foo#{char}")).to eq("Foo #{char}")
    end
  end

  [',', '.', "\u2026"].each do |char|
    it "adds a space after #{char} if there is no space" do
      expect(processor.process("Foo#{char}bar")).to eq("Foo#{char} bar")
    end

    it "does not add a space after #{char} if followed by a )" do
      expect(processor.process("(Foo#{char})")).to eq("(Foo#{char})")
    end
  end

  it 'does not remove the space after a comma between two numbers' do
    expect(processor.process('Dans 20, 30 ou 50 ans')).to eq('Dans 20, 30 ou 50 ans')
  end

  ['!', '?', ';', ':', '%', "\u2030", "\u2031"].each do |char|
    it "adds a space after #{char} if there is no space" do
      expect(processor.process("Foo\u202f#{char}bar")).to eq("Foo\u202f#{char} bar")
    end

    it "does not add a space after #{char} if followed by a )" do
      expect(processor.process("(Foo\u202f#{char})")).to eq("(Foo\u202f#{char})")
    end
  end

  it 'adds a space after a ) if the following char is not a punctuation' do
    expect(processor.process('foo (bar)foo')).to eq('foo (bar) foo')
    expect(processor.process('foo (bar). foo')).to eq('foo (bar). foo')
  end

  [',', '.', ')', "\u2026", "\u2019"].each do |char|
    it "removes space before #{char}" do
      expect(processor.process("Foo #{char}")).to eq("Foo#{char}")
      expect(processor.process("Foo  #{char}")).to eq("Foo#{char}")
    end

    it "removes a non-breaking space before #{char}" do
      expect(processor.process("Foo\u00a0#{char}")).to eq("Foo#{char}")
      expect(processor.process("Foo\u00a0\u00a0#{char}")).to eq("Foo#{char}")

      expect(processor.process("Foo\u202F#{char}")).to eq("Foo#{char}")
      expect(processor.process("Foo\u202F\u202F#{char}")).to eq("Foo#{char}")
    end
  end

  it 'removes the space before a comma between two numbers if there is a space after the comma' do
    expect(processor.process('Dans 20 , 30 ou 50 ans')).to eq('Dans 20, 30 ou 50 ans')
  end

  it "removes spaces after \u2019" do
    expect(processor.process("foo\u2019 bar")).to eq("foo\u2019bar")
    expect(processor.process("foo\u2019\u00a0bar")).to eq("foo\u2019bar")
    expect(processor.process("foo\u2019\u202Fbar")).to eq("foo\u2019bar")

  end

  it 'removes spaces after (' do
    expect(processor.process('foo ( bar')).to eq('foo (bar')
    expect(processor.process("foo (\u00a0bar")).to eq('foo (bar')
    expect(processor.process("foo (\u202Fbar")).to eq('foo (bar')
  end

  it 'adds spaces inside typographic quotes' do
    expect(processor.process("Le \u00abChat Botté\u00bb.")).to eq("Le \u00ab\u202FChat Botté\u202F\u00bb.")
  end

  it 'does not add a space after a comma used in a floating number' do
    expect(processor.process('as,30, 37,5')).to eq('as, 30, 37,5')

  end

  it 'does not add spaces before and after a colon between two numbers' do
    expect(processor.process('bar:12:21:56')).to eq("bar\u202F: 12:21:56")

  end

  ['M.', 'MM.', 'Mme', 'Mmes', 'Mlle', 'Mlles', 'Dr', 'Mgr', 'Me'].each do |honorific|
    it "adds a non-breaking space after #{honorific} followed by a name" do
      expect(processor.process("#{honorific} Martin")).to eq("#{honorific}\u00a0Martin")

      expect(processor.process("#{honorific} est servi")).to eq("#{honorific} est servi")
    end
  end

  it 'adds spaces around en dashes between words' do
    expect(processor.process("foo\u2013bar")).to eq("foo\u00a0\u2013 bar")
    expect(processor.process("foo \u2013bar")).to eq("foo\u00a0\u2013 bar")
    expect(processor.process("foo\u2013 bar")).to eq("foo\u00a0\u2013 bar")
  end

  it 'removes spaces around en dashes between numbers' do
    expect(processor.process("1000 \u2013 1500")).to eq("1000\u20131500")
    expect(processor.process("1000\u2013 1500")).to eq("1000\u20131500")
    expect(processor.process("1000 \u20131500")).to eq("1000\u20131500")
  end
end

describe 'Typrocessor::Replace::Fr_FR::Currencies' do
  let(:processor) { Typrocessor::Processor.new(options) }
  let(:options) do { rules: [Typrocessor::Replace::Fr_FR::Currencies] } end

  Typrocessor::Constants::CURRENCIES.keys.each do |char|
    it "replaces a simple space before #{char} a non-breaking one" do
      expect(processor.process("10 #{char}")).to eq("10\u00a0#{char}")
    end

    it "adds a non-breaking space before #{char} if there is no space" do
      expect(processor.process("10#{char}")).to eq("10\u00a0#{char}")
    end
  end
end

describe 'Typrocessor::Replace::Fr_FR::Punctuations' do
  let(:processor) { Typrocessor::Processor.new(options) }
  let(:options) do { rules: [Typrocessor::Replace::Fr_FR::Punctuations] } end

  it "replace N° with N\u00ba" do
    expect(processor.process('N°')).to eq("N\u00ba")
  end

  it "replace n° with n\u00ba" do
    expect(processor.process('n°')).to eq("n\u00ba")

  end

  it 'replaces Mr. by M.' do
    expect(processor.process('Mr.')).to eq('M.')
  end

  it 'replaces Mr by M.' do
    expect(processor.process('Mr')).to eq('M.')
  end

  it "replaces a-t'il by a-t-il" do
    expect(processor.process("Y a-t'il")).to eq("Y a\u2011t\u2011il")
  end

  [
    'cad',
    'c-a-d',
    'c.-a-d.',
    'c.-a-d',
    'c-a-d.',
    'càd',
    'c-à-d',
    'c.-à-d',
    'c-à-d.'
  ].each do |form|
    it "replaces #{form} by c.-à-d." do
      expect(processor.process(form)).to eq("c.\u2011à\u2011d.")
    end
  end

  it 'replaces hyphen in sentences with dashes' do
    expect(processor.process('- foo - bar - foo-bar')).to eq("- foo \u2013 bar \u2013 foo-bar")
  end

  it 'replaces hyphen between numbers with dashes' do
    expect(processor.process('1000-1500')).to eq("1000\u20131500")
    expect(processor.process("1000\u20111500")).to eq("1000\u20131500")
  end

  it 'removes hyphen between anti and a word unless if it starts by a i or contains an hyphen' do
    expect(processor.process('anti-conformiste')).to eq('anticonformiste')
    expect(processor.process('anti-immigration')).to eq("anti-immigration")
    expect(processor.process('anti-sous-marin')).to eq("anti-sous-marin")
  end
end

describe 'Typrocessor::Replace::Fr_FR::Ordinals' do
  let(:processor) { Typrocessor::Processor.new(options) }
  let(:options) do { rules: [Typrocessor::Replace::Fr_FR::Ordinals] } end

  ordinals = [
    ['1ere', '1re'],
    ['1ère', '1re'],
    ['2eme', '2e'],
    ['2ème', '2e'],
    ['3eme', '3e'],
    ['3ème', '3e'],
    ['10ème', '10e'],
    ['1ères', '1res'],
    ['1eres', '1res'],
    ['2emes', '2es'],
    ['2èmes', '2es'],
    ['10emes', '10èmes']
  ]
  ordinals.each do |src,expected|
    it "replaces #{src} by #{expected}" do
      expect(processor.process(src)).to eq(expected)
    end
  end
end

describe 'Typrocessor::Replace::Fr_FR::Quotes' do
  let(:processor) { Typrocessor::Processor.new(options) }
  let(:options) do { rules: [Typrocessor::Replace::Fr_FR::Quotes] } end

  it 'replaces single quotes with typographic ones' do
    expect(processor.process("L'arbre")).to eq("L\u2019arbre")
  end

  it 'replaces double quotes around a sentence by typographic quotes' do
    expect(processor.process('Le "Chat Botté".')).to eq("Le \u00abChat Botté\u00bb.")
    expect(processor.process('Le " Chat Botté ".')).to eq("Le \u00ab Chat Botté \u00bb.")
  end
end

describe 'Typrocessor::Replace::Fr_FR::Dates' do
  let(:processor) { Typrocessor::Processor.new(options) }
  let(:options) do { rules: [Typrocessor::Replace::Fr_FR::Dates] } end

  daysAndMonths = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche', 'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Aout', 'Septembre', 'Octobre', 'Novembre', 'Décembre']

  daysAndMonths.each do |string|
    it "replaces #{string} with its lower case version" do
      expect(processor.process(string)).to eq(string.downcase)
    end
  end
end

describe 'Typrocessor::Replace::Fr_FR::Ligatures' do
  let(:processor) { Typrocessor::Processor.new(options) }
  let(:options) do { rules: [Typrocessor::Replace::Fr_FR::Ligatures] } end

  it "replaces oe with \u0153" do
    expect(processor.process('oeuf')).to eq("\u0153uf")
  end

  it "replaces Oe with \u0152" do
    expect(processor.process('Oeuf')).to eq("\u0152uf")
    expect(processor.process('OEuf')).to eq("\u0152uf")
  end

  it "replaces ae with \u00e6" do
    expect(processor.process('taenia')).to eq("t\u00e6nia")
  end

  it "replaces Ae with \u00c6" do
    expect(processor.process('TAENIA')).to eq("T\u00c6NIA")
  end
end
