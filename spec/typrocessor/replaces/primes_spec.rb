require 'spec_helper'

describe 'Typrocessor::Replace::Primes' do
  let(:processor) { Typrocessor::Processor.new(options) }
  let(:options) do { rules: [Typrocessor::Replace::Primes] } end

  it 'replaces quotes by primes when placed after numbers' do
    expect(processor.process("She's 5'6\" tall")).to eq("She's 5\u20326\u2033 tall")

    expect(processor.process("a 9\" nail")).to eq("a 9\u2033 nail")
    expect(processor.process("a 9\'' nail")).to eq("a 9\u2033 nail")

    expect(processor.process("9\'''")).to eq("9\u2034")

    expect(processor.process("9\''''")).to eq("9\u2057")
    expect(processor.process("9\"\"")).to eq("9\u2057")

    expect(processor.process("I Was Crushed By A 40' Man")).to eq("I Was Crushed By A 40\u2032 Man")
  end
end
