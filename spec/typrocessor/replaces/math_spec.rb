require 'spec_helper'

describe 'Typrocessor::Replace::Math::Fractions' do
  let(:processor) { Typrocessor::Processor.new(options) }
  let(:options) do { rules: [Typrocessor::Replace::Math::Fractions] } end

  Typrocessor::Constants::FRACTIONS.each do |a,b,expected|
    it "replaces #{a}/#{b} with #{expected}" do
      expect(processor.process("#{a}/#{b}")).to eq(expected)
      expect(processor.process("#{a} / #{b}")).to eq(expected)
    end
  end
end

describe 'Typrocessor::Replace::Math::Primes' do
  let(:processor) { Typrocessor::Processor.new(options) }
  let(:options) do { rules: [Typrocessor::Replace::Math::Primes] } end

  it 'replaces quotes by primes' do
    expect(processor.process("5'6\"")).to eq("5\u20326\u2033")

    expect(processor.process("x' / x\"")).to eq("x\u2032 / x\u2033")
    expect(processor.process("a' + c\"")).to eq("a\u2032 + c\u2033")

    expect(processor.process("f\"")).to eq("f\u2033")
    expect(processor.process("f\''")).to eq("f\u2033")

    expect(processor.process("d\''' - e")).to eq("d\u2034 - e")

    expect(processor.process("d\'''' - e")).to eq("d\u2057 - e")
    expect(processor.process("d\"\" - e")).to eq("d\u2057 - e")
  end
end
