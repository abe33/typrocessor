require 'spec_helper'

describe 'Typrocessor::Replace::LineBreaks' do
  let(:processor) { Typrocessor::Processor.new(options) }
  let(:options) do { rules: [Typrocessor::Replace::LineBreaks] } end

  it 'adds a non-breaking space after each word that is shorter than four characters' do
    expect(processor.process('a be foo door plate')).to eq("a\u00a0be\u00a0foo\u00a0door plate")
  end

  it 'adds a non-breaking space between a number and the word that follow' do
    expect(processor.process('1000 bears at 10. Foo')).to eq("1000\u00a0bears at\u00a010. Foo")
  end

  it 'adds a non-breaking space between the two last words of a paragraph' do
    expect(processor.process("Word word word word word.\nWord word word word word.\n\nWord word word word word.")).to eq("Word word word word\u00a0word.\nWord word word word\u00a0word.\n\nWord word word word\u00a0word.")
  end

  it 'adds a non-breaking space between the two last words of a paragraph event if one the two last word has an hyphen' do
    expect(processor.process("Word word word word word.\nWord word word word word.\n\nWord word word-word word.")).to eq("Word word word word\u00a0word.\nWord word word word\u00a0word.\n\nWord word word-word\u00a0word.")
    expect(processor.process("Word word word word word.\nWord word word word word.\n\nWord word word word-word.")).to eq("Word word word word\u00a0word.\nWord word word word\u00a0word.\n\nWord word word\u00a0word-word.")
  end
end
