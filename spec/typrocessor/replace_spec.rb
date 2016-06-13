require 'spec_helper'

describe Typrocessor::Replace do
  it 'raises an exception when created without neither replacement or a block' do
    expect { Typrocessor::Replace.new('foo', 'bar') }.to raise_error('Missing replacement argument or block in Replace.new')
  end
end
