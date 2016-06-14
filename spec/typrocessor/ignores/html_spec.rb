require 'spec_helper'

describe 'Typrocessor::Ignore::HTML' do
  let(:processor) { Typrocessor::Processor.new(options) }
  let(:options) do
    {
      rules: [
        Typrocessor::Replace.new('foobar', 'foo', 'bar'),
        Typrocessor::Ignore::HTML
      ]
    }
  end

  it 'preserves tag names' do
    expect(processor.clean('<foo>foo</foo>')).to eq('<foo>bar</foo>')
    expect(processor.clean('<foo foo="foo">foo</foo>')).to eq('<foo foo="foo">bar</foo>')
  end

  it 'preserves the content of pre tags' do
    expect(processor.clean('<pre>foo</pre> foo')).to eq('<pre>foo</pre> bar')
    expect(processor.clean('<pre class="pre">foo</pre> foo')).to eq('<pre class="pre">foo</pre> bar')
  end

  it 'preserves the content of code tags' do
    expect(processor.clean('<code>foo</code> foo')).to eq('<code>foo</code> bar')
    expect(processor.clean('<code class="code">foo</code> foo')).to eq('<code class="code">foo</code> bar')
  end

  it 'preserves the content of kbd tags' do
    expect(processor.clean('<kbd>foo</kbd> foo')).to eq('<kbd>foo</kbd> bar')
    expect(processor.clean('<kbd class="kbd">foo</kbd> foo')).to eq('<kbd class="kbd">foo</kbd> bar')
  end

  it 'preserves the content of style tags' do
    expect(processor.clean('<style>foo</style> foo')).to eq('<style>foo</style> bar')
    expect(processor.clean('<style class="style">foo</style> foo')).to eq('<style class="style">foo</style> bar')
  end

  it 'preserves the content of script tags' do
    expect(processor.clean('<script>foo</script> foo')).to eq('<script>foo</script> bar')
    expect(processor.clean('<script class="script">foo</script> foo')).to eq('<script class="script">foo</script> bar')
  end

  it 'preserves the content of textarea tags' do
    expect(processor.clean('<textarea>foo</textarea> foo')).to eq('<textarea>foo</textarea> bar')
    expect(processor.clean('<textarea class="textarea">foo</textarea> foo')).to eq('<textarea class="textarea">foo</textarea> bar')
  end
end
