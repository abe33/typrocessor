require 'spec_helper'

describe 'Typrocessor::Replace::Symbols' do
  let(:processor) { Typrocessor::Processor.new(options) }
  let(:options) do { rules: [Typrocessor::Replace::Symbols] } end

  it 'replaces (c) with ©' do
    expect(processor.process('(c)')).to eq('©')
    expect(processor.process('(C)')).to eq('©')
  end

  it 'replaces (r) with ®' do
    expect(processor.process('(r)')).to eq('®')
    expect(processor.process('(R)')).to eq('®')
  end

  it 'replaces TM with ™' do
    expect(processor.process('ATM TM')).to eq('ATM ™')
  end
end
