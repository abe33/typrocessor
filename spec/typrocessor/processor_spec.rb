require 'spec_helper'

describe Typrocessor::Processor do
  let(:options) { Hash.new }
  let(:processor) { Typrocessor::Processor.new(options) }
  let(:replace) { Typrocessor::Replace.new('foobar', 'foo', 'bar') }
  let(:ignore) { Typrocessor::Ignore.new('in quotes', /"[^"]+"/) }

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
      { rules: [replace, ignore] }
    end

    it 'has a rules array filled with the provided rules' do
      expect(processor.rules).to eq([replace, ignore])
    end

    describe '#clean' do
      it 'returns nil when passed nil' do
        expect(processor.clean(nil)).to be_nil
      end

      it 'applies the rules on the passed-in string' do
        expect(processor.clean('foo "foo" foo')).to eql('bar "foo" bar')
      end
    end

    context 'containing an inverted ignore rule' do
      let(:ignore) { Typrocessor::Ignore.new('in quotes', /"[^"]+"/, true) }

      describe '#clean' do
        it 'applies the rules on the passed-in string' do
          expect(processor.clean('foo "foo" foo')).to eql('foo "bar" foo')
        end
      end
    end

    context 'containing a replace rule with a block' do
      let(:replace) do
        Typrocessor::Replace.new('foobar', 'foo') {|m| m[0] }
      end

      it 'calls the block proc to perform the replacement' do
        expect(processor.clean('foo "foo" foo')).to eql('f "foo" f')
      end
    end
  end
end
