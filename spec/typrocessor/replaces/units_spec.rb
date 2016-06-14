require 'spec_helper'

describe 'Typrocessor::Replace::Units' do
  let(:processor) { Typrocessor::Processor.new(options) }
  let(:options) do { rules: [Typrocessor::Replace::Units] } end

  Typrocessor::Constants::SURFACE_UNITS.each do |unit|
    it "replaces #{unit}2 by #{unit}²" do
      expect(processor.process("#{unit}2")).to eq("#{unit}²")
    end
  end

  Typrocessor::Constants::VOLUME_UNITS.each do |unit|
    it "replaces #{unit}3 by #{unit}³" do
      expect(processor.process("#{unit}3")).to eq("#{unit}³")
    end
  end

  Typrocessor::Constants::ALL_UNITS.each do |unit|
    it "adds a thin non-breaking space between a number and #{unit}" do
      expect(processor.process("10#{unit}")).to eq("10\u202f#{unit}")
      expect(processor.process("10 #{unit}")).to eq("10\u202f#{unit}")
      expect(processor.process("10 #{unit}, foo")).to eq("10\u202f#{unit}, foo")
      expect(processor.process("10 #{unit}.")).to eq("10\u202f#{unit}.")
      expect(processor.process("10 #{unit} bar")).to eq("10\u202f#{unit} bar")
      expect(processor.process("(10 #{unit})")).to eq("(10\u202f#{unit})")
      expect(processor.process("10 #{unit}foo")).to eq("10 #{unit}foo")
    end

    it "removes a period after #{unit} if not at the end of a sentence" do
      expect(processor.process("10\u202f#{unit}.")).to eq("10\u202f#{unit}.")
      expect(processor.process("10\u202f#{unit}. Foo")).to eq("10\u202f#{unit}. Foo")
      expect(processor.process("10\u202f#{unit}. Émile")).to eq("10\u202f#{unit}. Émile")
      expect(processor.process("10\u202f#{unit}. foo")).to eq("10\u202f#{unit} foo")
    end
  end
end
