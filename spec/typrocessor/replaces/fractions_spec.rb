require 'spec_helper'

describe 'Typrocessor::Replace::Fractions' do
  let(:processor) { Typrocessor::Processor.new(options) }
  let(:options) do { rules: [Typrocessor::Replace::Fractions] } end

  Typrocessor::Constants::FRACTIONS.each do |a,b,expected|
    it "replaces #{a}/#{b} with #{expected}" do
      expect(processor.process("#{a}/#{b}")).to eq(expected)
      expect(processor.process("#{a} / #{b}")).to eq(expected)
    end
  end
end
