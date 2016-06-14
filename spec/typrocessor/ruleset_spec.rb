require 'spec_helper'

describe Typrocessor::Ruleset do
  describe '.create' do
    context 'with a name and a block' do
      it 'creates a named ruleset' do
        ruleset = Typrocessor::Ruleset.create('ruleset') do
          replace :foo, 'foo', 'bar'
          ignore :quotes, /"[^"]+"/
        end

        expect(ruleset).not_to be_nil
        expect(ruleset.name).to eq('ruleset')
        expect(ruleset.size).to eq(2)
      end
    end

    context 'with only a block' do
      it 'creates an anonymous ruleset' do
        ruleset = Typrocessor::Ruleset.create do
          replace :foo, 'foo', 'bar'
          ignore :quotes, /"[^"]+"/
        end

        expect(ruleset).not_to be_nil
        expect(ruleset.name).to be_nil
        expect(ruleset.size).to eq(2)
      end
    end
  end
end
