require 'spec_helper'

describe 'Typrocessor::Replace::Spaces' do
  let(:processor) { Typrocessor::Processor.new(options) }
  let(:options) do { rules: [Typrocessor::Replace::Spaces] } end

  it 'replaces several consecutive spaces with a single one' do
    expect(processor.process('long    break')).to eq('long break')
  end
end
