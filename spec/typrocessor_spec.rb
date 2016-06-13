require 'spec_helper'

describe Typrocessor do
  let(:options) { Hash.new }
  let(:processor) { Typrocessor.new(options) }
  let(:rule) { Rule.new('foobar', 'foo', 'bar') }
  let(:ignore) { Ignore.new('in quotes', /"[^"]+"/) }

  context 'created without rules' do
    it 'has an empty array of rules' do
      expect(processor.rules).to eq([])
    end

    describe '#clean' do
      it 'returns the passed-in string as is' do
        expect(processor.clean('foo "foo" foo')).to eql('foo "foo" foo')
      end
    end
  end

  context 'created with only ignore rules' do
    let(:options) do
      { rules: [ignore] }
    end

    describe '#clean' do
      it 'returns the passed-in string as is' do
        expect(processor.clean('foo "foo" foo')).to eql('foo "foo" foo')
      end
    end
  end

  context 'created with an array of rules' do
    let(:options) do
      { rules: [rule, ignore] }
    end

    it 'has a rules array filled with the provided rules' do
      expect(processor.rules).to eq([rule, ignore])
    end

    describe '#clean' do
      it 'returns nil when passed nil' do
        expect(processor.clean(nil)).to be_nil
      end

      it 'applies the rules on the passed-in string' do
        expect(processor.clean('foo "foo" foo')).to eql('bar "foo" bar')
      end
    end
  end
end
