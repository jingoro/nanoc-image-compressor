require 'tempfile'
require 'nanoc/filters/image_compressor'

describe Nanoc::Filters::ImageCompressor do
  
  before do
    item = double('item')
    item.stub(:identifier) { '/test/' }
    item_rep = double('item_rep')
    item_rep.stub(:name) { 'image' }
    subject.assigns[:item] = item
    subject.assigns[:item_rep] = item_rep
  end
  
  let(:extension) { path.sub(/^.+\.([a-z]+)$/, '\1') }
  let(:output_size) { File.size subject.output_filename }
  
  def self.it_should_compress_to_less_than(max_size)

    it 'should compress implicitly' do
      subject.run path
      output_size.should be < max_size
    end

    it 'should compress explicitly' do
      subject.run path, :type => extension
      output_size.should be < max_size
    end

  end
  
  def self.it_should_not_compress

    it 'should pass through implicitly' do
      subject.run path
      output_size.should == File.size(path)
    end

    it 'should pass through explicitly' do
      subject.run path, :type => extension
      output_size.should == File.size(path)
    end

  end

  context 'jpg image' do
    let(:path) { File.expand_path '../test.jpg', __FILE__ }
    it_should_compress_to_less_than 300
  end

  context 'jpeg image' do
    let(:path) do
      file = Tempfile.new(['test', '.jpeg'])
      file.write File.read(File.expand_path('../test.jpg', __FILE__))
      file.close
      file.path
    end
    it_should_compress_to_less_than 300
  end
  
  context 'png image' do
    let(:path) { File.expand_path '../test.png', __FILE__ }
    it_should_compress_to_less_than 1900
  end

  context 'gif image' do
    let(:path) { File.expand_path '../test.gif', __FILE__ }
    it_should_not_compress
  end
  
  context 'text file' do
    let(:path) { __FILE__ }
    it_should_not_compress
  end
  
end
