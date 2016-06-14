require 'spec_helper'

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
