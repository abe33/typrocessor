require 'spec_helper'

describe 'Typrocessor::Ignore::Markdown' do
  let(:processor) { Typrocessor::Processor.new(options) }
  let(:options) do
    {
      rules: [
        Typrocessor::Replace.new('foobar', 'foo', 'bar'),
        Typrocessor::Ignore::Markdown
      ]
    }
  end

  it 'preserves plain urls' do
    expect(processor.process('http://foo.com/foo.jpg')).to eq('http://foo.com/foo.jpg')
  end

  it 'preserves inline images' do
    expect(processor.process('![foo](http://foo.com/foo.jpg "foo")')).to eq('![bar](http://foo.com/foo.jpg "foo")')
    expect(processor.process('![foo] (http://foo.com/foo.jpg "foo")')).to eq('![bar] (http://foo.com/foo.jpg "foo")')
  end

  it 'preserves inline links', focus: true do
    expect(processor.process('[foo](http://foo.com/foo.jpg)')).to eq('[bar](http://foo.com/foo.jpg)')
    expect(processor.process('[foo] (http://foo.com/foo.jpg)')).to eq('[bar] (http://foo.com/foo.jpg)')
    expect(processor.process('[https://www.foofoofoofoo.fr/](https://www.foofoofoofoo.fr/)')).to eq('[https://www.foofoofoofoo.fr/](https://www.foofoofoofoo.fr/)')
    expect(processor.process('[%(foo) foo de foo foo] (/foo/link-with-hyphens)')).to eq('[%(bar) bar de bar bar] (/foo/link-with-hyphens)')
  end

  it 'preserves images with external definitions' do
    expect(processor.process('![foo][foo]')).to eq('![bar][foo]')
    expect(processor.process('![foo] [foo]')).to eq('![bar] [foo]')
    expect(processor.process('![foo][]')).to eq('![bar][]')
  end

  it 'preserves links with external definitions' do
    expect(processor.process('[foo][foo]')).to eq('[bar][foo]')
    expect(processor.process('[foo] [foo]')).to eq('[bar] [foo]')
    expect(processor.process('[foo][]')).to eq('[bar][]')
  end

  it 'preserves links definitions' do
    expect(processor.process("foo\n[foo]: http://foo.com/foo.jpg \"foo\"\nfoo")).to eq("bar\n[foo]: http://foo.com/foo.jpg \"foo\"\nbar")
    expect(processor.process("foo\n[foo]: http://foo.com/foo.jpg 'foo'\nfoo")).to eq("bar\n[foo]: http://foo.com/foo.jpg 'foo'\nbar")
    expect(processor.process("foo\n[foo]: http://foo.com/foo.jpg (foo)\nfoo")).to eq("bar\n[foo]: http://foo.com/foo.jpg (foo)\nbar")
  end

  it 'preserves content of inline code' do
    expect(processor.process('foo `foo` foo `foo` foo')).to eq('bar `foo` bar `foo` bar')
  end

  it 'preserves content of inline code with escaped backticks' do
    expect(processor.process('foo ``foo`foo`` foo ``foo`foo`` foo')).to eq('bar ``foo`foo`` bar ``foo`foo`` bar')
  end

  it 'preserves content of code block' do
    expect(processor.process("foo\n```\nfoo\n```\nfoo\n```\nfoo\n```\nfoo")).to eq("bar\n```\nfoo\n```\nbar\n```\nfoo\n```\nbar")
  end

  it 'preserves content of preformatted block' do
    expect(processor.process("foo\n\n    foo\n\nfoo")).to eq("bar\n\n    foo\n\nbar")
  end
end
