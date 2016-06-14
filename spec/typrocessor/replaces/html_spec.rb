require 'spec_helper'

describe 'Typrocessor::Replace::HTML' do
  let(:processor) { Typrocessor::Processor.new(options) }
  let(:options) do { rules: [Typrocessor::Replace::HTML] } end

  it 'wraps quotation marks in a span' do
    expect(processor.process("\u00abfoo\u00bb.")).to eq("<span class=\"dquo\">\u00ab</span>foo<span class=\"dquo\">\u00bb</span>.")
    expect(processor.process("\u201cfoo\u201d.")).to eq("<span class=\"dquo\">\u201c</span>foo<span class=\"dquo\">\u201d</span>.")
  end

  it 'wraps ampersand in a span' do
    expect(processor.process('&')).to eq('<span class="amp">&</span>')
    expect(processor.process('&amp;')).to eq('<span class="amp">&amp;</span>')
    expect(processor.process('&nbsp;')).to eq('&nbsp;')
  end

  it 'wraps capital letters in a span' do
    expect(processor.process('foo BAR foo')).to eq('foo <span class="caps">BAR</span> foo')
    expect(processor.process('B.A.R.')).to eq('<span class="caps">B.A.R.</span>')
  end
end
