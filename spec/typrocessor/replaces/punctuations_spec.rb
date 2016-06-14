require 'spec_helper'

describe 'Typrocessor::Replace::Punctuations' do
  let(:processor) { Typrocessor::Processor.new(options) }
  let(:options) do { rules: [Typrocessor::Replace::Punctuations] } end

  tests = [
    ['Etc...', 'Etc.'],
    ["Etc\u2026", 'Etc.'],
    ['etc...', 'etc.'],
    ["etc\u2026", 'etc.']
  ]

  tests.each do |source, expected|
    it "replaces #{source} by #{expected}" do
      expect(processor.process(source)).to eq(expected)
    end
  end

  it 'replaces two or more ! with a single !' do
    expect(processor.process('Foo!!')).to eq('Foo!')
    expect(processor.process('Foo!!!')).to eq('Foo!')
    expect(processor.process('Foo!!!!')).to eq('Foo!')
  end

  it 'replaces two or more ? with a single ?' do
    expect(processor.process('Foo??')).to eq('Foo?')
    expect(processor.process('Foo???')).to eq('Foo?')
    expect(processor.process('Foo????')).to eq('Foo?')
  end

  it 'replaces three following dots with a proper ellipsis' do
    expect(processor.process('Foo...')).to eq("Foo\u2026")
  end

  it 'replaces a hyphen between two characters with a non-breaking hyphen' do
    expect(processor.process('foo-bar')).to eq("foo\u2011bar")
    expect(processor.process('foo - bar')).to eq('foo - bar')
    expect(processor.process('- bar')).to eq('- bar')
    expect(processor.process('foo -')).to eq('foo -')
  end
end
